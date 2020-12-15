<?php include '../../model/database_connection.php';?>
<?php

	session_start();
	if((!isset($_SESSION['email']) == true) and (!isset($_SESSION['senha']) == true))
	{
		header("location: error.php");
		unset($_SESSION['email']);
		unset($_SESSION['senha']);
	}

	$logado = $_SESSION['email'];
	$connection = connect();
	$sql = <<<SQL
	SELECT a.data_agendamento, a.horario, a.nome as paciente, a.email, a.telefone, p.nome as medico, m.especialidade FROM agenda a INNER JOIN medico m ON a.codigo_medico_fk = m.codigo inner join funcionario f on f.codigo = m.medico_codigo_fk inner join pessoa p on p.codigo = f.funcionario_codigo_fk where p.email = ?
	SQL;
	$result = $connection->prepare($sql);
	$result->bindValue(1, $logado);
	$result->execute();
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
</head>

<body>

    <?php include "../../templates/private_header.html"; ?>
	
	<main class="container">
		<div class="table-responsive">
		<p id="success"></p>
			<div>
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>Listagem dos meus <b>Agendamentos</b></h2>
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
						while($row = $result->fetch(PDO::FETCH_ASSOC)){	
							$codigo = htmlspecialchars($row->codigo);
							$dataAgendamento = htmlspecialchars($row['data_agendamento']);
							$horario = htmlspecialchars($row['horario']);
							$paciente = htmlspecialchars($row['paciente']);
							$email = htmlspecialchars($row['email']);
							$telefone = htmlspecialchars($row['telefone']);
							$medico = htmlspecialchars($row['medico']);
							$especialidade = htmlspecialchars($row['especialidade']);
							
							echo <<<HTML
								<tr $codigo>
								<td>$dataAgendamento</td>
								<td>$horario</td>
								<td>$paciente</td>
								<td>$email</td>
								<td>$telefone</td>
								<td>$medico</td>
								<td>$especialidade</td>
								</tr>
							HTML;
						}
					?>
					</tbody>
				</table>
			</div>
		</div>
	</main>

</body>
</html>    