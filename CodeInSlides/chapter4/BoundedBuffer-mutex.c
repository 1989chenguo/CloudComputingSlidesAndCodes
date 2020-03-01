#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define TEST_COKE_NUM 100000
#define BUF_CAPACITY 10

int producerNum=1;
int consumerNum=1;

int bufSize=0;

pthread_mutex_t mutex;

void* Producer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/producerNum;i++)
  {
    while(1)
    {
      pthread_mutex_lock(&mutex);
      if(bufSize==BUF_CAPACITY)
        pthread_mutex_unlock(&mutex);
      else
        break;
    }
    bufSize++;
    pthread_mutex_unlock(&mutex);
  }
}

void* Consumer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/consumerNum;i++)
  {
    while(1)
    {
      pthread_mutex_lock(&mutex);
      if(bufSize==0)
        pthread_mutex_unlock(&mutex);
      else
        break;
    }
    bufSize--;
    pthread_mutex_unlock(&mutex);
  }
}

int main(int argc, char *argv[])
{
  if(argc>=2)
  {
    producerNum=atoi(argv[1]);
    consumerNum=atoi(argv[2]);
  }

  pthread_mutex_init(&mutex,NULL);

  printf("Before run: \t\t coke_num \t\t %d\n", bufSize);

  pthread_t th1[producerNum];
  for(int i=0;i<producerNum;i++)
  {
    if(pthread_create(&th1[i], NULL, Producer, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  pthread_t th2[consumerNum];
  for(int i=0;i<consumerNum;i++)
  {
    if(pthread_create(&th2[i], NULL, Consumer, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }

  for(int i=0;i<producerNum;i++)
    pthread_join(th1[i], NULL);
  for(int i=0;i<consumerNum;i++)
    pthread_join(th2[i], NULL);

  printf("After run: \t\t coke_num \t\t %d\n", bufSize);

  pthread_mutex_destroy(&mutex);

  exit(0);
}