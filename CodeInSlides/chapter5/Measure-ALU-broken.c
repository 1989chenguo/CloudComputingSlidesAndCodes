#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/time.h>
#include <time.h>

#define RUN_TIMES 1000000000

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
  {
    int A=17, B=13, C=0;
    int i;
    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    for(i=0;i<RUN_TIMES;i++)
    {
    }
    gettimeofday(&tvEnd,NULL);
    double totalTime=time_diff(tvStart,tvEnd);
    double avgDelay=totalTime/RUN_TIMES;
    printf("[Pure loop: i=%d, res=%d] Total time %.3lf s, Average time is %.5lf us\n"
      ,i,C,totalTime/1E6,avgDelay);
  }

  {
    int A=17, B=13, C=0;
    int i;
    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A*B;
    }
    gettimeofday(&tvEnd,NULL);
    double totalTime=time_diff(tvStart,tvEnd);
    double avgDelay=totalTime/RUN_TIMES;
    printf("[int *: i=%d, res=%d] Total time %.3lf s, Average time is %.5lf us\n"
      ,i,C,totalTime/1E6,avgDelay);
  }

  {
    int A=17, B=13, C=0;
    int i;
    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A/B;
    }
    gettimeofday(&tvEnd,NULL);
    double totalTime=time_diff(tvStart,tvEnd);
    double avgDelay=totalTime/RUN_TIMES;
    printf("[int /: i=%d, res=%d] Total time %.3lf s, Average time is %.5lf us\n"
      ,i,C,totalTime/1E6,avgDelay);
  }

  {
    double A=17, B=13, C=0;
    int i;
    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A*B;
    }
    gettimeofday(&tvEnd,NULL);
    double totalTime=time_diff(tvStart,tvEnd);
    double avgDelay=totalTime/RUN_TIMES;
    printf("[double *: i=%d, res=%lf] Total time %.3lf s, Average time is %.5lf us\n"
      ,i,C,totalTime/1E6,avgDelay);
  }

  {
    double A=17, B=13, C=0;
    int i;
    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A/B;
    }
    gettimeofday(&tvEnd,NULL);
    double totalTime=time_diff(tvStart,tvEnd);
    double avgDelay=totalTime/RUN_TIMES;
    printf("[double /: i=%d, res=%lf] Total time %.3lf s, Average time is %.5lf us\n"
      ,i,C,totalTime/1E6,avgDelay);
  }
}