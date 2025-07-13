from app.models.user import User
from app.config.database import db
from sqlalchemy import func

def create_user(user: User):
    db.session.add(user)
    db.session.commit()
    return user

def get_all_users():
    return User.query.all()

def get_user_by_id(user_id):
    return User.query.get(user_id)

def get_user_by_email(email):
    return User.query.filter(func.lower(User.email) == email.lower()).first()

def get_user_by_phone(phone):
    return User.query.filter(func.lower(User.phone) == phone.lower()).first()
