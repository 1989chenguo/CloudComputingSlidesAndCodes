#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>
#include <stack>
#include <sched.h>
#include <semaphore.h> 

#define IF_PRINT_DEBUG 0
#define CONCURRENT_THREAD_NUM 4
#define MIN_ARRAY_LEN_FOR_CREATE_A_THREAD_TO_SORT 100000

typedef struct {
  int* array;
  int left;
  int right;
} SortJob;

std::stack<SortJob> sortJobStackGlobal;
pthread_mutex_t sortJobStackMutex=PTHREAD_MUTEX_INITIALIZER;
sem_t sortJobStackEmptySlots;
int ifThreadBusy[CONCURRENT_THREAD_NUM];
//ifThreadBusy[i] indicates if a thread is doing sorting job
//If all ifThreadBusy[i]==0, then the whole sort has finished and we can exit
int ifAllThreadExit;//Flag for main thread to notify worker exit

double time_diff(struct timeval x , struct timeval y);
void swap(int* array,int first,int second);
int PartSort(int* array,int left,int right);
void* QuickSortParallel(void* args);
void QuickSortSequential(int* array, int left, int right);
int createAThreadToQuickSort(int *array, int left, int right, pthread_t *th);

void initParallelSort(int *array, int sortArrayLen)
{
  SortJob job;
  job.array=array;
  job.left=0;
  job.right=sortArrayLen-1;
  sortJobStackGlobal.push(job);
  for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
    ifThreadBusy[i]=0;
  ifAllThreadExit=0;
  sem_destroy(&sortJobStackEmptySlots); 
  pthread_mutex_destroy(&sortJobStackMutex);

  sem_init(&sortJobStackEmptySlots, 0, 1); 
  pthread_mutex_init(&sortJobStackMutex,NULL);
}

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

void swap(int* array,int first,int second)
{
  int tmp;
  tmp=array[first];
  array[first]=array[second];
  array[second]=tmp;
}

//左右指针法
int PartSort(int* array,int left,int right)
{
    int key = right;
    while(left < right)
    {
        while(left < right && array[left] <= array[key])
            ++left;
        while(left < right && array[right] >= array[key])
            --right;
        swap(array,left,right);
    }
    swap(array,left,key);
    return left;
}

void* QuickSortParallel(void* args)
{
  int *threadID=(int *) args;
  if(IF_PRINT_DEBUG==2)
    printf("Thread[%d] start.\n",*threadID);
  SortJob job;
  while(1)
  {
    sem_wait(&sortJobStackEmptySlots); 
    pthread_mutex_lock(&sortJobStackMutex);
    if(ifAllThreadExit==1) {
      if(IF_PRINT_DEBUG==2)
        printf("Thread[%d] exit.\n",*threadID);
      pthread_mutex_unlock(&sortJobStackMutex);
      break;
    }
    job = sortJobStackGlobal.top();
    sortJobStackGlobal.pop();
    int left=job.left;
    int right=job.right;
    ifThreadBusy[*threadID]=1;
    pthread_mutex_unlock(&sortJobStackMutex);
    if(right-left>=MIN_ARRAY_LEN_FOR_CREATE_A_THREAD_TO_SORT)
    {
      int index = PartSort(job.array,left,right);
      if(IF_PRINT_DEBUG==2)
        printf("Thread[%d]: PartSort[%d-%d] ifThreadBusy=%d\n"
          ,*threadID,job.left,job.right,ifThreadBusy[*threadID]);
      pthread_mutex_lock(&sortJobStackMutex);
      if((index - 1) > left)//左子序列
      {
        job.left=left;
        job.right=index - 1;
        sortJobStackGlobal.push(job);
        sem_post(&sortJobStackEmptySlots);
        if(IF_PRINT_DEBUG==2)
          printf("Thread[%d]: push[%d-%d] ifThreadBusy=%d\n"
            ,*threadID,job.left,job.right,ifThreadBusy[*threadID]);
      }
      if((index + 1) < right)//右子序列
      {
        job.left=index + 1;
        job.right=right;
        sortJobStackGlobal.push(job);
        sem_post(&sortJobStackEmptySlots);
        if(IF_PRINT_DEBUG==2)
          printf("Thread[%d]: push[%d-%d] ifThreadBusy=%d\n"
            ,*threadID,job.left,job.right,ifThreadBusy[*threadID]);
      }
      ifThreadBusy[*threadID]=0;
      pthread_mutex_unlock(&sortJobStackMutex);
    }
    else
    {
      if(IF_PRINT_DEBUG==2)
        printf("Thread[%d]: QuickSortSequential[%d-%d] ifThreadBusy=%d\n"
          ,*threadID,job.left,job.right,ifThreadBusy[*threadID]);
      QuickSortSequential(job.array,left,right);
      pthread_mutex_lock(&sortJobStackMutex);
      ifThreadBusy[*threadID]=0;
      pthread_mutex_unlock(&sortJobStackMutex); 
    }
  }
}

void QuickSortSequential(int* array, int left, int right)
{
  SortJob job;
  job.array=array;
  job.left=left;
  job.right=right;
  std::stack<SortJob> sortJobStack;
  sortJobStack.push(job);
  while(1)
  {
    if(sortJobStack.empty())
      break;
    job = sortJobStack.top();
    sortJobStack.pop();
    int left=job.left;
    int right=job.right;

    int index = PartSort(job.array,job.left,job.right);
    if((index - 1) > left)//左子序列
    {
      job.left=left;
      job.right=index - 1;
      sortJobStack.push(job);
    }
    if((index + 1) < right)//右子序列
    {
      job.left=index + 1;
      job.right=right;
      sortJobStack.push(job);
    }
  }
}

void waitSortDoneAndNotifyAllThreadsToExit()
{
  while(1)
  {
    usleep(10000);//Check every 10ms
    pthread_mutex_lock(&sortJobStackMutex);
    if(sortJobStackGlobal.empty())
    {
      int exit=1;
      for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
      {
        if(ifThreadBusy[i]==1)
        {
          exit=0;
          break;
        }
      }
      if(exit==1) {
        ifAllThreadExit=1;
        for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
          sem_post(&sortJobStackEmptySlots);//Wakeup all waiting threads
        //They will exit since they check ifAllThreadExit whenever wakeup
        pthread_mutex_unlock(&sortJobStackMutex);
        break; // Exit waiting
      }
    }
    pthread_mutex_unlock(&sortJobStackMutex);
  }
}

void doSortTest(int sortArrayLen, int runTimes, int ifSequential)//ifSequential 0 for parallel version, else for sequential version
{
  int *array=(int *)malloc(sizeof(array[0])*sortArrayLen);

  double totalSortTime=0;
  for(int n=0;n<runTimes;n++)
  {
    for(int i=0;i<sortArrayLen;i++)
    {
      array[i]=rand()%sortArrayLen;
    }
    if(IF_PRINT_DEBUG)
    {
      printf("RUN[%d] Original:\n",n);
      for(int i=0;i<sortArrayLen;i++)
        printf("%d ", array[i]);
      printf("\n");
    }

    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    if(ifSequential==0) {
      initParallelSort(array,sortArrayLen);
      pthread_t th[CONCURRENT_THREAD_NUM];
      int threadID[CONCURRENT_THREAD_NUM];
      for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
      {
        threadID[i]=i;
        if(pthread_create(&th[i], NULL, QuickSortParallel, &threadID[i])!=0)
        {
          perror("pthread_create failed");
          exit(1);
        }
      }
      waitSortDoneAndNotifyAllThreadsToExit();
      for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
        pthread_join(th[i], NULL);
      printf("RUN[%d] Parallel sort done. %d long-lived threads. ",n,CONCURRENT_THREAD_NUM);
    } 
    else {
      QuickSortSequential(array,0,sortArrayLen-1);
      printf("RUN[%d] Sequential sort done. ",n);
    }
    gettimeofday(&tvEnd,NULL);
    totalSortTime=totalSortTime+time_diff(tvStart,tvEnd);
    printf("Spend %.5lf s.\n",time_diff(tvStart,tvEnd)/1E6);
    if(IF_PRINT_DEBUG)
    {
      printf("RUN[%d] Sorted:\n",n);
      for(int i=0;i<sortArrayLen;i++)
        printf("%d ", array[i]);
      printf("\n");
    }
  }

  if(ifSequential==0)
    printf("Parallel sort all done.\n");
  else
    printf("Sequential sort all done.\n");
  printf("Run %d times sort. Spend %.5lf s in total, %.5lf s per sort.\n"
    ,runTimes,totalSortTime/1E6,totalSortTime/1E6/runTimes);

  free(array);
}

int main(int argc, char *argv[])
{
    int sortArrayLen=10000000;
    if(argc>=2)
      sortArrayLen=atoi(argv[1]);
    int sortTimes=1;
    if(argc>=3)
      sortTimes=atoi(argv[2]);

    srand(time(NULL));

    doSortTest(sortArrayLen,sortTimes,1);//Sequential sort
    doSortTest(sortArrayLen,sortTimes,0);//Parallel sort
    
    return 0;
}

