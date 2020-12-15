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
	SELECT * FROM 3635065_cosmos.pessoa INNER JOIN funcionario ON pessoa.codigo = funcionario.funcionario_codigo_fk
	SQL;
	$result = $connection->query($sql);
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
							<h2>Listagem de <b>Funcionários</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Código</th>
							<th>Nome</th>
							<th>Email</th>
							<th>Telefone</th>
							<th>CEP</th>
							<th>Logradouro</th>
							<th>Bairro</th>
							<th>Cidade</th>
							<th>Estado</th>
							<th>Data do Contrato</th>
							<th>Salário</th>
							<th>Senha</th>
						</tr>
					</thead>
					<tbody>
						<?php
							while($row = $result->fetch(PDO::FETCH_ASSOC)){
								$codigo = htmlspecialchars($row['codigo']);
								$nome = htmlspecialchars($row['nome']);
								$email = htmlspecialchars($row['email']);
								$telefone = htmlspecialchars($row['telefone']);
								$cep = htmlspecialchars($row['cep']);
								$logradouro = htmlspecialchars($row['logradouro']);
								$bairro = htmlspecialchars($row['bairro']);
								$cidade = htmlspecialchars($row['cidade']);
								$estado = htmlspecialchars($row['estado']);
								$dataContrato = htmlspecialchars($row['data_contrato']);
								$salario = htmlspecialchars($row['salario']);
								$senhaHash = htmlspecialchars($row['senha_hash']);

								echo <<<HTML
									<tr $codigo>
									<td>$codigo</td>
									<td>$nome</td>
									<td>$email</td>
									<td>$telefone</td>
									<td>$cep</td>
									<td>$logradouro</td>
									<td>$bairro</td>
									<td>$cidade</td>
									<td>$estado</td>
									<td>$dataContrato</td>
									<td>$salario</td>
									<td>$senhaHash</td>
									</tr>
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