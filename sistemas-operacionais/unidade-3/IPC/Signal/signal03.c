#include <signal.h>
#include <stdio.h>

main()
{
	kill(2470,SIGSTOP);
	sleep(3);
	kill(2470,SIGCONT);
	sleep(3);
	kill(2470,SIGKILL);

} 
