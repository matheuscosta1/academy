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
	SELECT * FROM 3635065_cosmos.endereco
	SQL;
	$result = $connection->query($sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
	<script src="../../ajax/cadastra_funcionario.js"></script>
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
							<h2>Listagem de <b>Endereços</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>CEP</th>
							<th>Logradouro</th>
							<th>Bairro</th>
							<th>Cidade</th>
							<th>Estado</th>
						</tr>
					</thead>
					<tbody>
						<?php
							while($row = $result->fetch(PDO::FETCH_ASSOC)){
								$codigo = htmlspecialchars($row->codigo);
								$cep = htmlspecialchars($row['cep']);
								$logradouro = htmlspecialchars($row['logradouro']);
								$bairro = htmlspecialchars($row['bairro']);
								$cidade = htmlspecialchars($row['cidade']);
								$estado = htmlspecialchars($row['estado']);

								echo <<<HTML
									<tr $codigo>
									<td>$cep</td>
									<td>$logradouro</td>
									<td>$bairro</td>
									<td>$cidade</td>
									<td>$estado</td>
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