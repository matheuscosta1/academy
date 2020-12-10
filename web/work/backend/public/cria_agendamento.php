<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
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
									$connection = connect();
									$result = $connection->prepare("SELECT especialidade FROM clinica.medico group by especialidade");
									$result->execute();
									while($row = $result->fetch(PDO::FETCH_ASSOC)){	
								?>
									<option name=<?php echo $row['especialidade']; ?> value=<?php echo $row['especialidade']; ?>><?php echo $row['especialidade']; ?></option>
								<?php
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