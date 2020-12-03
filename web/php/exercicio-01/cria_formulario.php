<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
</head>

<main class="container">
		<div class="table-responsive">
		<p id="success"></p>
			<div>
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>Listagem de <b>Endereços</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>CEP</th>
							<th>Endereço</th>
							<th>Bairro</th>
							<th>Cidade</th>
							<th>Estado</th>
						</tr>
					</thead>
					<tbody>
					
					<?php
						$cep = $logradouro = $bairro = $cidade = $estado = "";

                        if(isset($_POST["cep"]))
                            $cep = $_POST["cep"];
                    
                        if(isset($_POST["endereco"]))
                            $endereco = $_POST["endereco"];
                    
                        if(isset($_POST["bairro"]))
                            $bairro = $_POST["bairro"];
                    
                        if(isset($_POST["cidade"]))
                            $cidade = $_POST["cidade"];
                    
                        if(isset($_POST["estado"]))
                            $estado = $_POST["estado"];
                    
                        
                        $cep = htmlspecialchars($cep);
                        $endereco = htmlspecialchars($endereco);
                        $bairro = htmlspecialchars($bairro);
                        $cidade = htmlspecialchars($cidade);
                        $estado = htmlspecialchars($estado);
					?>
                        <tr>
                            <td><?php echo $cep; ?></td>
                            <td><?php echo $endereco; ?></td>
                            <td><?php echo $bairro; ?></td>
                            <td><?php echo $cidade; ?></td>
                            <td><?php echo $estado; ?></td>
                        </tr>
					</tbody>
				</table>
				
			</div>
		</div>
	</main>


<?php


    

    

?>

</html>

