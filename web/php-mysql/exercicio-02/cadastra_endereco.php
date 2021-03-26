<?php
include 'model/database_connection.php';

$connection = connect();

if(count($_POST)>0){
	$cep=$_POST['cep'];
	$logradouro=$_POST['logradouro'];
	$bairro=$_POST['bairro'];
	$cidade=$_POST['cidade'];
	$estado=$_POST['estado'];

	try{
		$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		$stmt = $connection->prepare('INSERT INTO endereco (cep, logradouro, bairro, cidade, estado) values (:cep,:logradouro,:bairro,:cidade,:estado)');
		if(!$stmt->execute(array(
			':cep' => $cep,
			':logradouro' => $logradouro,
			':bairro' => $bairro,
			':cidade' => $cidade,
			':estado' => $estado,
		))) throw new Exception('Falha na primeira inserção');
		echo "Endereço inserido com sucesso!";
	} catch(PDOException $e) {
		echo 'Error: ' . $e->getMessage();
	}
}
?>