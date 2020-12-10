<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php include "../../templates/head.html"; ?>
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
	<div class="align-text-description">

		<h1>Seja bem vindo a área privada da Seleta Cosmos!</h1>
		<h2> Navegação </h2>
		<p> Navegue pela menu e tenha acesso às mais novas funcionalidades da clínica!</p>
		<h2> Registros </h2>
		<p>Cadastre funcionários e pacientes a partir de um formulário limpo e fácil de ser usado.</p>
		<h2> Visualização </h2>
		<p>Liste funcionários e pacientes, além de endereços previamente cadastrados na base.</p>
		<h2> Agendamentos </h2>
		<p>Liste todos os agendamentos disponíveis no sistema e também os seus agendamentos, caso seja um médico!</p>
	</div>
</body>
</html>    