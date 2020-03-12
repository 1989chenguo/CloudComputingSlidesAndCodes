#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>
#include <semaphore.h>

#define MAX_CONCURRENT_INPUT_NUM 100
#define MAX_URL_LENGTH 1024

#define OUTPUT_FOLDER_NAME "testOutput"

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

typedef unsigned char BYTE;
int *threadFlags;

typedef struct {
  char **jobs;
  int head;
  int tail;
  long int inCount;
  long int outCount;
  pthread_mutex_t mutex;
  sem_t fullSlots; 
  sem_t emptySlots;
  int queueCapacity;
} JobQueue;

JobQueue inJobQueue;

void initJobQueue()
{
  inJobQueue.jobs=malloc(MAX_CONCURRENT_INPUT_NUM*sizeof(inJobQueue.jobs[0]));
  for(int i=0;i<MAX_CONCURRENT_INPUT_NUM;i++)
    inJobQueue.jobs[i]=malloc(MAX_URL_LENGTH*sizeof(inJobQueue.jobs[0][0]));
  inJobQueue.head=0;
  inJobQueue.tail=0;
  inJobQueue.inCount=0;
  inJobQueue.outCount=0;
  inJobQueue.queueCapacity=MAX_CONCURRENT_INPUT_NUM; 
  pthread_mutex_init(&inJobQueue.mutex,NULL);
  sem_init(&inJobQueue.fullSlots, 0, 0); 
  sem_init(&inJobQueue.emptySlots, 0, MAX_CONCURRENT_INPUT_NUM);
}

int dequeueAJob(char *job)
{
  int jobID=0;
  sem_wait(&inJobQueue.fullSlots);
  pthread_mutex_lock(&inJobQueue.mutex);
  memcpy(job,inJobQueue.jobs[inJobQueue.head],MAX_URL_LENGTH*sizeof(job[0]));
  inJobQueue.head=(inJobQueue.head+1)%inJobQueue.queueCapacity;
  jobID=inJobQueue.outCount;
  inJobQueue.outCount++;
  pthread_mutex_unlock(&inJobQueue.mutex);
  sem_post(&inJobQueue.emptySlots); 
  return jobID;
}

void enqueueAJob(char *job)
{
  sem_wait(&inJobQueue.emptySlots);
  pthread_mutex_lock(&inJobQueue.mutex);
  memcpy(inJobQueue.jobs[inJobQueue.tail],job,MAX_URL_LENGTH*sizeof(job[0]));
  inJobQueue.tail=(inJobQueue.tail+1)%inJobQueue.queueCapacity;
  inJobQueue.inCount++;
  pthread_mutex_unlock(&inJobQueue.mutex);
  sem_post(&inJobQueue.fullSlots);
}

void initOutputFolder()
{
  char command[1000];
  sprintf(command,"rm -rf %s",OUTPUT_FOLDER_NAME);
  int status=system(command);
  mkdir(OUTPUT_FOLDER_NAME, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
}

void* processJobsLongLiveThread(void* args) {
  int* id = (int*) args;
  long int numOfJobsIHaveDone=0;//Remember how many jobs I have done
  char job[MAX_URL_LENGTH]={0};
  int jobID;
  char command[MAX_URL_LENGTH+1000];
  struct timeval tvStart,tvEnd;
  while(1)
  {
    jobID=dequeueAJob(job);
    gettimeofday(&tvStart,NULL);
    threadFlags[*id]=1;// In busy state
    numOfJobsIHaveDone++;
    memset(command,0,(MAX_URL_LENGTH+1000)*sizeof(command[0]));
    sprintf(command,"wget %s -O %s/%05d.html > %s/%05d.log 2>&1",job,OUTPUT_FOLDER_NAME,jobID,OUTPUT_FOLDER_NAME,jobID);
    // printf("thread[%d]: %s\n",*id,command);
    int status=system(command);//get the URL page

    //Log time spent
    gettimeofday(&tvEnd,NULL);
    memset(command,0,(MAX_URL_LENGTH+1000)*sizeof(command[0]));
    sprintf(command,"echo \"[RESULT]: get URL %s , spend %.3lf s\" >> %s/%05d.log"
      ,job,time_diff(tvStart,tvEnd)/1E6,OUTPUT_FOLDER_NAME,jobID);
    status=system(command);
    threadFlags[*id]=0;// In idle state
  }
}

void waitForAllJobsDone(int numOfWorkerThread)
{
  //Lazily wait all the worker threads finish their wget jobs
  while(1)
  {
    usleep(10000);//Check per 10 ms
    int stopFlag=1;
    if(inJobQueue.outCount==inJobQueue.inCount)
    {
      for(int i=0;i<numOfWorkerThread;i++)
      {
        if(threadFlags[i]==1)//not in idle state
        {
          stopFlag=0;
          break;
        }
      }
      if(stopFlag==1)// All worker threads in idle and no jobs wait in the queue.
        break;
    }
  }
}

int main(int argc, char *argv[])
{
  int numOfWorkerThread=1;
  if(argc>=2)
    numOfWorkerThread=atoi(argv[1]);

  initJobQueue();
  initOutputFolder();

  printf("Start to wget urls ...\n");

  threadFlags=malloc(numOfWorkerThread*sizeof(threadFlags[0]));
  pthread_t th[numOfWorkerThread];
  int threadID[numOfWorkerThread];
  for(int i=0;i<numOfWorkerThread;i++)
  {
    threadID[i]=i;
    if(pthread_create(&th[i], NULL, processJobsLongLiveThread, &threadID[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }

  char url[MAX_URL_LENGTH]={0}; 
  while(scanf("%s",url)!=EOF)
  {
    enqueueAJob(url);
  }
  
  waitForAllJobsDone(numOfWorkerThread);
  printf("Finish all jobs! Get %ld URLs in total!\n",inJobQueue.outCount);
  //In real project, do free the memory and destroy mutexes and semaphores
  exit(0);
}