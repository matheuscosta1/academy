<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        $cep=$_POST['cep'];
        $logradouro=$_POST['logradouro'];
        $bairro=$_POST['bairro'];
        $cidade=$_POST['cidade'];
        $estado=$_POST['estado'];
        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('INSERT INTO pessoa (nome, email, telefone, cep, logradouro, bairro, cidade, estado) values (:nome, :email,:telefone,:cep,:logradouro,:bairro,:cidade,:estado)');
            $stmt->execute(array(
                ':nome' => $nome,
                ':email' => $email,
                ':telefone' => $telefone,
                ':cep' => $cep,
                ':logradouro' => $logradouro,
                ':bairro' => $bairro,
                ':cidade' => $cidade,
                ':estado' => $estado,
            ));
        echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}
if(count($_POST)>0){
	if($_POST['type']==2){
        $codigo=$_POST['codigo'];
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        $cep=$_POST['cep'];
        $logradouro=$_POST['logradouro'];
        $bairro=$_POST['bairro'];
        $cidade=$_POST['cidade'];
        $estado=$_POST['estado'];
        
        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('UPDATE pessoa SET nome = :nome, email = :email, telefone = :telefone, cep = :cep, logradouro = :logradouro, bairro = :bairro, cidade = :cidade, estado = :estado where codigo = :codigo');
            $stmt->execute(array(
                ':codigo' => $codigo,
                ':nome' => $nome,
                ':email' => $email,
                ':telefone' => $telefone,
                ':cep' => $cep,
                ':logradouro' => $logradouro,
                ':bairro' => $bairro,
                ':cidade' => $cidade,
                ':estado' => $estado,
            ));
        echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
	}
}
if(count($_POST)>0){
	if($_POST['type']==3){
		$codigo=$_POST['codigo'];
        
        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('DELETE FROM pessoa WHERE codigo= :codigo');
            $stmt->bindParam(':codigo', $codigo);
            $stmt->execute();
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
	}
}


?>