<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>11711BCC008</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	
	<main>
		<div>
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Busca instantânea por telefone de aluno</h4>
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<input type="text" id="id_aluno" name="id_aluno" class="form-control" placeholder="Id Aluno" required>
								<label class="form-label">Id aluno</label>
							</div><br>	
						</div>
						<div class="modal-body">
							<div class="form-floating form-group row">
								<input type="text" id="telefone" name="telefone" class="form-control" placeholder="Telefone" required>
								<label class="form-label">Telefone</label>
							</div><br>	
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

</body>
</html>

<?php
function connect(){
    $connection = new PDO("mysql:host=fdb30.awardspace.net;dbname=3635065_cosmos", "3635065_cosmos", "kjkszpj91");
    return $connection;
}

$connection = connect();


if(isset($_POST['id_aluno'])){
    $id_aluno = "";
    if(isset($_POST['id_aluno'])){
        $cep=$_POST['id_aluno'];
    }

    $id_aluno = htmlspecialchars($id_aluno);
    $return = $_POST;

    try{
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $stmt = $connection->prepare('SELECT * FROM 3635065_cosmos.telefone_aluno WHERE id_aluno = ?');
        $stmt->bindValue(1, $id_aluno);
        $stmt->execute();
        while($retorno = $stmt->fetch(PDO::FETCH_ASSOC)){

            $return['id'] = $retorno['id'];
            $return['id_aluno'] = $retorno['id_aluno'];
            $return['numero_telefone'] = $retorno['numero_telefone'];
            $return['tipo_telefone'] = $retorno['tipo_telefone'];
            
        }
        echo json_encode($return);

    } catch(PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
}  
?>

<script>
	$(document).ready(function() {

	$('#id_aluno').change(function()
	{
		var id_aluno = $(this).val();
	$.ajax({
		data: { id_aluno:id_aluno },
		type: "post",
		url: "questao4.php",
		dataType:'JSON',
		success: function(data){
			console.log(data.id_aluno);
			$('#telefone').val(data.numero_telefone);
		}
	});
	});
	});
</script>