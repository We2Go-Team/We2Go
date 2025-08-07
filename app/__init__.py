from flask import Flask
from app.config.database import mysql_config

def create_app():
    app = Flask(__name__)
    app.url_map.strict_slashes = False
    # Cấu hình MySQL
    mysql_config(app)
    app.secret_key = 'your-very-secret-key-123456789'
    # Cấu hình Routes
    from .routes import home, auth, events
    app.register_blueprint(home)
    app.register_blueprint(auth)
    app.register_blueprint(events)
    
    return app