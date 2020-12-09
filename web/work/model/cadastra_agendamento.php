<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        $dataAgendamento=$_POST['data-agendamento'];
        $codigoMedico=$_POST['codigo_medico'];
        $horario=$_POST['horario'];
		$nome=$_POST['nome'];
		$email=$_POST['email'];
		$telefone=$_POST['telefone'];
        
        try{
            $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $connection->prepare('INSERT INTO clinica.agenda (data_agendamento, horario, nome, email, telefone, codigo_medico_fk) values (:data_agendamento, :horario,:nome,:email,:telefone,:codigo_medico_fk)');
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