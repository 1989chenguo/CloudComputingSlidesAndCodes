#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    int i;
    pid_t mypid;
    pid_t cpid = fork();
    if (cpid > 0) {
        mypid = getpid();
        printf("[%d] parent of [%d]\n", mypid, cpid);
        for (i=0; i<10; i++) {
          printf("[%d] parent: %d\n", mypid, i);
          usleep(1000);
        }
    }  else if (cpid == 0) {
        mypid = getpid();
        printf("[%d] child\n", mypid);
        for (i=0; i>-10; i--) {
          printf("[%d] child: %d\n", mypid, i);
          usleep(1000);
        }
    } 

    return 0;
}