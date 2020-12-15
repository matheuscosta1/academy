<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        
        $dataAgendamento = $codigoMedico = $horario = $nome = $email = $telefone = "";

        if (isset($_POST["data-agendamento"])) $dataAgendamento=$_POST['data-agendamento'];
        if (isset($_POST["codigo_medico"])) $codigoMedico=$_POST['codigo_medico'];
        if (isset($_POST["horario"])) $horario=$_POST['horario'];
        if (isset($_POST["nome"])) $nome=$_POST['nome'];
        if (isset($_POST["email"])) $email=$_POST['email'];
        if (isset($_POST["telefone"])) $telefone=$_POST['telefone'];

        $dataAgendamento = htmlspecialchars($dataAgendamento);
        $codigoMedico = htmlspecialchars($codigoMedico);
        $horario = htmlspecialchars($horario);
        $nome = htmlspecialchars($nome);
        $email = htmlspecialchars($email);
        $telefone = htmlspecialchars($telefone);

        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('INSERT INTO 3635065_cosmos.agenda (data_agendamento, horario, nome, email, telefone, codigo_medico_fk) values (:data_agendamento, :horario,:nome,:email,:telefone,:codigo_medico_fk)');
            if(!$stmt->execute(array(
                ':data_agendamento' => $dataAgendamento,
                ':horario' => $horario,
                ':nome' => $nome,
                ':email' => $email,
                ':telefone' => $telefone,
                ':codigo_medico_fk' => $codigoMedico,
            ))) throw new Exception('Falha na primeira inserção');
            echo $stmt->rowCount();
        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
	}
}