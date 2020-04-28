#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>

#define IF_PRINT_DEBUG 0

int concurrentThreadNum=0;
int maxConcurrentThreadNumEverAppeared=0;
int totalThreadCreated=0;

pthread_mutex_t threadNumMutex=PTHREAD_MUTEX_INITIALIZER;
// To strictly limit the concurrent thread num, we should use this mutex
// However, this may hurt performance a little. 
// As such, you can delete this mutex. 
// If so, the concurrent thread num may exceed the limit a little, but not affect the correctness

double time_diff(struct timeval x , struct timeval y);
void swap(int* array,int first,int second);
int PartSort(int* array,int left,int right);
void* QuickSortParallel(void* args);
void QuickSortSequential(int* array, int left, int right);
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

typedef struct {
  int* array;
  int left;
  int right;
} SortArgs;

void* QuickSortParallel(void* args)
{
  SortArgs* para = (SortArgs*) args;
  int *array=para->array;
  int left=para->left;
  int right=para->right;
  free(para);

  if(left >= right)
      return NULL;

  int index = PartSort(array,left,right);
  
  pthread_t th1;
  int re1=createAThreadToQuickSort(array,left,index-1,&th1);
  pthread_t th2;
  int re2=createAThreadToQuickSort(array,index+1,right,&th2);
  if(re1==1) {
    pthread_join(th1, NULL);
    pthread_mutex_lock(&threadNumMutex);
    concurrentThreadNum--;
    pthread_mutex_unlock(&threadNumMutex);
  }
  if(re2==1) {
    pthread_join(th2, NULL);
    pthread_mutex_lock(&threadNumMutex);
    concurrentThreadNum--;
    pthread_mutex_unlock(&threadNumMutex);
  }
}

void QuickSortSequential(int* array, int left, int right)
{
  if(left >= right)
      return;

  int index = PartSort(array,left,right);
  
  QuickSortSequential(array,left,index-1);
  QuickSortSequential(array,index+1,right);
}

void* QuickSortSequentialThread(void* args)
{
  SortArgs* para = (SortArgs*) args;
  int *array=para->array;
  int left=para->left;
  int right=para->right;
  free(para);

  // printf("QuickSortSequentialThread: left %d, right %d\n",left,right);
  
  if(left >= right)
      return NULL;

  int index = PartSort(array,left,right);
  
  QuickSortSequential(array,left,index-1);
  QuickSortSequential(array,index+1,right);
}


//Do not create thread if there are too many concurrent threads
//Return 1 if create new thread, else return 0
int createAThreadToQuickSort(int *array, int left, int right, pthread_t *th)
{
  int re=0;

  SortArgs *sortPara = malloc(sizeof(SortArgs));
  sortPara->array=array;
  sortPara->left=left;
  sortPara->right=right;
  if(pthread_create(th, NULL, QuickSortParallel, sortPara)!=0)
  // if(pthread_create(th, NULL, QuickSortSequentialThread, sortPara)!=0)
  {
    //Cannot create thread, sort sequentially
    QuickSortSequential(array,left,right);
    re=0;
  }
  else
  {
    //Create a thread, return 1 so the outer function will wait me
    re=1;
  }
  return re;
}

void doSortTest(int sortArrayLen, int runTimes, int ifSequential)//ifSequential 0 for parallel version, else for sequential version
{
  int *array=malloc(sizeof(array[0])*sortArrayLen);

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

    totalThreadCreated=0;
    concurrentThreadNum=0;
    maxConcurrentThreadNumEverAppeared=0;

    struct timeval tvStart,tvEnd;
    gettimeofday(&tvStart,NULL);
    if(ifSequential==0) {
      SortArgs *sortPara = malloc(sizeof(SortArgs));
      sortPara->array=array;
      sortPara->left=0;
      sortPara->right=sortArrayLen-1;
      QuickSortParallel(sortPara);
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
    int sortTimes=1;
    if(argc>=3)
      sortTimes=atoi(argv[2]);

    srand(time(NULL));

    doSortTest(sortArrayLen,sortTimes,1);//Sequential sort
    doSortTest(sortArrayLen,sortTimes,0);//Parallel sort
    
    return 0;
}

