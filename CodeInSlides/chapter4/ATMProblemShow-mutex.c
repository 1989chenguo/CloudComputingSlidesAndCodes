#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define TEST_ITERATIONS 1000

int accountBalance=0;
int amount=10;

pthread_mutex_t accountBalanceLock;

void* threadDeposit(void* args) {
  for(int i=0;i<TEST_ITERATIONS;i++)
  {
    pthread_mutex_lock(&accountBalanceLock);
    accountBalance=accountBalance+amount;
    pthread_mutex_unlock(&accountBalanceLock);
    usleep(rand()%100);
  }
}


int main(int argc, char *argv[])
{
  if(argc<=1)
  {
    fprintf(stderr, "please input numOfWorkerThread\n");
    exit(1);
  }
  int numOfWorkerThread=atoi(argv[1]);

  pthread_mutex_init(&accountBalanceLock,NULL);

  printf("Before deposit: \t\taccountBalance \t\t %d\n", accountBalance);

  pthread_t th[numOfWorkerThread];
  for(int i=0;i<numOfWorkerThread;i++)
  {
    if(pthread_create(&th[i], NULL, threadDeposit, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  
  for(int i=0;i<numOfWorkerThread;i++)
    pthread_join(th[i], NULL);

  printf("After deposit: \t\taccountBalance \t\t %d\n", accountBalance);

  pthread_mutex_destroy(&accountBalanceLock);

  exit(0);
}