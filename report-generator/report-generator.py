from flask import Flask
from flask import render_template
from flask import request
from flask import make_response
import requests
import pdfkit
from elasticsearch_dsl.connections import connections
from elasticsearch_dsl import Search, Q
import re

app = Flask(__name__, template_folder='templates')

def get_sudo_data(msg):
    data = {}
    data['user'], rest = [elem.strip() for elem in msg.split(':')]
    tty, pwd, sudouser, command = [elem.strip() for elem in rest.split(';')]
    data['tty'] = tty.split('=')[1].replace('\\','')
    data['pwd'] = pwd.split('=')[1].replace('\\','')
    data['sudouser'] = sudouser.split('=')[1]
    data['command'] = command.split('=')[1].replace('\\','')
    return data

def get_ssh_conn(coll):
    data = []
    connections = []
    disconnections = []
    for hit in coll:
        conn = re.compile('Accepted password for (.*) from (.*) port (.*) ssh2?')
        disc = re.compile('Disconnected from user (.*) (.*) port (.*)')
        m = conn.match(hit.msg.strip())
        if m:
            connections.append(m.groups() + (hit['@timestamp'],))
        else:
            m = disc.match(hit.msg.strip())
            if m:
                disconnections.append(m.groups() + (hit['@timestamp'],))

    for con in connections:
        con_data = {}
        con_data['user'] = con[0]
        con_data['ip'] = con[1]
        con_data['port'] = con[2]
        con_data['conndate'] = con[3]
        for disc in disconnections:
            if disc[0] == con_data['user'] and disc[1] == con_data['ip'] and disc[2] == con_data['port']:
                con_data['discdate'] = disc[3]
        data.append(con_data)
    return data


@app.route("/")
def hello():
    data = {}

    client = connections.create_connection(hosts=['https://elasticsearch:9200'], http_auth=('elastic', 'tfgelastic1920'), verify_certs=False)

    s = Search(using=client, index="inventory-*")
    s.aggs.bucket('hosts', 'terms', field='host.keyword')
    s = s.execute()
    data['hosts'] = s.aggregations.hosts.buckets

    for host in data['hosts']:
        # Clasificación
        s = Search(using=client, index="inventory-*")
        s = s.filter('term', host__keyword=host['key'])
        s.aggs.bucket('severities', 'terms', field='severity.keyword')
        s = s.execute()
        host['severities'] = s.aggregations.severities.buckets

        # Programas
        s = Search(using=client, index="inventory-*")
        s = s.filter('term', host__keyword=host['key'])
        s.aggs.bucket('programnames', 'terms', field='programname.keyword')
        s = s.execute()
        host['programnames'] = s.aggregations.programnames.buckets

        # Ejecuciones sudo
        s = Search(using=client, index="inventory-*")
        s = s.filter('term', host__keyword=host['key'])
        s = s.filter('term', programname__keyword='sudo')
        s = s.query('match', msg='COMMAND')
        total = s.count()
        s = s[0:total]
        s.execute()
        host['sudocommands'] = []
        for hit in s:
            sudo_data = get_sudo_data(hit.msg)
            sudocommand = {}
            sudocommand['date'] = hit['@timestamp']
            sudocommand['user'] = sudo_data['user']
            sudocommand['tty'] = sudo_data['tty']
            sudocommand['pwd'] = sudo_data['pwd']
            sudocommand['sudouser'] = sudo_data['sudouser']
            sudocommand['command'] = sudo_data['command']
            host['sudocommands'].append(sudocommand)

        # Conexiones ssh
        s = Search(using=client, index="inventory-*")
        s = s.filter('term', host__keyword=host['key'])
        s = s.filter('term', programname__keyword='sshd')
        total = s.count()
        s = s[0:total]
        s.execute()
        host['sshconn'] = get_ssh_conn(s)

    rendered = render_template('report.html', data=data)
    #return rendered
    # Need to install wkhtmltopdf
    pdf = pdfkit.from_string(rendered, False)

    response = make_response(pdf)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] = 'inline; filename=report.pdf'
    return response

if __name__ == '__main__':
    app.run(debug=True)
