from flask import Flask
from app.config.database import mysql_config
from flask_ckeditor import CKEditor
import cloudinary
import cloudinary.uploader
import cloudinary.api


def create_app():
    app = Flask(__name__)
    app.url_map.strict_slashes = False
    
    # Cấu hình ckeditor 
    ckeditor = CKEditor(app)
    # Cấu hình Cloundinary for images store
    cloudinary.config(
        cloud_name="dtzbyruu1",
        api_key="282683918642998",
        api_secret="cpROIUh-iNWRTZvr94tMxOF2vmw",
        secure=True,
    )
    # Cấu hình MySQL
    mysql_config(app)
    app.secret_key = "your-very-secret-key-123456789"
    # Cấu hình Routes
    from .routes import register_routes
    register_routes(app)
    return app
