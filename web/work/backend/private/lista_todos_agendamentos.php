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
							<h2>Listagem de <b>Agendamentos</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Data de Agendamento</th>
							<th>Horário</th>
							<th>Paciente</th>
							<th>E-mail</th>
							<th>Telefone</th>
							<th>Médico</th>
							<th>Especialidade</th>
						</tr>
					</thead>
					<tbody>
					
					<?php
						$connection = connect();
						$result = $connection->prepare("SELECT a.data_agendamento, a.horario, a.nome as paciente, a.email, a.telefone, p.nome as medico, m.especialidade FROM agenda a INNER JOIN medico m ON a.codigo_medico_fk = m.codigo inner join funcionario f on f.codigo = m.medico_codigo_fk inner join pessoa p on p.codigo = f.funcionario_codigo_fk");
						$result->execute();
						while($row = $result->fetch(PDO::FETCH_ASSOC)){	
					?>
						<tr id="<?php echo $row->codigo; ?>">
							<td><?php echo $row['data_agendamento']; ?></td>
							<td><?php echo $row['horario']; ?></td>
							<td><?php echo $row['paciente']; ?></td>
							<td><?php echo $row['email']; ?></td>
							<td><?php echo $row['telefone']; ?></td>
							<td><?php echo $row['medico']; ?></td>
							<td><?php echo $row['especialidade']; ?></td>
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