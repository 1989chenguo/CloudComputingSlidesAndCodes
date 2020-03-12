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

#define INPUT_JOB_NUM 102400
#define CHUNK_SIZE 4096

typedef unsigned char BYTE;

BYTE **inJob;
int nextJobToBeDone=0;
pthread_mutex_t jobQueueMutex=PTHREAD_MUTEX_INITIALIZER;

sem_t fullSlots; 

long int *subJob;
int subJobNum=0;
int nextSubJobToBeDone=0;
pthread_mutex_t subJobQueueMutex=PTHREAD_MUTEX_INITIALIZER;

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

long int generateJobs()
{
  long int totalBytes=0;
  inJob=malloc(INPUT_JOB_NUM*sizeof(BYTE *));
  for(int i=0;i<INPUT_JOB_NUM;i++)
  {
    inJob[i]=malloc(CHUNK_SIZE*sizeof(BYTE));
    memset(inJob[i],1,sizeof(BYTE)*CHUNK_SIZE);//Set all byte to be 1
    totalBytes=totalBytes+CHUNK_SIZE;
  }
  return totalBytes;
}

typedef struct {
  long int result;
} ThreadParas;

int recvAJob()
{
  int currentJobID=0;
  pthread_mutex_lock(&jobQueueMutex);
  if(nextJobToBeDone>=INPUT_JOB_NUM) 
  {
    pthread_mutex_unlock(&jobQueueMutex);
    return -1;
  }
  currentJobID=nextJobToBeDone;
  nextJobToBeDone++;
  pthread_mutex_unlock(&jobQueueMutex);
  return currentJobID;
}

void inputASubJob(long int sum)
{
  pthread_mutex_lock(&subJobQueueMutex);
  if(subJobNum>=INPUT_JOB_NUM) 
  {
    pthread_mutex_unlock(&subJobQueueMutex);
    fprintf(stderr, "subJobNum %d ERROR, exceeding INPUT_JOB_NUM %d\n", subJobNum, INPUT_JOB_NUM);
    exit(1);
  }
  subJob[subJobNum]=sum;
  subJobNum++;
  pthread_mutex_unlock(&subJobQueueMutex);
  sem_post(&fullSlots); 
}

void processAJob(int jobID, long int *sum)
{
  for(int j=0;j<CHUNK_SIZE;j++)
    *sum=*sum+inJob[jobID][j];
} 

void* calcSum(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  long int sum=0;
  int currentJobID=0;
  int *whichJobIHaveDone=malloc(INPUT_JOB_NUM*sizeof(int));//Remember which job I have done
  long int numOfJobsIHaveDone=0;//Remember how many jobs I have done
  while(1)
  {
    currentJobID=recvAJob();
    if(currentJobID==-1)//All job done!
      break;

    whichJobIHaveDone[numOfJobsIHaveDone]=currentJobID;
    numOfJobsIHaveDone++;
    
    processAJob(currentJobID,&sum);

    inputASubJob(sum);
  }
  pthread_t tid = pthread_self();       
  printf("[%ld] thread (sum of %ld inJobs["
    , pthread_self(), numOfJobsIHaveDone);
  printf("]): \t %ld\n", sum);
  para->result=sum;
}

void initSubJobQueue()
{
  subJob=malloc(INPUT_JOB_NUM*sizeof(long int));
}

int recvASubJob()
{
  int currentJobID=0;
  sem_wait(&fullSlots);
  pthread_mutex_lock(&subJobQueueMutex);
  currentJobID=nextSubJobToBeDone;
  nextSubJobToBeDone++;
  pthread_mutex_unlock(&subJobQueueMutex);
  return currentJobID;
}

void processASubJob(int jobID)
{
  fprintf(stderr,"%ld\n",subJob[jobID]);
}  

void* fprintSum(void* args) {
  int subJobID=0;
  long int numOfJobsIHaveDone=0;//Remember how many jobs I have done
  while(1)
  {
    subJobID=recvASubJob();
    processASubJob(subJobID);
    numOfJobsIHaveDone++;
    if(subJobID==INPUT_JOB_NUM-1)//All job done
      break;
  }
  pthread_t tid = pthread_self();       
  printf("[%ld] thread (fprint %ld subJobs[])\n"
    , pthread_self(), numOfJobsIHaveDone);
}

int main(int argc, char *argv[])
{
  int numOfWorkerThread=1;
  if(argc>=2)
    numOfWorkerThread=atoi(argv[1]);
  if(numOfWorkerThread>INPUT_JOB_NUM)
    numOfWorkerThread=INPUT_JOB_NUM;

  struct timeval tvGenStart,tvEnd;
  struct timeval tvWorkerStartCacl,tvWorkerEndCacl;

  printf("Generating input jobs ...\n");
  gettimeofday(&tvGenStart,NULL);
  long int totalBytes=generateJobs();
  gettimeofday(&tvEnd,NULL);
  printf("Generating input jobs done. Spend %.5lf s to finish. Total test input data size is %lf MBs\n",time_diff(tvGenStart,tvEnd)/1E6,(double)totalBytes/1E6);

  sem_init(&fullSlots, 0, 0); 
  initSubJobQueue();
  nextJobToBeDone=0;
  nextSubJobToBeDone=0;
  printf("Worker threads start doing jobs ...\n");
  gettimeofday(&tvWorkerStartCacl,NULL);
  pthread_t th[numOfWorkerThread];
  ThreadParas thPara[numOfWorkerThread];
  for(int i=0;i<numOfWorkerThread;i++)
  {
    if(pthread_create(&th[i], NULL, calcSum, &thPara[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  pthread_t thSub;
  if(pthread_create(&thSub, NULL, fprintSum, NULL)!=0)
  {
    perror("pthread_create failed");
    exit(1);
  }
  for(int i=0;i<numOfWorkerThread;i++)
    pthread_join(th[i], NULL);
  pthread_join(thSub, NULL);
  gettimeofday(&tvWorkerEndCacl,NULL);
  printf("Worker threads finish jobs. Spend %.5lf s to finish.\n",time_diff(tvWorkerStartCacl,tvWorkerEndCacl)/1E6);

  long int workerSum=0;
  for(int i=0;i<numOfWorkerThread;i++)
    workerSum=workerSum+thPara[i].result;
  printf("Sum of all %d threads: \t\t %ld\n", numOfWorkerThread, workerSum);

  //In real project, do free the memory and destroy mutexes and semaphores
  exit(0);
}