# app/services/category_service.py
from app.models.category import Category
from app.models.event import Event
from app.repositories.category_repository import CategoryRepository


class CategoryService:

    @staticmethod
    def create_category(data: dict):
        """
        Tạo mới category từ dict data
        data: {
            "name": str,
            "description": str (optional)
        }
        """
        category = Category(
            name=data.get("name"),
            description=data.get("description")
        )
        return CategoryRepository.create_category(category)

    @staticmethod
    def get_all_categories():
        """Lấy tất cả category, kèm events"""
        return CategoryRepository.get_all_categories(include_relationships=True)

    @staticmethod
    def get_category_by_id(category_id):
        """Lấy category theo ID"""
        return CategoryRepository.get_category_by_id(category_id, include_relationships=True)

    @staticmethod
    def get_category_by_name(name):
        """Lấy category theo tên"""
        return CategoryRepository.get_category_by_name(name, include_relationships=True)

    @staticmethod
    def update_category(category_id, data: dict):
        """Cập nhật category từ dict data"""
        return CategoryRepository.update_category(category_id, **data)

    @staticmethod
    def delete_category(category_id):
        """Xóa category"""
        return CategoryRepository.delete_category(category_id)

    @staticmethod
    def add_event_to_category(category_id, event: Event):
        """Thêm event vào category"""
        return CategoryRepository.add_event(category_id, event)

    @staticmethod
    def remove_event_from_category(category_id, event: Event):
        """Xóa event khỏi category"""
        return CategoryRepository.remove_event(category_id, event)

    @staticmethod
    def get_category_events(category_id):
        """Trả về danh sách tên event của category"""
        return CategoryRepository.get_category_events(category_id)

    @staticmethod
    def search_categories(keyword=None):
        """Tìm category theo keyword tên"""
        return CategoryRepository.search(keyword, include_relationships=True)
