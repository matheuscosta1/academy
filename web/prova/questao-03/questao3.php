<?php

    function connect(){
        $connection = new PDO("mysql:host=fdb30.awardspace.net;dbname=3635065_cosmos", "3635065_cosmos", "kjkszpj91");
        return $connection;
    }
?>

<?php

	$connection = connect();
	$sql = <<<SQL
	SELECT * FROM 3635065_cosmos.aluno
	SQL;
	$result = $connection->query($sql);
?>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>11711BCC008</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
</head>

<body>
	
	<main class="container">
		<div class="table-responsive">
		<p id="success"></p>
			<div>
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h1>Listagem de <b>Alunos</b></h1>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>Nome</th>
							<th>Matrícula</th>
						</tr>
					</thead>
					<tbody>
						<?php
							while($row = $result->fetch(PDO::FETCH_ASSOC)){
								$id = htmlspecialchars($row['id']);
								$nome = htmlspecialchars($row['nome']);
								$matricula = htmlspecialchars($row['matricula']);
						
								echo <<<HTML
									<tr>
									<td>$id</td>
									<td>$nome</td>
									<td>$matricula</td>
									</tr>
								HTML;
							}	
						?>
					</tbody>
				</table>
			</div>
		</div>
	</main>

</body>
</html>    