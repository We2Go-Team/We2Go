from .home import home
from .auth import auth
from .tickets import tickets  
def register_routes(app):
    app.register_blueprint(home)
    app.register_blueprint(auth)
    app.register_blueprint(tickets)
