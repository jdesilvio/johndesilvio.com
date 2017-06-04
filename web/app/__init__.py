from flask import Flask
from flask import render_template


app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


#def application(env, start_response):
#    start_response('200 OK', [('Content-Type', 'text/html')])
#    app.run()


if __name__ == '__main__':
    app.run()
