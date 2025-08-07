# app/models/category.py
import uuid
from datetime import datetime
from app.config.database import db
from sqlalchemy.dialects.postgresql import UUID
from app.models.event_category import event_categories

class Category(db.Model):
    __tablename__ = "categories"

    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = db.Column(db.String(100), nullable=False, unique=True)
    description = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    events = db.relationship(
        "Event",
        secondary=event_categories,
        back_populates="categories"
    )
