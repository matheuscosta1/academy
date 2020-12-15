<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
		
        $nome = $cpf = $email = $telefone = "";
        $cep = $logradouro = $bairro = "";
        $cidade = $estado = $peso = "";
        $altura = $tipoSanguineo = "";

        if (isset($_POST["nome"])) $nome=$_POST['nome'];
        if (isset($_POST["email"])) $email=$_POST['email'];
        if (isset($_POST["telefone"])) $telefone=$_POST['telefone'];
        if (isset($_POST["cep"])) $cep=$_POST['cep'];
        if (isset($_POST["logradouro"])) $logradouro=$_POST['logradouro'];
        if (isset($_POST["bairro"])) $bairro=$_POST['bairro'];
        if (isset($_POST["cidade"])) $cidade=$_POST['cidade'];
        if (isset($_POST["estado"])) $estado=$_POST['estado'];
        if (isset($_POST["peso"])) $peso=$_POST['peso'];
        if (isset($_POST["altura"])) $altura=$_POST['altura'];
        if (isset($_POST["tipo-sanguineo"])) $tipoSanguineo=$_POST['tipo-sanguineo'];

        $nome = htmlspecialchars($nome);
        $email = htmlspecialchars($email);
        $telefone = htmlspecialchars($telefone);
        $cep = htmlspecialchars($cep);
        $logradouro = htmlspecialchars($logradouro);
        $bairro = htmlspecialchars($bairro);
        $cidade = htmlspecialchars($cidade);
        $estado = htmlspecialchars($estado);
        $peso = htmlspecialchars($peso);
        $altura = htmlspecialchars($altura);
        $tipoSanguineo = htmlspecialchars($tipoSanguineo);        

        try{
            $connection->beginTransaction();
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
            $connection->commit();
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            $connection->rollBack();
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}