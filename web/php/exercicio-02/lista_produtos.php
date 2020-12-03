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
							<h2>Listagem de <b>Produtos</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Sequencial</th>
							<th>Produto</th>
							<th>Descrição</th>
						</tr>
					</thead>
					<tbody>
					


					<?php
						$qde = "";
						if(isset($_GET["qde"])) {
							$qde = $_REQUEST["qde"];
						}

						$produtos = array("Arroz", "Feijão", "Carne", "Macarrao", "Alface", "Repolho", "Couve", "Doce", "Abóbora", "Abacate");
						$descricoes = array("Arroz é uma fonte rica em carboidratos", "Feijão é um alimento rico em proteínas", "Carne tem proteínas que ajudam na recuperação muscular", "Macarrão é um alimento rico em carboidratos", "Alface é ideal para pessoas fazendo dieta", "Repolho é um alimento usado na salada", "Couve é verde", "Doce é saboroso", "Abóbora é deliciosa", "Abacate é a fruta da felicidade");
						$numero = count($produtos);
						
						for($i=0; $i < $qde; $i++){
                            $randomNumber = rand(0,9);
					?>
                        <tr>
							<td><?php echo $i; ?></td>
							<td><?php echo $produtos[$randomNumber]; ?></td>
							<td><?php echo $descricoes[$randomNumber]; ?></td>
						</tr>
					<?php
					}
					?>
					</tbody>
				</table>
				
			</div>
		</div>
	</main>

</html>

