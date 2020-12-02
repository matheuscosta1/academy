<?php include 'model/database_connection.php';?>
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="ajax/ajax.js"></script>
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
                <li><button>Novo Paciente</button>|</li>
                <li><button onclick="location.href='index.php'">Listar Funcionários</button>|</li>
				<li><button>Listar Pacientes</button>|</li>
				<li><button>Listar Endereços</button>|</li>
				<li><button>Listar todos Agendamentos</button>|</li>
				<li><button>Listar meus Agendamentos</button></li>
            </ul>
        </section>
	</nav>
	<main>
		
		<!-- Add Modal HTML -->
		<div id="addEmployeeModal" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Funcionário</h4>
						</div>
						<div class="modal-body">

							<div class="form-group">
								<label>Nome</label>
								<input type="text" id="nome" name="nome" class="form-control" required>
							</div>
							<div class="form-group">
								<label>E-mail</label>
								<input type="email" id="email" name="email" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Telefone</label>
								<input type="phone" id="telefone" name="telefone" class="form-control" required>
							</div>
							<div class="form-group">
								<label>CEP</label>
								<input type="text" id="cep" name="cep" class="form-control" required>
							</div>	
							<div class="form-group">
								<label>Logradouro</label>
								<input type="text" id="logradouro" name="logradouro" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Bairro</label>
								<input type="text" id="bairro" name="bairro" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Cidade</label>
								<input type="text" id="cidade" name="cidade" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Estado</label>
								<input type="text" id="estado" name="estado" class="form-control" required>
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
	</main>

</body>
</html>    