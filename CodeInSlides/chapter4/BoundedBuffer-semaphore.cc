#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <semaphore.h> 

#define TEST_ITERATIONS 1000

#define BUF_CAPACITY 10

int bufSize=0;

sem_t fullSlots; 
sem_t emptySlots; 
pthread_mutex_t mutex;

void* Producer(void* args) {
  for(int i=0;i<TEST_ITERATIONS;i++)
  {
    sem_wait(&emptySlots); 
    pthread_mutex_lock(&mutex);
    bufSize++;
    pthread_mutex_unlock(&mutex);
    sem_post(&fullSlots); 
  }
}

void* Consumer(void* args) {
  for(int i=0;i<TEST_ITERATIONS;i++)
  {
    sem_wait(&fullSlots);
    pthread_mutex_lock(&mutex);
    bufSize--;
    pthread_mutex_unlock(&mutex);
    sem_post(&emptySlots); 
  }
}

int main(int argc, char *argv[])
{
  sem_init(&fullSlots, 0, 0); 
  sem_init(&emptySlots, 0, BUF_CAPACITY); 
  pthread_mutex_init(&mutex,NULL);

  printf("Before run: \t\t bufSize \t\t %d\n", bufSize);

  pthread_t th1;
  if(pthread_create(&th1, NULL, Producer, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }
  pthread_t th2;
  if(pthread_create(&th2, NULL, Consumer, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }
  
  pthread_join(th1, NULL);
  pthread_join(th2, NULL);

  printf("After run: \t\t bufSize \t\t %d\n", bufSize);

  sem_destroy(&fullSlots); 
  sem_destroy(&emptySlots); 
  pthread_mutex_destroy(&mutex);

  exit(0);
}