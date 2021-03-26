
<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8">
  <title>11711BCC008</title>
</head>

<style>
  input {
    display: block;
  }
</style>

<body>
  <form method="POST" action="questao2.php">
    <input type="text" required id="matricula" name="matricula" placeholder="Informe a matricula">
    <input type="text" required id="nomeDoAluno" name="nomeDoAluno" placeholder="Informe o nomeDoAluno">

    <br><br> 
    Tipo do telefone: 
    <select name="tipo-telefone" required id="tipo-telefone" >
      <option value="Celular">Celular</option>
      <option value="Residencial">Residencial</option>
      <option value="Trabalho">Trabalho</option>
    </select>

    <input type="text" required id="numeroDeTelefone" name="numeroDeTelefone" placeholder="Informe o número do telefone">

    <button type="submit">Cadastrar</button>
  </form>
</body>

</html>

<?php

function conexao(){
    $connection = new PDO("mysql:host=fdb30.awardspace.net;dbname=3635065_cosmos", "3635065_cosmos", "kjkszpj91");
    return $connection;
}

$pdo = conexao();

$matricula = $nomeDoAluno = $tipoDeTelefone = $numeroDeTelefone = "";

if (isset($_POST["nomeDoAluno"])) $nomeDoAluno = $_POST["nomeDoAluno"];
if (isset($_POST["matricula"])) $matricula = $_POST["matricula"];
if (isset($_POST["numeroDeTelefone"])) $numeroDeTelefone = $_POST["numeroDeTelefone"];
if (isset($_POST["nomeDoAluno"])) $nomeDoAluno = $_POST["nomeDoAluno"];


if($matricula == "") exit();

$sqlParaInserirNoAluno = <<<SQL
  INSERT INTO 3635065_cosmos.aluno (nomeDoAluno, matricula)
  VALUES (?, ?)
SQL;

$sqlParaInserirAlunoTelefone = <<<SQL
  INSERT INTO 3635065_cosmos.telefone_aluno(tipo_telefone, numero_telefone, id_aluno)
  VALUES (?, ?, ?)
SQL;

try {
  $pdo->beginTransaction();

  $psAluno = $pdo->prepare($sqlParaInserirNoAluno);
  if (!$psAluno->execute([
      $nomeDoAluno, $matricula
  ])) throw new Exception('Falha na primeira inserção');


  $idAluno = $pdo->lastInsertId();
  $psCriaTelefone = $pdo->prepare($sqlParaInserirAlunoTelefone);
  if (!$psCriaTelefone->execute([
      $tipoDeTelefone, $numeroDeTelefone, $idAluno
  ])) throw new Exception('Falha na segunda inserção');

  $pdo->commit();

  exit();
} 
catch (Exception $e) {
  $pdo->rollBack();
  if ($e->errorInfo[1] === 1062)
      exit('Dados foram inseridos: ' . $e->getMessage());
  else
      exit('Falha: ' . $e->getMessage());
}


?>