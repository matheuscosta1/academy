<?php

    function connect(){
        $connection = new PDO("mysql:host=fdb30.awardspace.net;dbname=3635065_cosmos", "3635065_cosmos", "kjkszpj91");
        return $connection;
    }
?>