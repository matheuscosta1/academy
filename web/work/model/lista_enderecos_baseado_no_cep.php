<?php
include 'database_connection.php';

$connection = connect();


if(isset($_POST['cep'])){
    $cep = "";
    if(isset($_POST['cep'])){
        $cep=$_POST['cep'];
    }

    $cep = htmlspecialchars($cep);
    $return = $_POST;

    try{
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $stmt = $connection->prepare('SELECT * FROM 3635065_cosmos.endereco WHERE cep = ?');
        $stmt->bindValue(1, $cep);
        $stmt->execute();
        while($retorno = $stmt->fetch(PDO::FETCH_ASSOC)){
            
            $return['cep'] = $retorno['cep'];
            $return['logradouro'] = $retorno['logradouro'];
            $return['bairro'] = $retorno['bairro'];
            $return['cidade'] = $retorno['cidade'];
            $return['estado'] = $retorno['estado'];
            $return["json"] = json_encode($return);
            
        }
        echo json_encode($return);

    } catch(PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
}   

?> 

    

    

