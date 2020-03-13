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

#define IF_PRINT_DEBUG 0
#define CONCURRENT_THREAD_NUM 2

typedef struct {
  int* array;
  int left;
  int right;
} SortJob;

std::stack<SortJob> sortJobStack;
pthread_mutex_t sortJobStackMutex=PTHREAD_MUTEX_INITIALIZER;
int busyThreadNum=0;
pthread_mutex_t busyThreadNumMutex=PTHREAD_MUTEX_INITIALIZER;

double time_diff(struct timeval x , struct timeval y);
void swap(int* array,int first,int second);
int PartSort(int* array,int left,int right);
void* QuickSortParallel(void* args);
int createAThreadToQuickSort(int *array, int left, int right, pthread_t *th);


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
  SortJob job;
  while(1)
  {
    pthread_mutex_lock(&sortJobStackMutex);
    if(sortJobStack.empty()) {
      pthread_mutex_unlock(&sortJobStackMutex);
      sched_yield();
      continue;
    }
    pthread_mutex_lock(&busyThreadNumMutex);
    busyThreadNum++;
    pthread_mutex_unlock(&busyThreadNumMutex);
    job = sortJobStack.top();
    sortJobStack.pop();
    int left=job.left;
    int right=job.right;
    pthread_mutex_unlock(&sortJobStackMutex);

    int index = PartSort(job.array,job.left,job.right);
    if((index - 1) > left)//左子序列
    {
      job.left=left;
      job.right=index - 1;
      pthread_mutex_lock(&sortJobStackMutex);
      sortJobStack.push(job);
      pthread_mutex_unlock(&sortJobStackMutex);
    }
    if((index + 1) < right)//右子序列
    {
      job.left=index + 1;
      job.right=right;
      pthread_mutex_lock(&sortJobStackMutex);
      sortJobStack.push(job);
      pthread_mutex_unlock(&sortJobStackMutex);
    }
    pthread_mutex_lock(&busyThreadNumMutex);
    busyThreadNum--;
    pthread_mutex_unlock(&busyThreadNumMutex);
  }
}

void QuickSortSequential(int* array, int left, int right)
{
  SortJob job;
  job.array=array;
  job.left=left;
  job.right=right;
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

void waitForSortThreadsToFinish()
{
  while(1) 
  {
    usleep(10000);
    pthread_mutex_lock(&sortJobStackMutex);
    pthread_mutex_lock(&busyThreadNumMutex);
    if(sortJobStack.empty() && busyThreadNum==0) {
      pthread_mutex_unlock(&sortJobStackMutex);
      pthread_mutex_unlock(&busyThreadNumMutex);
      break;
    }
    pthread_mutex_unlock(&sortJobStackMutex);
    pthread_mutex_unlock(&busyThreadNumMutex);
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
      SortJob job;
      job.array=array;
      job.left=0;
      job.right=sortArrayLen-1;
      sortJobStack.push(job);
      pthread_t th[CONCURRENT_THREAD_NUM];
      for(int i=0;i<CONCURRENT_THREAD_NUM;i++)
      {
        if(pthread_create(&th[i], NULL, QuickSortParallel, NULL)!=0)
        {
          perror("pthread_create failed");
          exit(1);
        }
      }
      waitForSortThreadsToFinish();
      printf("RUN[%d] Parallel sort done. ",n);
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
    int sortTimes=20;
    if(argc>=3)
      sortTimes=atoi(argv[2]);

    srand(time(NULL));

    doSortTest(sortArrayLen,sortTimes,1);//Sequential sort
    doSortTest(sortArrayLen,sortTimes,0);//Parallel sort
    
    return 0;
}

