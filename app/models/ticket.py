# app/models/ticket.py

import uuid
from datetime import datetime
from app.config.database import db
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Enum, Numeric, Integer

from app.models.zone import Zone
import enum

class TicketTypeEnum(enum.Enum):
    REGULAR = "regular"
    VIP = "vip"


class Ticket(db.Model):
    __tablename__ = "tickets"

    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = db.Column(db.String(255), nullable=False)
    zone_id = db.Column(UUID(as_uuid=True), db.ForeignKey("zones.id"), nullable=False)
    type = db.Column(Enum(TicketTypeEnum), nullable=False)
    price = db.Column(Numeric(10, 2), nullable=False)
    quantity = db.Column(Integer, nullable=False)
    sold = db.Column(Integer, default=0, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Method để serialize
    def to_dict(self):
        return {
            "id": str(self.id),
            "name": self.name,
            "zone_id": str(self.zone_id),
            "zone_name": self.zone.name if self.zone else None,
            "type": self.type.value if hasattr(self.type, "value") else str(self.type),
            "price": float(self.price),
            "quantity": self.quantity,
            "sold": self.sold,
        }
