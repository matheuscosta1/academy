<?php include '../../model/database_connection.php';?>
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
	<link rel="stylesheet" href="../../css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="../../ajax/login.js"></script>
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
                <li><button onclick="location.href='index.php'"> </a> Home </button>|</li>
                <li><button onclick="location.href='cria_endereco.php'">Galeria</button>|</li>
                <li><button onclick="location.href='cria_endereco.php'">Novo Endereço</button>|</li>
				<li><button onclick="location.href='lista_paciente.php'">Agendar Consulta</button>|</li>
				<li><button onclick="location.href='login.php'">Login</button></li>
            </ul>
        </section>
	</nav>
	<main>
		
		<div id="login" >
			<div >
				<div >
					<form id="user_form">
						<div class="modal-header">						
							<h4 class="modal-title">Login</h4>
						</div>
						<div class="form-floating form-group row">
								<input type="email" id="email" name="email" class="form-control" placeholder="E-mail" required>
								<label class="form-label">E-mail</label>
						</div><br>
						<div class="form-floating form-group row">
								<input type="password" id="senha" name="senha" class="form-control" placeholder="Senha" required>
								<label class="form-label">Senha</label>
						</div>	
						<div class="modal-footer">
							<input type="hidden" value="1" name="type">
							<button type="button" class="btn btn-success" id="btn-add">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

</body>
</html>    