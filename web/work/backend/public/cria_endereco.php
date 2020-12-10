<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
	<script src="../../ajax/cadastra_endereco.js"></script>
</head>
<body>

	<?php include "../../templates/public_header.html"; ?>

	<main>
		
		<div id="addEmployeeModal" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Endereço</h4>
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<input type="number" id="cep" name="cep" class="form-control" placeholder="CEP" required>
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