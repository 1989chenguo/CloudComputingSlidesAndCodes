#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <semaphore.h> 

#define IF_PRINT_DEBUG 0
#define BUF_CAPACITY 10

int producerNum=1;
int consumerNum=1;
int TEST_COKE_NUM=100000;

int bufSize=0;

sem_t fullSlots; 
sem_t emptySlots; 
pthread_mutex_t mutex;

void* Producer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/producerNum;i++)
  {
    if(IF_PRINT_DEBUG)
      printf("[%ld] producer: try to enqueue a coke ...\n",pthread_self());
    sem_wait(&emptySlots); 
    pthread_mutex_lock(&mutex);
    bufSize++;
    if(IF_PRINT_DEBUG)
      printf("[%ld] producer: enqueue a coke, bufSize %d\n",pthread_self(),bufSize);
    pthread_mutex_unlock(&mutex);
    sem_post(&fullSlots); 
  }
}

void* Consumer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/consumerNum;i++)
  {
    if(IF_PRINT_DEBUG)
      printf("[%ld] consumer: try to dequeue a coke ...\n",pthread_self());
    sem_wait(&fullSlots);
    pthread_mutex_lock(&mutex);
    bufSize--;
    if(IF_PRINT_DEBUG)
      printf("[%ld] consumer: dequeue a coke, bufSize %d\n",pthread_self(),bufSize);
    pthread_mutex_unlock(&mutex);
    sem_post(&emptySlots); 
  }
}

int main(int argc, char *argv[])
{
  if(argc>=3)
  {
    producerNum=atoi(argv[1]);
    consumerNum=atoi(argv[2]);
  }
  if(argc>=4)
  {
    TEST_COKE_NUM=atoi(argv[3]);
  }

  sem_init(&fullSlots, 0, 0); 
  sem_init(&emptySlots, 0, BUF_CAPACITY); 
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

  sem_destroy(&fullSlots); 
  sem_destroy(&emptySlots); 
  pthread_mutex_destroy(&mutex);

  exit(0);
}