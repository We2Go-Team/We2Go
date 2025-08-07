# app/models/event_category.py
from app.config.database import db
import uuid
from sqlalchemy.dialects.postgresql import UUID
from datetime import datetime

event_categories = db.Table(
    "event_categories",
    db.Column("event_id", UUID(as_uuid=True), db.ForeignKey("events.id"), primary_key=True),
    db.Column("category_id", UUID(as_uuid=True), db.ForeignKey("categories.id"), primary_key=True),
    db.Column("created_at", db.DateTime, default=datetime.utcnow),
    db.Column("updated_at", db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow),
)
