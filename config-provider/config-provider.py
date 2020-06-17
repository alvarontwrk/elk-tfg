from flask import Flask
from flask import render_template
from flask import request
app = Flask(__name__, template_folder='config')


@app.route("/")
def hello():
    return 'Hello world from {}'.format(request.host.split(':')[0])


@app.route('/client')
def return_client_config():
    try:
        host = request.host.split(':')[0]
        return render_template('client.sh', host=host)
    except Exception as e:
        return str(e)


@app.route('/server')
def return_server_config():
    try:
        return render_template('server.sh')
    except Exception as e:
        return str(e)
