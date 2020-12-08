<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>User Data</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<link rel="stylesheet" href="../../css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="../../ajax/cadastra_funcionario.js"></script>
</head>
<body>
<header>
        <section>
            <h1>Clínica</h1>
        </section>
    </header>
    <nav>
        <section>
            <ul>
                <li><button onclick="location.href='cria_funcionario.php'"> </a> Novo Funcionário</button>|</li>
                <li><button onclick="location.href='cria_paciente.php'">Novo Paciente</button>|</li>
                <li><button onclick="location.href='lista_funcionario.php'">Listar Funcionários</button>|</li>
				<li><button onclick="location.href='lista_paciente.php'">Listar Pacientes</button>|</li>
				<li><button onclick="location.href='lista_endereco.php'">Listar Endereços</button>|</li>
				<li><button>Listar todos Agendamentos</button>|</li>
				<li><button>Listar meus Agendamentos</button></li>
            </ul>
        </section>
	</nav>
	<main>
		
		<div id="addEmployeeModal" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Funcionário</h4>
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<select id="tipo-funcionario" name="tipo-funcionario" class="form-select">
									<option value="ATENDENTE">Atendente</option>
									<option value="ENFERMEIRO">Enfermeiro</option>
									<option value="MEDICO">Médico</option>
								</select>
								<label for="tipo-funcionario" class="form-label">Tipo de Funcionário</label>							
							</div><br>
							<div class="form-floating form-group row" id="hidden_especialidade" style="display: none;">
								<input type="text" name="especialidade" class="form-control" id="especialidade" placeholder="Especialidade">
								<label id="especialidade" for="especialidade" class="form-label">Especialidade</label><br>
							</div>
							<div class="form-floating form-group row" id="hidden_crm" style="display: none;">
								<input type="number" name="crm" class="form-control" id="especialidade" placeholder="CRM">
								<label id="crm" for="crm" class="form-label">CRM</label><br>
							</div>
							<div class="form-floating form-group row">
								<input type="text" id="nome" name="nome" class="form-control" placeholder="Nome" required>
								<label for="nome" class="form-label">Nome</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="email" id="email" name="email" class="form-control" placeholder="E-mail" required>
								<label class="form-label">E-mail</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="phone" id="telefone" name="telefone" class="form-control" placeholder="Telefone" required>
								<label class="form-label">Telefone</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="text" id="cep" name="cep" class="form-control" placeholder="CEP" required>
								<label class="form-label">CEP</label>
							</div><br>	
							<div class="form-floating form-group row">
								<input type="text" id="logradouro" name="logradouro" class="form-control" placeholder="Logradouro" required>
								<label class="form-label">Logradouro</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="text" id="bairro" name="bairro" class="form-control" placeholder="Bairro" required>
								<label class="form-label">Bairro</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="text" id="cidade" name="cidade" class="form-control" placeholder="Cidade" required>
								<label class="form-label">Cidade</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="text" id="estado" name="estado" class="form-control" placeholder="Estado" required>
								<label class="form-label">Estado</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="date" id="data-contrato" name="data-contrato" class="form-control" placeholder="Data de contrato" required>
								<label class="form-label">Data do Contrato<label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="number" id="salario" name="salario" class="form-control" placeholder="Salário" required>
								<label class="form-label">Salário</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="password" id="senha" name="senha" class="form-control" placeholder="Senha" required>
								<label class="form-label">Senha</label>
							</div>				
						</div>
						<div class="modal-footer">
							<input type="hidden" value="1" name="type">
							<button type="button" class="btn btn-success" id="btn-add">Cadastrar</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<script>
			window.onload=function(){
				document.getElementById('tipo-funcionario').addEventListener('change', function () {
					var style = this.value == 'MEDICO' ? 'block' : 'none';
					document.getElementById('hidden_especialidade').style.display = style;
					document.getElementById('hidden_crm').style.display = style;
				});
			}
		</script>
	</main>

</body>
</html>    