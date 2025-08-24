# app/services/ticket_service.py

from app.models.ticket import Ticket
from app.repositories.ticket_repository import TicketRepository


class TicketService:
    @staticmethod
    def create_ticket(ticket: Ticket):
        return TicketRepository.create_ticket(ticket)

    @staticmethod
    def get_all_tickets():
        return TicketRepository.get_all_tickets()

    @staticmethod
    def get_ticket_by_id(ticket_id):
        return TicketRepository.get_ticket_by_id(ticket_id)

    @staticmethod
    def get_tickets_by_zone(zone_id):
        return TicketRepository.get_tickets_by_zone(zone_id)

    @staticmethod
    def update_ticket(ticket_id, data: dict):
        return TicketRepository.update_ticket(ticket_id, **data)

    @staticmethod
    def delete_ticket(ticket_id):
        return TicketRepository.delete_ticket(ticket_id)

    @staticmethod
    def search_tickets(zone_id=None, ticket_type=None, keyword=None):
        return TicketRepository.search_tickets(zone_id, ticket_type, keyword)


    