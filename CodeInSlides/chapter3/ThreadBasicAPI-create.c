#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

void* myfunc(void* args) {
  pthread_t tid = pthread_self();          
  printf("[%ld] child. Exit\n", tid);
}

int main(int argc, char *argv[])
{

  pthread_t th;
  if(pthread_create(&th, NULL, myfunc, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }

  pthread_t mytid = pthread_self();

  printf("Parent tid: %ld\n", mytid);
  printf("[%ld] parent of [%ld]. Exit\n", mytid, th);

  // pthread_join(th, NULL);

  exit(0);
}