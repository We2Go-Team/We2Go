import uuid
from app.config.database import db
from sqlalchemy.dialects.mysql import ENUM

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    first_name = db.Column(db.String(100))
    last_name = db.Column(db.String(100))
    avatar = db.Column(db.String(255))
    email = db.Column(db.String(255), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    avatar = db.Column(db.String(255))
    phone = db.Column(db.String(20), nullable=False)
    role = db.Column(ENUM('USER', 'ADMIN'), default='USER')
    type = db.Column(ENUM('PERSONAL', 'ORGANIZATION'), default='PERSONAL')
    sessions_key = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, server_default=db.func.now())
    updated_at = db.Column(db.DateTime, server_default=db.func.now(), onupdate=db.func.now())