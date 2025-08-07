# app/models/event.py
import uuid
from datetime import datetime
from app.config.database import db
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Enum, event
import enum
from app.models.event_category import event_categories
from app.utils import slugify


class EventStatus(enum.Enum):
    UPCOMING = "Upcoming"
    ONGOING = "Ongoing"
    COMPLETED = "Completed"
    CANCELLED = "Cancelled"

class Event(db.Model):
    __tablename__ = "events"

    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=True)
    organizer_id = db.Column(UUID(as_uuid=True), db.ForeignKey("users.id"), nullable=False)
    time_start = db.Column(db.DateTime, nullable=False)
    time_end = db.Column(db.DateTime, nullable=False)
    location = db.Column(db.String(255), nullable=True)
    venue = db.Column(db.String(255), nullable=True)
    status = db.Column(Enum(EventStatus), nullable=False, default=EventStatus.UPCOMING)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    min_price = db.Column(db.Float, nullable=True)
    alias = db.Column(db.String(255), unique=True, nullable=False)
    images = db.Column(db.Text, nullable=True) 
    categories = db.relationship(
        "Category",
        secondary=event_categories,
        back_populates="events"
    )


@event.listens_for(Event, 'before_insert')
def generate_alias(mapper, connection, target):
    if not target.alias and target.title:
        target.alias = slugify(target.title)

@event.listens_for(Event, 'before_update')
def update_alias(mapper, connection, target):
    if target.title:
        target.alias = slugify(target.title)