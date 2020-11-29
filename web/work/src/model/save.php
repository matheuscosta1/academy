<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        $codigo=$_POST['codigo'];
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        $cep=$_POST['cep'];
        $logradouro=$_POST['logradouro'];
        $bairro=$_POST['bairro'];
        $cidade=$_POST['cidade'];
        $estado=$_POST['estado'];
		$sql = "INSERT INTO `pessoa`( `codigo`,`nome`, `email`,`telefone`,`cep`,`logradouro`,`bairro`,`cidade`,`estado`) 
		VALUES ('$codigo','$nome','$email','$telefone','$cep', '$logradouro','$bairro','$cidade','$estado')";
		if (mysqli_query($connection, $sql)) {
			echo json_encode(array("statusCode"=>200));
		} 
		else {
			echo "Error: " . $sql . "<br>" . mysqli_error($connection);
		}
		mysqli_close($connection);
	}
}
if(count($_POST)>0){
	if($_POST['type']==2){
        $codigo = $_POST['codigo'];
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        $cep=$_POST['cep'];
        $logradouro=$_POST['logradouro'];
        $bairro=$_POST['bairro'];
        $cidade=$_POST['cidade'];
        $estado=$_POST['estado'];
		$sql = "UPDATE `pessoa` SET `nome`='$nome',`email`='$email',`telefone`='$telefone',`cep`='$cep', `logradouro`='$logradouro', `bairro`='$bairro', `cidade`='$cidade', `estado`='$estado' WHERE codigo=$codigo";
		if (mysqli_query($connection, $sql)) {
			echo json_encode(array("statusCode"=>200));
		} 
		else {
			echo "Error: " . $sql . "<br>" . mysqli_error($connection);
		}
		mysqli_close($connection);
	}
}
if(count($_POST)>0){
	if($_POST['type']==3){
		$codigo=$_POST['codigo'];
		$sql = "DELETE FROM `pessoa` WHERE codigo='$codigo'";
		if (mysqli_query($connection, $sql)) {
			echo $codigo;
		} 
		else {
			echo "Error: " . $sql . "<br>" . mysqli_error($connection);
		}
		mysqli_close($connection);
	}
}
if(count($_POST)>0){
	if($_POST['type']==4){
		$codigo=$_POST['codigo'];
		$sql = "DELETE FROM pessoa WHERE codigo in ($codigo)";
		if (mysqli_query($connection, $sql)) {
			echo $codigo;
		} 
		else {
			echo "Error: " . $sql . "<br>" . mysqli_error($connection);
		}
		mysqli_close($connection);
	}
}

?>