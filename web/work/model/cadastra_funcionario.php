<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        $tipoFuncionario=$_POST['tipo-funcionario'];
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        $cep=$_POST['cep'];
        $logradouro=$_POST['logradouro'];
        $bairro=$_POST['bairro'];
        $cidade=$_POST['cidade'];
        $estado=$_POST['estado'];
        $dataContrato=$_POST['data-contrato'];
        $salario=$_POST['salario'];
        $senha=$_POST['senha'];

        $senhaHash = password_hash($senha, PASSWORD_DEFAULT);

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
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}