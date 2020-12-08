<?php
include 'database_connection.php';

$connection = connect();

if(count($_POST)>0){
	if($_POST['type']==1){
        $email = $senha = "";

        if (isset($_POST["email"]))
          $email = $_POST["email"];
        if (isset($_POST["senha"]))
          $senha = $_POST["senha"];

        $email = htmlspecialchars($email);
        $senha = htmlspecialchars($senha);

        try{            
            $stmt = $connection->prepare('SELECT senha_hash FROM clinica.pessoa p INNER JOIN clinica.funcionario f on p.codigo = f.funcionario_codigo_fk WHERE p.email = ?');
            $stmt->bindValue(1, $email);
            $stmt->execute();
            $retorno = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if(!empty($retorno['senha_hash']) && password_verify($senha, $retorno['senha_hash'])){
                echo "1";
            } 
            else {
                echo "0";
            }

        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}
