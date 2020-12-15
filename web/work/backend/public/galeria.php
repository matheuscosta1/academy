<?php include '../../model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Seleta Cosmos</title>
    <link rel="icon" href="../../images/icone.png">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<link rel="stylesheet" href="../../css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="../../ajax/cadastra_agendamento.js"></script>
	<script src="../../ajax/lista_medicos_por_especialidade.js"></script>
	<script src="../../ajax/lista_horarios_disponiveis_para_consulta.js"></script>
</head>
<body>

	<?php include "../../templates/public_header.html"; ?>

	<div class="align-text-description">
        <h2>Galeria</h2>
        <div>
            <div class="table-responsive">
                <table class=" table-striped table-hover">
                    <tr>
                        <td><img class="border-photo" src="../../images/clinica1.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica2.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica3.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica4.jpg"></td>
                    </tr>
                    <br>
                    <tr>
                        <td><img class="border-photo" src="../../images/clinica5.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica6.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica7.jpg"></td>
                        <td><img class="border-photo" src="../../images/clinica8.jpg"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

</body>
</html>    