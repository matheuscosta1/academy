<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
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

    <?php include "../../templates/private_header.html"; ?>
	
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