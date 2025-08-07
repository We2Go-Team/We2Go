import re
import unicodedata

def slugify(text):
    text = text.replace('đ', 'd').replace('Đ', 'd')
    text = unicodedata.normalize('NFD', text)
    text = text.encode('ascii', 'ignore').decode('utf-8')
    text = re.sub(r'[^\w\s-]', '', text).lower()
    text = re.sub(r'[\s_-]+', '-', text).strip('-')
    return text