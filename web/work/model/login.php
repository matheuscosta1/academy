<?php
include 'database_connection.php';

$connection = connect();

session_start();

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
            $stmt = $connection->prepare('SELECT senha_hash FROM 3635065_cosmos.pessoa p INNER JOIN 3635065_cosmos.funcionario f on p.codigo = f.funcionario_codigo_fk WHERE p.email = ?');
            $stmt->bindValue(1, $email);
            $stmt->execute();
            $retorno = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if(!empty($retorno['senha_hash']) && password_verify($senha, $retorno['senha_hash'])){
                $_SESSION['email'] = $email;
                $_SESSION['senha'] = $senha;
                echo "1";
            } 
            else {
              unset ($_SESSION['email']);
              unset ($_SESSION['senha']);
              echo "0";
            }

        } catch(PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        }
        
	}
}
