<?php include '../../model/database_connection.php';?>

<?php

	$connection = connect();
	$sql = <<<SQL
	SELECT especialidade FROM 3635065_cosmos.medico group by especialidade
	SQL;
	$result = $connection->query($sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Seleta Cosmos</title>
	<link rel="icon" href="../../images/icone.png">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<link rel="stylesheet" href="../../css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="../../ajax/cadastra_agendamento.js"></script>
	<script src="../../ajax/lista_medicos_por_especialidade.js"></script>
	<script src="../../ajax/lista_horarios_disponiveis_para_consulta.js"></script>
</head>
<body>

	<?php include "../../templates/public_header.html"; ?>

	<main>
		
		<div id="addEmployeeModal" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Agendamento</h4>
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<select id="especialidade" name="especialidade" class="form-select">
								<option selected disabled>Especialidade</option>

								<?php
									while($row = $result->fetch(PDO::FETCH_ASSOC)){
										$especialidade = htmlspecialchars($row['especialidade']);

										echo <<<HTML
											<option name=$especialidade value=$especialidade> $especialidade </option>
										HTML;
									}	
								?>

								</select>
								<label for="especialidade" class="form-label">Especialidades</label>							
							</div><br>
							<div id="mostra_medicos" class="form-floating form-group row">
								<select id="codigo_medico" name="codigo_medico" class="form-select">
									<option selected disabled>Médico</option>
								</select>
								<label for="medico" class="form-label">Médicos</label>							
							</div><br>
							<div class="form-floating form-group row">
								<input type="date" id="data-agendamento" name="data-agendamento" class="form-control" placeholder="Data da consulta" required>
								<label class="form-label">Data da consulta<label>
							</div><br>
							<div id="mostra_horarios" class="form-floating form-group row">
								<select id="horario" name="horario" class="form-select">
									<option selected disabled>Horários</option>
								</select>
								<label for="horario" class="form-label">Horários</label>							
							</div><br>
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