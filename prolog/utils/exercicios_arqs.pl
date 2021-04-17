lerArq(Arq):- see(Arq), lidarArq, seen.
lidarArq:- 
	read(X), 
	X \= end_of_file, 
	write(X), nl,
	lidarArq, ! ;
	true.
