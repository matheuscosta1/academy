from django.contrib import admin
from .models import Tarefa
from .models import Evento
from .models import Setor
from. models import UsuarioTarefa

# Register your models here.
admin.site.register(Evento)
admin.site.register(Tarefa)
admin.site.register(Setor)
admin.site.register(UsuarioTarefa)