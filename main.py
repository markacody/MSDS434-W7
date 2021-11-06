from flask import Flask, render_template
from flask_bootstrap import Bootstrap

# Create an app instance and add bootstrap
app = Flask(__name__)
bootstrap = Bootstrap(app)


@app.route("/")
@app.route("/home")
@app.route("/index")
@app.route("/welcome")
def index():
    return render_template('index.html')


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@app.errorhandler(500)
def internal_server_error(e):
    return render_template('500.html'), 500


# Run the app if called from main
if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
