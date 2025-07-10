from .home import home
def register_routes(app):
    app.register_blueprint(home)
