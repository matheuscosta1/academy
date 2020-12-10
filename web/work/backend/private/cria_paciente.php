<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
	<script src="../../ajax/cadastra_paciente.js"></script>
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

	<main>	
		<div id="addEmployeeModal">
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Paciente</h4>
						</div>
						<div class="modal-body">
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
								<input type="number" step=0.01 id="peso" name="peso" class="form-control" placeholder="Peso" required>
								<label class="form-label">Peso<label>
							</div><br>
							<div class="form-floating form-group row">
								<input type=number step=0.01 id="altura" name="altura" class="form-control" placeholder="Altura" required>
								<label class="form-label">Altura</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="text" id="tipo-sanguineo" name="tipo-sanguineo" class="form-control" placeholder="Tipo Sanguíneo" required>
								<label class="form-label">Tipo Sanguíneo</label>
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