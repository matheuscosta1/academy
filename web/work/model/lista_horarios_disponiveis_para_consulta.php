<?php
include 'database_connection.php';

$connection = connect();


if(isset($_POST['data_agendamento'])){

    $data_agendamento=$_POST['data_agendamento'];
    $codigo_medico = $_POST['codigo_medico'];
    $horarios = array(8,9,10,11,12,13,14,15,16,17);

    try{
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $stmt = $connection->prepare('SELECT horario FROM clinica.agenda a WHERE a.codigo_medico_fk = ? and a.data_agendamento = ?');
        $stmt->bindValue(1, $codigo_medico);
        $stmt->bindValue(2, $data_agendamento);
        $stmt->execute();


        while($retorno = $stmt->fetch(PDO::FETCH_ASSOC)){
            if (($key = array_search($retorno['horario'], $horarios)) !== false) {
                unset($horarios[$key]);
            }
        }
        
        $quantidade = count($horarios);

        echo "<select id='horario' name='horario' class='form-select'>";
        for($i=0; $i <= $quantidade; $i++){ 
            if(!$horarios[$i] == '')   
                echo "<option>". $horarios[$i] ."</option>";
        }
        echo "</select>";
        echo "<label for='horario' class='form-label'>Horários</label>";
        
    } catch(PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
}

?>

    

    

