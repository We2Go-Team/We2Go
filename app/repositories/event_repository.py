from app.models import Event
from app.models import Zone
from app.models import Ticket

from app.models.category import Category
from app.config.database import db
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload


class EventRepository:

    @staticmethod
    def get_lowest_ticket_price(event_id):
        """Trả về giá vé thấp nhất trong tất cả zone của một sự kiện"""
        lowest_price = (
            db.session.query(func.min(Ticket.price))
            .join(Zone, Zone.id == Ticket.zone_id)
            .filter(Zone.event_id == event_id)
            .scalar()
        )

        print("repository: ", lowest_price)
        return lowest_price if lowest_price is not None else 0

    @staticmethod
    def create_event(event: Event):
        db.session.add(event)
        db.session.commit()
        return event

    @staticmethod
    def get_all_events(include_relationships=False):
        query = Event.query
        if include_relationships:
            # Load relationship "category" (1-1)
            query = query.options(joinedload(Event.category))
        return query.all()

    @staticmethod
    def get_event_by_id(event_id, include_relationships=False):
        query = Event.query
        if include_relationships:
            query = query.options(joinedload(Event.categories))
        return query.get(event_id)

    @staticmethod
    def get_event_by_alias(alias, include_relationships=False):
        query = Event.query.filter(func.lower(Event.alias) == alias.lower())
        if include_relationships:
            query = query.options(joinedload(Event.categories))
        return query.first()

    @staticmethod
    def get_event_by_location(location, include_relationships=False):
        query = Event.query.filter(func.lower(Event.location) == location.lower())
        if include_relationships:
            query = query.options(joinedload(Event.categories))
        return query.all()

    @staticmethod
    def delete_event(event_id):
        event = EventRepository.get_event_by_id(event_id)
        if event:
            db.session.delete(event)
            db.session.commit()
            return True
        return False

    @staticmethod
    def update_event(event_id, **kwargs):
        event = EventRepository.get_event_by_id(event_id)
        if event:
            for key, value in kwargs.items():
                if hasattr(event, key):
                    setattr(event, key, value)
            db.session.commit()
            return event
        return None

    @staticmethod
    def search(keyword=None, location=None, price_range=None, category=None, include_relationships=True):
        query = Event.query

        # Lọc theo từ khóa (title)
        if keyword:
            query = query.filter(Event.title.ilike(f"%{keyword}%"))

        # Lọc theo địa điểm hoặc venue (nếu không phải "toàn quốc")
        if location and location.lower() != "toàn quốc":
            query = query.filter(
                or_(
                    Event.location.ilike(f"%{location}%"),
                    # Event.venue.ilike(f"%{location}%")
                )
            )

        # Lọc theo giá tiền nếu không phải "all"
        if price_range and price_range != "all":
            if price_range == "under_1m":
                query = query.filter(Event.min_price < 1_000_000)
            elif price_range == "over_1m":
                query = query.filter(Event.min_price >= 1_000_000)

        # Lọc theo thể loại nếu không phải "all"
        if category and category != "all":
            query = query.join(Event.categories).filter(Category.name.ilike(f"%{category}%"))

        # Luôn load categories nếu cần
        if include_relationships:
            query = query.options(joinedload(Event.categories))

        return query.order_by(Event.time_start.asc()).all()

    @staticmethod
    def get_event_categories(event_id):
        """Trả về danh sách category name của 1 event"""
        event = EventRepository.get_event_by_id(event_id, include_relationships=True)
        if not event:
            return []
        return [cat.name for cat in event.categories]
