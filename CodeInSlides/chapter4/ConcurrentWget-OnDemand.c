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

#define MAX_CONCURRENT_INPUT_NUM 10000
#define MAX_URL_LENGTH 1024

#define OUTPUT_FOLDER_NAME "testOutput"

long int totalNumOfJobsDone=0;
int totalThreadsCreated=0;
int concurrentThreadsNow=0;
int maxConcurrentThreads=0;
pthread_mutex_t counterMutex=PTHREAD_MUTEX_INITIALIZER;

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

void initOutputFolder()
{
  char command[1000];
  sprintf(command,"rm -rf %s",OUTPUT_FOLDER_NAME);
  int status=system(command);
  mkdir(OUTPUT_FOLDER_NAME, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
}

typedef struct {
  char *job;
  long int jobID;
} ThreadParas;

void* processJobsOnDemandThread(void* args) {
  pthread_mutex_lock(&counterMutex);
  totalThreadsCreated++;
  concurrentThreadsNow++;
  if(concurrentThreadsNow>maxConcurrentThreads)
    maxConcurrentThreads=concurrentThreadsNow;
  pthread_mutex_unlock(&counterMutex);
  ThreadParas* para = (ThreadParas*) args;
  char *job=para->job;
  long int jobID=para->jobID; 

  struct timeval tvStart,tvEnd;
  gettimeofday(&tvStart,NULL);
  char command[MAX_URL_LENGTH+1000];
  memset(command,0,(MAX_URL_LENGTH+1000)*sizeof(command[0]));
  sprintf(command,"wget %s -O %s/%05ld.html > %s/%05ld.log 2>&1",job,OUTPUT_FOLDER_NAME,jobID,OUTPUT_FOLDER_NAME,jobID);
  // printf("thread[%ld]: %s\n",jobID,command);
  int status=system(command);//get the URL page

  //Log time spent
  gettimeofday(&tvEnd,NULL);
  memset(command,0,(MAX_URL_LENGTH+1000)*sizeof(command[0]));
  sprintf(command,"echo \"[RESULT]: get URL %s , spend %.3lf s\" >> %s/%05ld.log"
    ,job,time_diff(tvStart,tvEnd)/1E6,OUTPUT_FOLDER_NAME,jobID);
  status=system(command);

  free(job);
  free(para);
  pthread_mutex_lock(&counterMutex);
  totalNumOfJobsDone++;
  concurrentThreadsNow--;
  pthread_mutex_unlock(&counterMutex);
}

void waitForAllJobsDone(int finalJobID)
{
  //Lazily wait all the worker threads finish their wget jobs
  while(1)
  {
    usleep(10000);//Check per 10 ms
    pthread_mutex_lock(&counterMutex);
    if(totalNumOfJobsDone==finalJobID)//All jobs done
    {  
      pthread_mutex_unlock(&counterMutex);
      break;
    }
    pthread_mutex_unlock(&counterMutex);
  }
}

int main(int argc, char *argv[])
{
  initOutputFolder();
  printf("Start to wget urls ...\n");

  long int nextJobID=0;
  ThreadParas *thPara;
  while(1)
  {
    thPara=malloc(sizeof(ThreadParas)); 
    thPara->job=malloc(MAX_URL_LENGTH*sizeof(thPara->job[0]));
    memset(thPara->job,0,MAX_URL_LENGTH*sizeof(thPara->job[0]));
    if(scanf("%s",thPara->job)==EOF)
      break;
    thPara->jobID=nextJobID;
    nextJobID++;
    pthread_t th;
    if(pthread_create(&th, NULL, processJobsOnDemandThread, thPara)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  
  waitForAllJobsDone(nextJobID);
  printf("Finish all jobs! Get %ld URLs in total!\n",totalNumOfJobsDone);
  printf("Create %d on-demand threads in total. There are %d max concurrent threads!\n"
    ,totalThreadsCreated,maxConcurrentThreads);
  //In real project, do free the memory and destroy mutexes and semaphores
  exit(0);
}