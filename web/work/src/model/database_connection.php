<?php
    define("HOST", "127.0.0.1"); 
    define("USER", "root");
    define("PASSWORD", "clinica"); 
    define("DATABASE", "clinica");

    function connect(){
        $connection = new mysqli(HOST, USER, PASSWORD, DATABASE);
        if($connection->connect_error){
            throw new Exception('MySQL connection error.'.$connection->connect_error);
        }
        return $connection;
    }
?>