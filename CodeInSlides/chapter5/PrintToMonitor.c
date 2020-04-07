#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/time.h>
#include <time.h>

#define RUN_TIMES 100000

pthread_mutex_t testMutex=PTHREAD_MUTEX_INITIALIZER;

double time_diff(struct timeval x , struct timeval y)
{
  double x_ms , y_ms , diff;
  x_ms = (double)x.tv_sec*1000000 + (double)x.tv_usec;
  y_ms = (double)y.tv_sec*1000000 + (double)y.tv_usec;
  diff = (double)y_ms - (double)x_ms;
  return diff;
}

int main(int argc, char *argv[])
{
  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  for(int i=0;i<RUN_TIMES;i++)
  {
    fprintf(stdout, "123456789123456789123456789123456789123456789123456789123456789123456789123456789");
  }
  fflush(stdout);
  gettimeofday(&tvEnd,NULL);

  double totalTime=time_diff(tvStart,tvEnd);
  double avgDelay=totalTime/RUN_TIMES;

  printf("\nTotal time %.3lf s, Average time is %.5lf us\n",totalTime/1E6,avgDelay);
  exit(0);
}