<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
	<script src="../../ajax/cadastra_funcionario.js"></script>
	<script src="../../ajax/lista_enderecos_baseado_no_cep.js"></script>
</head>
<body>

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

	<?php include "../../templates/private_header.html"; ?>
	
	<main>
		<div id="addEmployeeModal" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Cadastrar Funcionário</h4>
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<select id="tipo-funcionario" name="tipo-funcionario" class="form-select">
									<option value="ATENDENTE">Atendente</option>
									<option value="ENFERMEIRO">Enfermeiro</option>
									<option value="MEDICO">Médico</option>
								</select>
								<label for="tipo-funcionario" class="form-label">Tipo de Funcionário</label>							
							</div><br>
							<div class="form-floating form-group row" id="hidden_especialidade" style="display: none;">
								<input type="text" name="especialidade" class="form-control" id="especialidade" placeholder="Especialidade">
								<label id="especialidade" for="especialidade" class="form-label">Especialidade</label><br>
							</div>
							<div class="form-floating form-group row" id="hidden_crm" style="display: none;">
								<input type="text" name="crm" class="form-control" id="especialidade" placeholder="CRM">
								<label id="crm" for="crm" class="form-label">CRM</label><br>
							</div>
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
								<input type="text" id="estado" name="estado" class="form-control" placeholder="Estado" min="2" max="2" required>
								<label class="form-label">Estado</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="datetime-local" id="data-contrato" name="data-contrato" class="form-control" placeholder="Data de contrato" required>
								<label class="form-label">Data do Contrato<label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="number" id="salario" name="salario" class="form-control" placeholder="Salário" required>
								<label class="form-label">Salário</label>
							</div><br>
							<div class="form-floating form-group row">
								<input type="password" id="senha" name="senha" class="form-control" placeholder="Senha" required>
								<label class="form-label">Senha</label>
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

		<script>
			window.onload=function(){
				document.getElementById('tipo-funcionario').addEventListener('change', function () {
					var style = this.value == 'MEDICO' ? 'block' : 'none';
					document.getElementById('hidden_especialidade').style.display = style;
					document.getElementById('hidden_crm').style.display = style;
				});
			}
		</script>
	</main>

</body>
</html>    