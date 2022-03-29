#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define n 100000000
long sum = 0;

void* do_sum(void* args) {
  for (int i = 0; i < n; i++) sum++;
}

int main(int argc, char *argv[])
{
  pthread_t th[2];
  for(int i=0;i<2;i++)
  {
    if(pthread_create(&th[i], NULL, do_sum, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  for(int i=0;i<2;i++)
    pthread_join(th[i], NULL);

  printf("sum = %ld\n", sum);
  exit(0);
}