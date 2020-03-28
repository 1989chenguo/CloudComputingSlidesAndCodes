#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/time.h>
#include <time.h>

#define RUN_TIMES 10000
#define NUMBERS_PER_RUN 10000

pthread_cond_t cnd;
int globlaInt=0;

int A=3.14;
int B=1.68;
int C;

#define DO_THING C=A/B;
// #define DO_THING pthread_mutex_lock(&testMutex);pthread_mutex_unlock(&testMutex);
#define DO_THING_2 DO_THING DO_THING
#define DO_THING_4 DO_THING_2 DO_THING_2
#define DO_THING_8 DO_THING_4 DO_THING_4
#define DO_THING_16 DO_THING_8 DO_THING_8
#define DO_THING_32 DO_THING_16 DO_THING_16
#define DO_THING_64 DO_THING_32 DO_THING_32
#define DO_THING_128 DO_THING_64 DO_THING_64

pthread_mutex_t testMutex=PTHREAD_MUTEX_INITIALIZER;

double time_diff(struct timeval x , struct timeval y)
{
  double x_ms , y_ms , diff;
  x_ms = (double)x.tv_sec*1000000 + (double)x.tv_usec;
  y_ms = (double)y.tv_sec*1000000 + (double)y.tv_usec;
  diff = (double)y_ms - (double)x_ms;
  if(diff<0)
  {
    fprintf(stderr, "ERROR! time_diff<0\n");
    exit(1);
  }
  return diff;
}

typedef struct {
  double timeElapsed;
} ThreadParas;

void* threadFunc(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    pthread_mutex_lock(&testMutex);
    pthread_mutex_unlock(&testMutex);
  }
  gettimeofday(&tvEnd,NULL);
  para->timeElapsed=time_diff(tvStart,tvEnd);
}

void* threadAdd(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    pthread_mutex_lock(&testMutex);
    if(globlaInt!=0)
      pthread_cond_wait(&cnd,&testMutex);
    globlaInt++;
    pthread_cond_signal(&cnd);
    pthread_mutex_unlock(&testMutex);
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
    pthread_mutex_lock(&testMutex);
    if(globlaInt!=1)
      pthread_cond_wait(&cnd,&testMutex);
    globlaInt--;
    pthread_cond_signal(&cnd);
    pthread_mutex_unlock(&testMutex);
  }
  gettimeofday(&tvEnd,NULL);
  para->timeElapsed=time_diff(tvStart,tvEnd);
}

int main(int argc, char *argv[])
{
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    for(int j=0;j<NUMBERS_PER_RUN;j++)
    {
      // pthread_mutex_lock(&testMutex);
      // pthread_mutex_unlock(&testMutex);
      DO_THING_128
      // C=A/B;
    }
  }
  gettimeofday(&tvEnd,NULL);

  double totalTime=time_diff(tvStart,tvEnd);
  double avgDelay=totalTime/RUN_TIMES/NUMBERS_PER_RUN/128;

  printf("Total time %.3lf s, Average time is %.5lf us\n",totalTime/1E6,avgDelay);

  // int numOfWorkerThread=2;
  // pthread_t th[numOfWorkerThread];
  // ThreadParas thPara[numOfWorkerThread];
  // // for(int i=0;i<numOfWorkerThread;i++)
  // // {
  // //   if(pthread_create(&th[i], NULL, threadFunc, &thPara[i])!=0)
  // //   {
  // //     perror("pthread_create failed");
  // //     exit(1);
  // //   }
  // // }
  // if(pthread_create(&th[0], NULL, threadAdd, &thPara[0])!=0)
  // {
  //   perror("pthread_create failed");
  //   exit(1);
  // }
  // if(pthread_create(&th[1], NULL, threadSub, &thPara[1])!=0)
  // {
  //   perror("pthread_create failed");
  //   exit(1);
  // }

  // for(int i=0;i<numOfWorkerThread;i++)
  //   pthread_join(th[i], NULL);

  // double totalTime=0;
  // for(int i=0;i<numOfWorkerThread;i++)
  //   totalTime=totalTime+thPara[i].timeElapsed;
  // double avgDelay=totalTime/numOfWorkerThread/RUN_TIMES/NUMBERS_PER_RUN;
  // printf("Total time %.3lf s, Average time is %.5lf us\n",totalTime/1E6,avgDelay);

  exit(0);
}