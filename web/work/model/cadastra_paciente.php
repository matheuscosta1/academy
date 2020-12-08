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
        $peso=$_POST['peso'];
        $altura=$_POST['altura'];
        $tipoSanguineo=$_POST['tipo-sanguineo'];

        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('INSERT INTO pessoa (nome, email, telefone, cep, logradouro, bairro, cidade, estado) values (:nome, :email,:telefone,:cep,:logradouro,:bairro,:cidade,:estado)');
            if(!$stmt->execute(array(
                ':nome' => $nome,
                ':email' => $email,
                ':telefone' => $telefone,
                ':cep' => $cep,
                ':logradouro' => $logradouro,
                ':bairro' => $bairro,
                ':cidade' => $cidade,
                ':estado' => $estado,
            ))) throw new Exception('Falha na primeira inserção');
            $idPaciente = $connection->lastInsertId();
            $stmt2 = $connection->prepare('INSERT INTO paciente (peso, altura, tipo_sanguineo, paciente_codigo_fk) values (:peso, :altura,:tipo_sanguineo,:paciente_codigo_fk)');
            if(!$stmt2->execute(array(
                ':peso' => $peso,
                ':altura' => $altura,
                ':tipo_sanguineo' => $tipoSanguineo,
                ':paciente_codigo_fk' => $idPaciente,
            ))) throw new Exception('Falha na segunda inserção');
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}