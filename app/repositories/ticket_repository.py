# app/repositories/ticket_repository.py

from app.models.ticket import Ticket
from app.config.database import db
from sqlalchemy import func


class TicketRepository:
    @staticmethod
    def create_ticket(ticket: Ticket):
        """Thêm một ticket mới"""
        db.session.add(ticket)
        db.session.commit()
        return ticket

    @staticmethod
    def get_all_tickets():
        """Lấy tất cả ticket"""
        return Ticket.query.all()

    @staticmethod
    def get_ticket_by_id(ticket_id):
        """Lấy ticket theo id"""
        return Ticket.query.get(ticket_id)

    @staticmethod
    def get_tickets_by_zone(zone_id):
        """Lấy tất cả ticket theo zone"""
        return Ticket.query.filter(Ticket.zone_id == zone_id).all()

    @staticmethod
    def update_ticket(ticket_id, **kwargs):
        """Cập nhật ticket theo id"""
        ticket = TicketRepository.get_ticket_by_id(ticket_id)
        if ticket:
            for key, value in kwargs.items():
                if hasattr(ticket, key):
                    setattr(ticket, key, value)
            db.session.commit()
            return ticket
        return None

    @staticmethod
    def delete_ticket(ticket_id):
        """Xóa ticket theo id"""
        ticket = TicketRepository.get_ticket_by_id(ticket_id)
        if ticket:
            db.session.delete(ticket)
            db.session.commit()
            return True
        return False

    @staticmethod
    def search_tickets(zone_id=None, ticket_type=None, keyword=None):
        """Tìm kiếm ticket theo zone, type hoặc keyword"""
        query = Ticket.query

        if zone_id:
            query = query.filter(Ticket.zone_id == zone_id)

        if ticket_type:
            query = query.filter(Ticket.type == ticket_type)

        if keyword:
            query = query.filter(Ticket.name.ilike(f"%{keyword}%"))

        return query.order_by(Ticket.name.asc()).all()
