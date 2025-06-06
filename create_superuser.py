import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'giftlist_project.settings')
django.setup()

from django.contrib.auth.models import User

# Verifique se o superusuário já existe
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'erbertt@gmail.com', 'NandoComedy1!')
    print("Superusuário 'erbertt' criado com sucesso!")
else:
    print("Superusuário 'admin' já existe.")
