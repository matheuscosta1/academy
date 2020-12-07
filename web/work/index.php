<?php include 'model/database_connection.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>User Data</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-CuOF+2SnTUfTwSZjCXf01h7uYhfOBuxIhGKPbfEJ3+FqH/s6cIFN9bGr1HmAg4fQ" crossorigin="anonymous"></head>
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="ajax/ajax.js"></script>
</head>
<body>

	<header>
        <section>
            <h1>Clínica</h1>
        </section>
    </header>
    <nav>
        <section>
            <ul>
                <li><button onclick="location.href='cria_funcionario.php'"> </a> Novo Funcionário</button>|</li>
                <li><button>Novo Paciente</button>|</li>
                <li><button onclick="location.href='index.php'">Listar Funcionários</button>|</li>
				<li><button>Listar Pacientes</button>|</li>
				<li><button>Listar Endereços</button>|</li>
				<li><button>Listar todos Agendamentos</button>|</li>
				<li><button>Listar meus Agendamentos</button></li>
            </ul>
        </section>
	</nav>
	
	<main class="container">
		<div class="table-responsive">
		<p id="success"></p>
			<div>
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>Listagem de <b>Funcionários</b></h2>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Código</th>
							<th>Nome</th>
							<th>Email</th>
							<th>Telefone</th>
							<th>CEP</th>
							<th>Logradouro</th>
							<th>Bairro</th>
							<th>Cidade</th>
							<th>Estado</th>
							<th>Data do Contrato</th>
							<th>Salário</th>
							<th>Senha</th>
						</tr>
					</thead>
					<tbody>
					
					<?php
						$connection = connect();
						$result = $connection->prepare("SELECT * FROM clinica.pessoa INNER JOIN funcionario ON pessoa.codigo = funcionario.funcionario_codigo_fk");
						$result->execute();
						while($row = $result->fetch(PDO::FETCH_ASSOC)){	
					?>
						<tr id="<?php echo $row->codigo; ?>">
							<td><?php echo $row['codigo']; ?></td>
							<td><?php echo $row['nome']; ?></td>
							<td><?php echo $row['email']; ?></td>
							<td><?php echo $row['telefone']; ?></td>
							<td><?php echo $row['cep']; ?></td>
							<td><?php echo $row['logradouro']; ?></td>
							<td><?php echo $row['bairro']; ?></td>
							<td><?php echo $row['cidade']; ?></td>
							<td><?php echo $row['estado']; ?></td>
							<td><?php echo $row['data_contrato']; ?></td>
							<td><?php echo $row['salario']; ?></td>
							<td><?php echo $row['senha_hash']; ?></td>
						</tr>
					<?php
					}
					?>
					</tbody>
				</table>
				
			</div>
		</div>
	</main>

</body>
</html>    