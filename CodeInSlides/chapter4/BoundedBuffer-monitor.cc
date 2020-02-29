#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define TEST_ITERATIONS 1000

#define BUF_CAPACITY 10

int bufSize=0;

pthread_mutex_t mutex;
pthread_cond_t cnd;

void* Producer(void* args) {
  for(int i=0;i<TEST_ITERATIONS;i++)
  {
    pthread_mutex_lock(&mutex);
    while(bufSize==BUF_CAPACITY)
      pthread_cond_wait(&cnd,&mutex);
    bufSize++;
    if(bufSize==1)
      pthread_cond_signal(&cnd);
    pthread_mutex_unlock(&mutex);
  }
}

void* Consumer(void* args) {
  for(int i=0;i<TEST_ITERATIONS;i++)
  {
    pthread_mutex_lock(&mutex);
    while(bufSize==0)
      pthread_cond_wait(&cnd,&mutex);
    bufSize--;
    if(bufSize==BUF_CAPACITY-1)
      pthread_cond_signal(&cnd);
    pthread_mutex_unlock(&mutex);
  }
}

int main(int argc, char *argv[])
{

  pthread_cond_init(&cnd,NULL);
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

  pthread_cond_destroy(&cnd);
  pthread_mutex_destroy(&mutex);

  exit(0);
}