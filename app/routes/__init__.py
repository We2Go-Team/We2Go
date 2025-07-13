from .home import home
from .auth import auth

def register_routes(app):
    app.register_blueprint(home)
    app.register_blueprint(auth)
