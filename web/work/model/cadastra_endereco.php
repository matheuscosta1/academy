<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        
        $cep = $logradouro = $bairro = $cidade = $estado = "";

        if (isset($_POST["cep"])) $cep=$_POST['cep'];
        if (isset($_POST["logradouro"])) $logradouro=$_POST['logradouro'];
        if (isset($_POST["bairro"])) $bairro=$_POST['bairro'];
        if (isset($_POST["cidade"])) $cidade=$_POST['cidade'];
        if (isset($_POST["estado"])) $estado=$_POST['estado'];
        
        $cep = htmlspecialchars($cep);
        $logradouro = htmlspecialchars($logradouro);
        $bairro = htmlspecialchars($bairro);
        $cidade = htmlspecialchars($cidade);
        $estado = htmlspecialchars($estado);

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
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}