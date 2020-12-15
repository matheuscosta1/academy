<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){

        $tipoFuncionario = $nome = $email = $telefone = $cep = $logradouro = "";
        $bairro = $cidade = $estado = $dataContrato = $salario = $senha = "";

        if (isset($_POST["tipo-funcionario"])) $tipoFuncionario=$_POST['tipo-funcionario'];
        if (isset($_POST["nome"])) $nome=$_POST['nome'];
        if (isset($_POST["email"])) $email=$_POST['email'];
        if (isset($_POST["telefone"])) $telefone=$_POST['telefone'];
        if (isset($_POST["cep"])) $cep=$_POST['cep'];
        if (isset($_POST["logradouro"])) $logradouro=$_POST['logradouro'];
        if (isset($_POST["bairro"])) $bairro=$_POST['bairro'];
        if (isset($_POST["cidade"])) $cidade=$_POST['cidade'];
        if (isset($_POST["estado"])) $estado=$_POST['estado'];
        if (isset($_POST["data-contrato"])) $dataContrato=$_POST['data-contrato'];
        if (isset($_POST["salario"])) $salario=$_POST['salario'];
        if (isset($_POST["senha"])) $senha=$_POST['senha'];
        
        $tipoFuncionario = htmlspecialchars($tipoFuncionario);
        $nome = htmlspecialchars($nome);
        $email = htmlspecialchars($email);
        $telefone = htmlspecialchars($telefone);
        $cep = htmlspecialchars($cep);
        $logradouro = htmlspecialchars($logradouro);
        $bairro = htmlspecialchars($bairro);
        $cidade = htmlspecialchars($cidade);
        $estado = htmlspecialchars($estado);
        $dataContrato = htmlspecialchars($dataContrato);
        $salario = htmlspecialchars($salario);

        $senhaHash = password_hash($senha, PASSWORD_DEFAULT);

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
            $idFuncionario = $connection->lastInsertId();
            $stmt2 = $connection->prepare('INSERT INTO funcionario (data_contrato, salario, senha_hash, funcionario_codigo_fk) values (:data_contrato, :salario,:senha_hash,:funcionario_codigo_fk)');
            if(!$stmt2->execute(array(
                ':data_contrato' => $dataContrato,
                ':salario' => $salario,
                ':senha_hash' => $senhaHash,
                ':funcionario_codigo_fk' => $idFuncionario,
            ))) throw new Exception('Falha na segunda inserção');
            if(strcmp($tipoFuncionario, "MEDICO")==0){
                $especialidade=$_POST['especialidade'];
                $crm=$_POST['crm'];
                $idMedico = $connection->lastInsertId();
                $stmt3 = $connection->prepare('INSERT INTO medico (especialidade, crm, medico_codigo_fk) values (:especialidade, :crm,:medico_codigo_fk)');
                if(!$stmt3->execute(array(
                    ':especialidade' => $especialidade,
                    ':crm' => $crm,
                    ':medico_codigo_fk' => $idMedico,
                ))) throw new Exception('Falha na terceira inserção');
            }
            $connection->commit();
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            $connection->rollBack();
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}