from django.db import models
from django.utils import timezone
from django_userforeignkey.models.fields import UserForeignKey
# Create your models here.

class Setor(models.Model):
    id_setor = models.AutoField(primary_key=True)
    nome_setor = models.CharField("Nome", max_length=20, null=True, blank=True)
    lider_setor = models.CharField("Lider", max_length=20, null=True, blank=True)
    projeto_nome = models.CharField("Projeto", max_length=20, null=True, blank=True)

    class Meta:
        managed = True
        db_table = 'setor'

    def __str__(self):
        return self.nome_setor

class Tarefa(models.Model):
    id_tarefa = models.AutoField(primary_key=True)
    id_setor = models.ForeignKey(Setor, on_delete=models.CASCADE, blank=True, null=True)
    nome_tarefa = models.CharField("Tarefa", max_length=20, null=True, blank=True)
    criador_tarefa = models.CharField("Criador",max_length=20, null=True, blank=True)
    duracao_tarefa = models.TimeField("Duração", blank=True, null=True)
    data_tarefa = models.DateField("Data", null=True)
    custo_tarefa = models.FloatField("Custo", blank=True, null=True)
    descricao_tarefa  = models.TextField("Descrição", max_length=300, null=True, blank=True)

    class Meta:
        managed = True
        db_table = 'tarefa'

    def __str__(self):
        return self.nome_tarefa

class Evento(models.Model):
    id_evento = models.AutoField(primary_key=True)
    id_tarefa = models.ForeignKey(Tarefa, on_delete=models.CASCADE)
    nome_evento = models.CharField("Nome", max_length=100, blank=True, null=True)
    criador_evento = models.CharField("Criador", max_length=100, blank=True, null=True)
    custos_evento = models.FloatField("Custo", blank=True, null=True)
    duracao_evento = models.TimeField("Duracao", blank=True, null=True)
    data_evento = models.DateField("Data", blank=True, null=True)
    descricao_evento = models.TextField("Descrição", max_length=300, null=True, blank=True)
    duracao_resultado = models.TimeField("Duracao", blank=True, null=True)
    custo_resultado = models.FloatField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'evento'
    
    def __str__(self):
        return self.nome_evento

class UsuarioTarefa(models.Model):
    id_pessoa = UserForeignKey(auto_user_add=True)
    id_tarefa = models.ForeignKey(Tarefa, on_delete=models.CASCADE)

    class Meta:
        managed = True
        db_table = 'usuario_tarefa'
    
    def __str__(self):
        return self.id_pessoa, self.id_tarefa