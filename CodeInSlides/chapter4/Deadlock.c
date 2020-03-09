#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define ITERATION_PER_THREAD 10

typedef struct 
{
  pthread_mutex_t mutex; // lock for this resource
  int processTime; // process time for this resource (in microseconds)
} Resource;
Resource *globalResources; // Shared resources among threads. resources[i] is resource type i 

pthread_mutex_t bigMutex; // lock for all global resources

void processResource(Resource resource) 
{
  usleep(resource.processTime); // Use sleep to emulate processing time for a resource
}

typedef struct
{
  int threadID;
  int totalResourceNum;
  int numOfResourceNeeded;//How many resources this thread needs to process
  int *resourceAccessOrder; 
  // resourceAccessOrder[i] is the ith resource's type that this thread needs to process
  int ifUseBigLock;// 1 means grab all resources before processing
} ThreadArgs;

void printThreadArgs(ThreadArgs args)
{
  printf("Thread %d args: \t\t totalResourceNum %d, numOfResourceNeeded %d, resourceAccessOrder("
        ,args.threadID ,args.totalResourceNum ,args.numOfResourceNeeded);
  fflush(stdout);
  for(int j=0;j<args.numOfResourceNeeded;j++)
  {
    printf("%d",args.resourceAccessOrder[j]);
    if(j==args.numOfResourceNeeded-1)
      printf(")\n");
    else
      printf(", ");
  }
}

void *workThread(void *args) {
  // printf("Hello thread %ld\n",pthread_self());
  ThreadArgs *para = (ThreadArgs *) args;
  int threadID=para->threadID;
  int numOfResourceNeeded=para->numOfResourceNeeded;
  int *resourceAccessOrder=para->resourceAccessOrder;
  int ifUseBigLock=para->ifUseBigLock;
  for(int i=0;i<ITERATION_PER_THREAD;i++)
  {
    if(ifUseBigLock)
    {
      pthread_mutex_lock(&bigMutex);
      for(int j=0;j<numOfResourceNeeded;j++)
      {
        int resourceType=resourceAccessOrder[j];
        printf("Process resource: \t\t Thread.Iteration.ResourceType %d.%d.%d\n"
          ,threadID, i, resourceType);
        processResource(globalResources[resourceType]);
      }
      pthread_mutex_unlock(&bigMutex);
    }
    else
    {
      //Get lock and process resource one by one
      for(int j=0;j<numOfResourceNeeded;j++)
      {
        int resourceType=resourceAccessOrder[j];
        pthread_mutex_lock(&(globalResources[resourceType].mutex));
        printf("Process resource: \t\t Thread.Iteration.ResourceType %d.%d.%d\n"
          ,threadID, i, resourceType);
        processResource(globalResources[resourceType]);
      }
      //Release lock one by one
      for(int j=numOfResourceNeeded-1;j>=0;j--)
      {
        int resourceType=resourceAccessOrder[j];
        pthread_mutex_unlock(&(globalResources[resourceType].mutex));
      }
    } 
  }
}

void pickKDifferentIntLessThanN(int k, int n, int *result)
{
  //Fisher-Yates shuffling algorithm to get a random permutation of int 0...n-1
  int *r = malloc(n*sizeof(int));
  // initial range of numbers
  for(int i=0;i<n;++i){
      r[i]=i;
  }
  for (int i=n-1; i>= 0; --i)
  {
    //generate a random number [0, n-1]
    int j = rand() % (i+1);

    //swap the last element with element at random index
    int temp = r[i];
    r[i] = r[j];
    r[j] = temp;
  }

  for(int i=0;i<k;i++)
    result[i]=r[i];

  free(r);
}

int compare (const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}

void setResourceNeededAndAccessOrder(ThreadArgs *thPara, int ifSortAccess)
{
  thPara->resourceAccessOrder=malloc((thPara->numOfResourceNeeded)*sizeof(int));
  pickKDifferentIntLessThanN(thPara->numOfResourceNeeded, thPara->totalResourceNum, thPara->resourceAccessOrder);
  if(ifSortAccess==1)//ifSortAccess: 1 all use the same ascending order
    qsort(thPara->resourceAccessOrder, thPara->numOfResourceNeeded, sizeof(int), compare);
}

int main(int argc, char *argv[])
{
  if(argc<3)
  {
    fprintf(stderr, "Usage: exe numOfWorkerThread totalResourceNum\n");
    exit(1);
  }
  int numOfWorkerThread=atoi(argv[1]);
  int totalResourceNum=atoi(argv[2]);
  int resourceNeededPerThread=1;
  if(argc>3)
    resourceNeededPerThread=atoi(argv[3]);
  int ifUseBigLock=0;
  if(argc>4)
    ifUseBigLock=atoi(argv[4]);
  int ifSortAccess=0;
  if(argc>5)
    ifSortAccess=atoi(argv[5]);

  srand(time(NULL));

  if(ifUseBigLock)
    pthread_mutex_init(&bigMutex,NULL);
  globalResources=malloc(sizeof(Resource)*totalResourceNum);
  for(int i=0;i<totalResourceNum;i++)
  {
    pthread_mutex_init(&(globalResources[i].mutex),NULL);
    globalResources[i].processTime=rand()%10000+10000; // from 10ms to 20ms
  }

  printf("Ready to run: \t numOfWorkerThread=%d \t totalResourceNum=%d \t resourceNeededPerThread=%d \t ifUseBigLock=%d \t ifSortAccess=%d\n"
    , numOfWorkerThread, totalResourceNum, resourceNeededPerThread, ifUseBigLock, ifSortAccess);
  pthread_t th[numOfWorkerThread];
  ThreadArgs thPara[numOfWorkerThread];
  for(int i=0;i<numOfWorkerThread;i++)
  {
    thPara[i].threadID=i;
    thPara[i].totalResourceNum=totalResourceNum;
    thPara[i].numOfResourceNeeded=resourceNeededPerThread;
    setResourceNeededAndAccessOrder(&thPara[i],ifSortAccess);
    thPara[i].ifUseBigLock=ifUseBigLock;
    printThreadArgs(thPara[i]);
  }
  printf("\n\n\n========= Running ===========\n");
  for(int i=0;i<numOfWorkerThread;i++)
  {
    if(pthread_create(&th[i], NULL, workThread, &thPara[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  for(int i=0;i<numOfWorkerThread;i++)
    pthread_join(th[i], NULL);
  printf("========= Done ===========\n\n\n");
  printf("Finish run: \t numOfWorkerThread=%d \t totalResourceNum=%d \t resourceNeededPerThread=%d \t ifUseBigLock=%d \t ifSortAccess=%d\n"
    , numOfWorkerThread, totalResourceNum, resourceNeededPerThread, ifUseBigLock, ifSortAccess);

  if(ifUseBigLock)
    pthread_mutex_destroy(&bigMutex);
  for(int i=0;i<numOfWorkerThread;i++)
    pthread_mutex_destroy(&(globalResources[i].mutex));
  for(int i=0;i<numOfWorkerThread;i++)
    free(thPara[i].resourceAccessOrder);
  free(globalResources);

  exit(0);
}