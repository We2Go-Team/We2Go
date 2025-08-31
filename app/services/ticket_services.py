# app/services/ticket_service.py

from app.models.ticket import Ticket
from app.repositories.ticket_repository import TicketRepository


class TicketService:
    @staticmethod
    def synchronize_tickets_for_zone(zone_id, tickets_data):
        synchronized_tickets = []

        for ticket in tickets_data:
            ticket_id = ticket.get("id")
            metadata = ticket.get("metadata", {})
            print("ticket ", ticket)
            # DELETE
            if metadata.get("isDeleted"):
                if ticket_id:
                    TicketRepository.delete_ticket(ticket_id)
                continue

            # CREATE
            if metadata.get("isCreated"):
                new_ticket = Ticket(
                    zone_id=zone_id,
                    name=ticket.get("name"),
                    price=ticket.get("price", 0),
                    quantity=ticket.get("quantity", 0),
                )
                created_ticket = TicketRepository.create_ticket(new_ticket)
                synchronized_tickets.append({
                    "id": str(created_ticket.id),
                    "zone_id": str(created_ticket.zone_id),
                    "name": created_ticket.name,
                    "price": created_ticket.price,
                    "quantity": created_ticket.quantity,
                })
                continue

            # UPDATE
            if ticket_id and metadata.get("isUpdated"):
                update_data = {
                    "name": ticket.get("name"),
                    "price": ticket.get("price", 0),
                    "quantity": ticket.get("quantity", 0),
                }
                updated_ticket = TicketRepository.update_ticket(ticket_id, **update_data)
                if updated_ticket:
                    synchronized_tickets.append({
                        "id": str(updated_ticket.id),
                        "zone_id": str(updated_ticket.zone_id),
                        "name": updated_ticket.name,
                        "price": updated_ticket.price,
                        "quantity": updated_ticket.quantity,
                    })

        return synchronized_tickets

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


    