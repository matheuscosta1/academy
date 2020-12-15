<?php
include 'database_connection.php';

$connection = connect();


if(isset($_POST['especialidade_name'])){
    $especialidade_name = "";
    if(isset($_POST['especialidade_name'])){
        $especialidade_name=$_POST['especialidade_name'];
    }

    $especialidade_name = htmlspecialchars($especialidade_name);

    try{
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $stmt = $connection->prepare('SELECT m.codigo, p.nome FROM 3635065_cosmos.pessoa p INNER JOIN funcionario f ON p.codigo = f.funcionario_codigo_fk INNER JOIN 3635065_cosmos.medico m ON f.codigo = m.medico_codigo_fk WHERE m.especialidade = ?');
        $stmt->bindValue(1, $especialidade_name);
        $stmt->execute();

        echo "<select id='codigo_medico' name='codigo_medico' class='form-select'>";
        echo "<option selected disabled>Médico</option>";
        while($retorno = $stmt->fetch(PDO::FETCH_ASSOC)){    
            echo "<option name='codigo_medico' id='codigo_medico' value='". $retorno['codigo'] . "'" . ">" . $retorno['nome'] . "</option>" ;
        }
        echo "</select>";
        echo "<label for='codigo_medico' class='form-label'>Médicos</label>";

    } catch(PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
}else if(isset($_POST['codigo_medico'])){
    $codigo_medico=$_POST['codigo_medico'];
    console.log($codigo_medico);
}
    
?>

    

    

