#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <sys/wait.h>

#define bssSize (1024*1024)
int stackSize=0;
int heapSize=0;
int mmapSize=0;

static int array[bssSize];

int recursiveCalc(int n)
{
	if(n==1)
		return n;
	else
		return recursiveCalc(n-1)+1;
}

int printMemMap(pid_t printPid)
{
	printf("---------- mem layout begin ---------\n");
	char *command[3];
    command[0]=malloc(100*sizeof(char));
	sprintf(command[0],"%s","pmap");
    command[1]=malloc(100*sizeof(char));
	sprintf(command[1],"%d",printPid);
	command[2]=NULL;
	pid_t pid = fork();
    if (pid == -1) { //Error
        perror("Fork printMemMap ERROR: ");
    }
    else if (pid == 0) { //Child
	    if(execvp(command[0], command)<0)  
	    	perror("execvp(pmap) ERROR: ");
    }
    else { //Parent
        int childStatus;
        wait(&childStatus);
    }
   	printf("---------- mem layout end ---------\n\n\n");
   	return 0;
}

int main()
{
	printMemMap(getpid());
	while(1)
	{
		printf("Please input stackSize: ");
		scanf("%d",&stackSize);
		printf("Call recursive calc in %d depth. Calc result: %d\n",stackSize,recursiveCalc(stackSize));
		printMemMap(getpid());

		printf("Please input heapSize size (B): ");
		scanf("%d",&heapSize);
		int allocatedSize=0;
		int *p;
		while(allocatedSize<heapSize) {
			allocatedSize=allocatedSize+4096;
			p=malloc(4096*sizeof(int));
		}
		printf("Malloc %d (B) memory in total, with each malloc being 4096 (B)\n",heapSize);
		printMemMap(getpid());

		printf("Please input mmapSize size (B): ");
		scanf("%d",&mmapSize);
		p = mmap(0, mmapSize, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
		printf("Mmap %d (B) memory in total (B)\n",mmapSize);
		printMemMap(getpid());
	}
	return 0;
}