# app/services/event_service.py

from app.models.event import Event, EventStatus
from app.repositories.event_repository import EventRepository


class EventService:

    @staticmethod
    def get_lowest_ticket_price(event_id):
        lowest = EventRepository.get_lowest_ticket_price(event_id)
        return lowest if lowest else 0
    
    @staticmethod
    def create_event(data: dict):
        event = Event(
            title=data.get("title"),
            alias=data.get("alias"),
            description=data.get("description"),
            organizer_id=data.get("organizer_id"),
            time_start=data.get("time_start"),
            time_end=data.get("time_end"),
            location=data.get("location"),
            venue=data.get("venue"),
            images=data.get("images"),
            min_price=data.get("min_price", 0),
            status=data.get("status")  
        )
        return EventRepository.create_event(event)
    
    @staticmethod
    def get_all_events():
        return EventRepository.get_all_events(True)

    @staticmethod
    def get_event_by_alias(alias: str):
        return EventRepository.get_event_by_alias(alias)

    @staticmethod
    def get_event_by_id(event_id):
        return EventRepository.get_event_by_id(event_id)

    @staticmethod
    def update_event(event_id, data: dict):
        return EventRepository.update_event(event_id, **data)

    @staticmethod
    def delete_event(event_id):
        return EventRepository.delete_event(event_id)

    @staticmethod
    def publish_event(event_id):
        return EventRepository.update_event(event_id, status=EventStatus.PUBLISHED)

    @staticmethod
    def cancel_event(event_id):
        return EventRepository.update_event(event_id, status=EventStatus.CANCELLED)

    @staticmethod
    def search_events(keyword=None, location=None, price_range=None, category=None):
        return EventRepository.search(keyword, location, price_range, category)
    
    @staticmethod
    def get_event_categories(event_id):
        return EventRepository.get_event_categories(event_id)