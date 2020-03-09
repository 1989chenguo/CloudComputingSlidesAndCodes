#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define NUM_ARR_SIZE 5000

int num[NUM_ARR_SIZE];

void* calcSum1(void* args) {
  int sum=0;
  for(int i=0;i<2500;i++)
    sum=sum+num[i];
  pthread_t tid = pthread_self();       
  printf("[%ld] worker thread: \t %d\n", pthread_self(), sum);
}

void* calcSum2(void* args) {
  int sum=0;
  for(int i=2500;i<NUM_ARR_SIZE;i++)
    sum=sum+num[i];
  pthread_t tid = pthread_self();       
  printf("[%ld] worker thread: \t %d\n", pthread_self(), sum);
}

int main(int argc, char *argv[])
{
  for(int i=0;i<NUM_ARR_SIZE;i++)
  {
    num[i]=rand()%100;
  }

  int sum=0;
  for(int i=0;i<NUM_ARR_SIZE;i++)
    sum=sum+num[i];
  printf("[%ld] main thread: \t\t %d\n", pthread_self(), sum);

  pthread_t th1;
  if(pthread_create(&th1, NULL, calcSum1, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }

  pthread_t th2;
  if(pthread_create(&th2, NULL, calcSum2, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);

  exit(0);
}

// typedef struct {
//   int first;
//   int last;
//   int result;
// } ThreadParas;

// void* calcSum(void* args) {
//   ThreadParas* para = (ThreadParas*) args;
//   int first=para->first;
//   int last=para->last;
//   int sum=0;
//   for(int i=first;i<last;i++)
//     sum=sum+num[i];
//   pthread_t tid = pthread_self();       
//   printf("[%ld] worker thread (sum of num[%04d]-num[%04d]): \t %d\n"
//     , pthread_self()
//     , first
//     , last-1
//     , sum);
//   para->result=sum;
// }


// int main(int argc, char *argv[])
// {
//   int numOfWorkerThread=1;
//   if(argc>=2)
//     numOfWorkerThread=atoi(argv[1]);
//   if(numOfWorkerThread>NUM_ARR_SIZE)
//     numOfWorkerThread=NUM_ARR_SIZE;

//   for(int i=0;i<NUM_ARR_SIZE;i++)
//   {
//     num[i]=rand()%100;
//   }

//   int sum=0;
//   for(int i=0;i<NUM_ARR_SIZE;i++)
//     sum=sum+num[i];
//   printf("[%ld] main thread: \t\t %d\n", pthread_self(), sum);

//   pthread_t th[numOfWorkerThread];
//   ThreadParas thPara[numOfWorkerThread];
//   for(int i=0;i<numOfWorkerThread;i++)
//   {
//     int first=(int)(NUM_ARR_SIZE/numOfWorkerThread)*i;
//     int last;
//     if(i!=numOfWorkerThread-1)
//       last=(int)(NUM_ARR_SIZE/numOfWorkerThread)*(i+1);
//     else
//       last=NUM_ARR_SIZE;
//     thPara[i].first=first;
//     thPara[i].last=last;

//     if(pthread_create(&th[i], NULL, calcSum, &thPara[i])!=0)
//     {
//       perror("pthread_create failed");
//       exit(1);
//     }
//   }
  
//   for(int i=0;i<numOfWorkerThread;i++)
//     pthread_join(th[i], NULL);

//   int workerSum=0;
//   for(int i=0;i<numOfWorkerThread;i++)
//     workerSum=workerSum+thPara[i].result;
//   printf("Sum of all %d threads: \t\t %d\n", numOfWorkerThread, workerSum);

//   exit(0);
// }