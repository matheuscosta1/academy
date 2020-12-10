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
							<h2>Listagem de <b>Pacientes</b></h2>
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
							<th>Peso</th>
							<th>Altura</th>
							<th>Tipo Sanguíneo</th>
						</tr>
					</thead>
					<tbody>
					
					<?php
						$connection = connect();
						$result = $connection->prepare("SELECT * FROM clinica.pessoa INNER JOIN paciente ON pessoa.codigo = paciente.paciente_codigo_fk");
						$result->execute();
						while($row = $result->fetch(PDO::FETCH_ASSOC)){	
					?>
						<tr id="<?php echo $row->codigo; ?>">
							<td><?php echo $row['codigo']; ?></td>
							<td><?php echo $row['nome']; ?></td>
							<td><?php echo $row['email']; ?></td>
							<td><?php echo $row['telefone']; ?></td>
							<td><?php echo $row['cep']; ?></td>
							<td><?php echo $row['logradouro']; ?></td>
							<td><?php echo $row['bairro']; ?></td>
							<td><?php echo $row['cidade']; ?></td>
							<td><?php echo $row['estado']; ?></td>
							<td><?php echo $row['peso']; ?></td>
							<td><?php echo $row['altura']; ?></td>
							<td><?php echo $row['tipo_sanguineo']; ?></td>
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