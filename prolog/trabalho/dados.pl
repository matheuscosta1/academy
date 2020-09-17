genero(drama).
genero(comedia).
genero(terror).
genero(romance).
genero(besteirol).
genero(acao).

tag(animacao).
tag(americano).
tag(familia).
tag(adulto).
tag(veridico).
tag(maior_de_idade).

diretor(1, stanley_kubrick).
diretor(2, james_cameron).
diretor(3, cristopher_mcquarrie).

estudio(marvel).
estudio(pixar).
estudio(warner_bros).
estudio(disney).
estudio(paramount_pictures).

ator(1, nicole_kidman).
ator(2, tom_cruise).
ator(3, rosamund_pike).
ator(4, anthony_burgess).

filme('Jack Reacher - O Último Tiro', acao, [2, 3], 3, filme, [familia], paramount_pictures).
filme('Laranja Mecanica', acao, [4], 1, [maior_de_idade], warner_bros).
