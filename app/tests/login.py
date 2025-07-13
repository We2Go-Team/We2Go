import unittest
from app.dao import auth_user

class TestLogin(unittest.TestCase):
    def test_auth(self):
        self.assertTrue(auth_user("user1", "password"))
        self.assertTrue(auth_user("user2", "password"))
        self.assertFalse(auth_user("user3", "password"))
        self.assertFalse(auth_user("user1", "passwordd"))
