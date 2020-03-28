#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/time.h>
#include <time.h>
#include <semaphore.h> 

#define RUN_TIMES 50000

sem_t fullSem; 
sem_t emptySem; 

pthread_mutex_t testMutex=PTHREAD_MUTEX_INITIALIZER;

double time_diff(struct timeval x , struct timeval y)
{
  double x_ms , y_ms , diff;
  x_ms = (double)x.tv_sec*1000000 + (double)x.tv_usec;
  y_ms = (double)y.tv_sec*1000000 + (double)y.tv_usec;
  diff = (double)y_ms - (double)x_ms;
  return diff;
}

typedef struct {
  double timeElapsed;
} ThreadParas;

void* threadAdd(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    sem_wait(&emptySem);
    pthread_mutex_lock(&testMutex);
    pthread_mutex_unlock(&testMutex);
    sem_post(&fullSem);
  }
  gettimeofday(&tvEnd,NULL);
  para->timeElapsed=time_diff(tvStart,tvEnd);
}

void* threadSub(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    sem_wait(&fullSem);
    pthread_mutex_lock(&testMutex);
    pthread_mutex_unlock(&testMutex);
    sem_post(&emptySem);
  }
  gettimeofday(&tvEnd,NULL);
  para->timeElapsed=time_diff(tvStart,tvEnd);
}

int main(int argc, char *argv[])
{
  {
    sem_destroy(&fullSem); 
    sem_destroy(&emptySem);
    sem_init(&fullSem, 0, RUN_TIMES); 
    sem_init(&emptySem, 0, RUN_TIMES);
    pthread_t th[2];
    ThreadParas thPara[2];
    if(pthread_create(&th[0], NULL, threadAdd, &thPara[0])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    pthread_join(th[0], NULL);
    if(pthread_create(&th[1], NULL, threadSub, &thPara[1])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    pthread_join(th[1], NULL);
    double totalTime=0;
    for(int i=0;i<2;i++)
      totalTime=totalTime+thPara[i].timeElapsed;
    double avgDelay=totalTime/2/RUN_TIMES;
    printf("[semaphore + mutex] Total time %.3lf s, Average time is %.5lf us\n",totalTime/1E6,avgDelay);
  }

  {
    sem_destroy(&fullSem); 
    sem_destroy(&emptySem);
    sem_init(&fullSem, 0, 0); 
    sem_init(&emptySem, 0, 1);
    pthread_t th[2];
    ThreadParas thPara[2];
    if(pthread_create(&th[0], NULL, threadAdd, &thPara[0])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    if(pthread_create(&th[1], NULL, threadSub, &thPara[1])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    for(int i=0;i<2;i++)
      pthread_join(th[i], NULL);

    double totalTime=0;
    for(int i=0;i<2;i++)
      totalTime=totalTime+thPara[i].timeElapsed;
    double avgDelay=totalTime/2/RUN_TIMES;
    printf("[semaphore + mutex + context switch] Total time %.3lf s, Average time is %.5lf us\n",totalTime/1E6,avgDelay);
  }

  exit(0);
}