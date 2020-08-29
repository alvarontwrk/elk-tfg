from flask import Flask
from flask import render_template
from flask import request
app = Flask(__name__, template_folder='templates')


@app.route("/")
def hello():
    data = {}
    data.host = 'test'
    rendered = render_template('report.html', data=data)
    return rendered
