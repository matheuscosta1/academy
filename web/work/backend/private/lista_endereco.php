<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Clínica</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<link rel="stylesheet" href="../../css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="../../ajax/cadastra_funcionario.js"></script>
</head>

<?php

	session_start();
	if((!isset($_SESSION['email']) == true) and (!isset($_SESSION['senha']) == true))
	{
		header("location: error.php");
		unset($_SESSION['email']);
		unset($_SESSION['senha']);
	}

	$logado = $_SESSION['email'];
?>

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
				<li><button onclick="location.href='lista_todos_agendamentos.php'">Listar todos Agendamentos</button>|</li>
				<li><button onclick="location.href='lista_meus_agendamentos.php'">Listar meus Agendamentos</button></li>
            </ul>
        </section>
	</nav>
	
	<main class="container">
		<div class="table-responsive">
		<p id="success"></p>
			<div>
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>Listagem de <b>Endereços</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>CEP</th>
							<th>Logradouro</th>
							<th>Bairro</th>
							<th>Cidade</th>
							<th>Estado</th>
						</tr>
					</thead>
					<tbody>
					
					<?php
						$connection = connect();
						$result = $connection->prepare("SELECT * FROM clinica.endereco");
						$result->execute();
						while($row = $result->fetch(PDO::FETCH_ASSOC)){	
					?>
						<tr id="<?php echo $row->codigo; ?>">
							<td><?php echo $row['cep']; ?></td>
							<td><?php echo $row['logradouro']; ?></td>
							<td><?php echo $row['bairro']; ?></td>
							<td><?php echo $row['cidade']; ?></td>
							<td><?php echo $row['estado']; ?></td>
						</tr>
					<?php
					}
					?>
					</tbody>
				</table>
			</div>
		</div>
	</main>

</body>
</html>    