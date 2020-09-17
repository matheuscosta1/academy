from behave import step
from calc import soma

@step('somar "{val_0:d}" com "{val_1:d}"')
def test_soma(context, val_0, val_1):
    context.result = soma(val_0, val_1)

@step('o resultado deve ser "{resultado:d}"')
def test_soma_result(context, resultado):
    assert context.result == resultado

