<?php
    define("HOST", "127.0.0.1"); 
    define("USER", "root");
    define("PASSWORD", "clinica"); 
    define("DATABASE", "clinica");

    function connect(){
        $connection = new PDO("mysql:host=127.0.0.1;dbname=clinica", "root", "clinica");
        return $connection;
    }
?>