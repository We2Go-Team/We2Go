# app/models/zone.py

import uuid
from datetime import datetime
from app.config.database import db
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Enum
from app.models.ticket import Ticket
from app.models.event import Event

class ZoneTypeEnum(str, Enum):
    STANDING = "standing"
    SEATED = "seated"
    VIP = "vip"

class Zone(db.Model):
    __tablename__ = "zones"

    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    event_id = db.Column(UUID(as_uuid=True), db.ForeignKey("events.id"), nullable=False)
    name = db.Column(db.String(255), nullable=False)
    type = db.Column(Enum(ZoneTypeEnum), nullable=False)
    description = db.Column(db.Text, nullable=True)
    capacity = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    event = db.relationship("Event", backref=db.backref("zones", lazy="dynamic"))
    tickets = db.relationship("Ticket", backref="zone", lazy="dynamic", cascade="all, delete-orphan")

    # Method để serialize
    def to_dict(self):
        return {
            "id": str(self.id),
            "name": self.name,
            "type": self.type.value if hasattr(self.type, "value") else str(self.type),
            "description": self.description,
            "capacity": self.capacity,
            "event_id": str(self.event_id),
            "tickets_count": self.tickets.count()
        }
