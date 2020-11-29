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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="ajax/ajax.js"></script>
</head>
<body>
    <div class="container">
	<p id="success"></p>
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
						<h2>Manage <b>Users</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons"></i> <span>Add New User</span></a>
					</div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
						<th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll">
								<label for="selectAll"></label>
							</span>
						</th>
						<th>Código</th>
                        <th>Nome</th>
                        <th>Email</th>
						<th>Telefone</th>
                        <th>CEP</th>
                        <th>Logradouro</th>
                        <th>Bairro</th>
						<th>Cidade</th>
                        <th>Estado</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
				<tbody>
				
				<?php
					$connection = connect();
					$result = $connection->prepare("SELECT * FROM clinica.pessoa");
					$result->execute();
					while($row = $result->fetch(PDO::FETCH_ASSOC)){	
				?>
				<tr id="<?php echo $row->codigo; ?>">
				<td>
							<span class="custom-checkbox">
								<input type="checkbox" class="user_checkbox" data-user-id="<?php echo $row['codigo']; ?>">
								<label for="checkbox2"></label>
							</span>
						</td>
					<td><?php echo $row['codigo']; ?></td>
					<td><?php echo $row['nome']; ?></td>
					<td><?php echo $row['email']; ?></td>
					<td><?php echo $row['telefone']; ?></td>
                    <td><?php echo $row['cep']; ?></td>
                    <td><?php echo $row['logradouro']; ?></td>
                    <td><?php echo $row['bairro']; ?></td>
                    <td><?php echo $row['cidade']; ?></td>
                    <td><?php echo $row['estado']; ?></td>
					<td>
						<a href="#editEmployeeModal" class="edit" data-toggle="modal">
							<i class="material-icons update" data-toggle="tooltip" 
							data-codigo="<?php echo $row['codigo']; ?>"
							data-nome="<?php echo $row['nome']; ?>"
							data-email="<?php echo $row['email']; ?>"
							data-telefone="<?php echo $row['telefone']; ?>"
                            data-cep="<?php echo $row['cep']; ?>"
                            data-logradouro="<?php echo $row['logradouro']; ?>"
                            data-bairro="<?php echo $row['bairro']; ?>"
                            data-cidade="<?php echo $row['cidade']; ?>"
                            data-estado="<?php echo $row['estado']; ?>"
							title="Edit"></i>
						</a>
						<a href="#deleteEmployeeModal" class="delete" data-codigo="<?php echo $row['codigo']; ?>" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" 
						 title="Delete"></i></a>
                    </td>
				</tr>
				<?php
			}
				?>
				</tbody>
			</table>
			
        </div>
    </div>
	<!-- Add Modal HTML -->
	<div id="addEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="user_form">
					<div class="modal-header">						
						<h4 class="modal-title">Add User</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label>Nome</label>
							<input type="text" id="nome" name="nome" class="form-control" required>
						</div>
						<div class="form-group">
							<label>E-mail</label>
							<input type="email" id="email" name="email" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Telefone</label>
							<input type="phone" id="telefone" name="telefone" class="form-control" required>
						</div>
						<div class="form-group">
							<label>CEP</label>
							<input type="text" id="cep" name="cep" class="form-control" required>
						</div>	
						<div class="form-group">
							<label>Logradouro</label>
							<input type="text" id="logradouro" name="logradouro" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Bairro</label>
							<input type="text" id="bairro" name="bairro" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Cidade</label>
							<input type="text" id="cidade" name="cidade" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Estado</label>
							<input type="text" id="estado" name="estado" class="form-control" required>
						</div>				
					</div>
					<div class="modal-footer">
					    <input type="hidden" value="1" name="type">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<button type="button" class="btn btn-success" id="btn-add">Add</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Edit Modal HTML -->
	<div id="editEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="update_form">
					<div class="modal-header">						
						<h4 class="modal-title">Edit User</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Código</label>
							<input type="text" style="display:block" id="codigo_u" name="codigo" class="form-control" required readonly >
						</div>	
						<div class="form-group">
							<label>Nome</label>
							<input type="text" id="nome_u" name="nome" class="form-control" required>
						</div>
						<div class="form-group">
							<label>E-mail</label>
							<input type="email" id="email_u" name="email" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Telefone</label>
							<input type="phone" id="telefone_u" name="telefone" class="form-control" required>
						</div>
						<div class="form-group">
							<label>CEP</label>
							<input type="text" id="cep_u" name="cep" class="form-control" required>
						</div>	
						<div class="form-group">
							<label>Logradouro</label>
							<input type="text" id="logradouro_u" name="logradouro" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Bairro</label>
							<input type="text" id="bairro_u" name="bairro" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Cidade</label>
							<input type="citextty" id="cidade_u" name="cidade" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Estado</label>
							<input type="text" id="estado_u" name="estado" class="form-control" required>
						</div>	
						<div class="modal-footer">
						<input type="hidden" value="2" name="type">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
							<button type="button" class="btn btn-info" id="update">Update</button>
						</div>			
					</div>				
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<!-- Delete Modal HTML -->
	<div id="deleteEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
						
					<div class="modal-header">						
						<h4 class="modal-title">Delete User</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="codigo_d" name="id" class="form-control">					
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<button type="button" class="btn btn-danger" id="delete">Delete</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>    