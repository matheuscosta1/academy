<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
	<script src="../../ajax/login.js"></script>
</head>
<body>

	<?php include "../../templates/public_header.html"; ?>

		
	<div class="align-login">
		<form name="formCadastro" id="user_form">
			<div class="modal-header">						
				<h4 class="modal-title">Login</h4>
			</div>
			<div class="form-floating form-group row">
					<input type="email" id="email" name="email" class="form-control" placeholder="E-mail" required>
					<label class="form-label">E-mail</label>
			</div><br>
			<div class="form-floating form-group row">
					<input type="password" id="senha" name="senha" class="form-control" placeholder="Senha" required>
					<label class="form-label">Senha</label>
			</div>	
			<div class="modal-footer">
				<input type="hidden" value="1" name="type">
				<button type="button" class="btn btn-success" id="btn-add">Login</button>
			</div>
		</form>
	</div>

</body>
</html>    