#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>

#define INPUT_JOB_NUM 10
#define INPUT_FOLDER_NAME "testInput"

#define THE_HEAVY_JOB_ID 1
int THE_HEAVY_WEIGHT=1;

#define CHUNK_SIZE 4096
#define TOTAL_CHUNK_NUM 10240

typedef unsigned char BYTE;

char inJob[INPUT_JOB_NUM][256];

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
  char command[1000];
  sprintf(command,"rm -rf %s",INPUT_FOLDER_NAME);
  int status=system(command);
  mkdir(INPUT_FOLDER_NAME, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
  BYTE writeBuf[CHUNK_SIZE];
  int writeSize=0;
  for(int i=0;i<CHUNK_SIZE;i++)
    writeBuf[i]=1;//All byte set to be 1
  long int totalBytes=0;
  for(int i=0;i<INPUT_JOB_NUM;i++)
  {
    sprintf(inJob[i], "%s/testInput%04d.txt",INPUT_FOLDER_NAME,i);
    FILE *fp;
    if((fp = fopen(inJob[i],"w"))==NULL)
    {
      perror("fopen ERROR!");
      exit(1);
    }
    int heavyScale=1;
    if(i==THE_HEAVY_JOB_ID)
      heavyScale=THE_HEAVY_WEIGHT;
    for(int j=0;j<TOTAL_CHUNK_NUM*heavyScale;j++)
    {
      while(1)//Write until this CHUNK_SIZE has all been written
      {
        writeSize=writeSize+fwrite(writeBuf, 1, CHUNK_SIZE-writeSize, fp);
        totalBytes=totalBytes+writeSize;
        if(writeSize<0) {
          perror("write ERROR!");
          exit(1);
        }
        else if(writeSize==CHUNK_SIZE) {
          //This CHUNK_SIZE done, go to the next CHUNK_SIZE
          writeSize=0;
          break;
        }
      }
    }
    fclose(fp);   
  }
  return totalBytes;
}

typedef struct {
  int first;
  int last;
  long int result;
} ThreadParas;

void processAJob(int jobID, long int *sum)
{
  BYTE readBuf[CHUNK_SIZE]={0};
  int readSize=0;
  FILE *fp;
  if((fp = fopen(inJob[jobID],"r"))==NULL)
  {
    perror("fopen ERROR!");
    exit(1);
  }
  while(1)//Read until EOF
  {
    readSize=fread(readBuf, 1, CHUNK_SIZE, fp);
    if(readSize<0){
      perror("read ERROR!");
      exit(1);
    }
    else if(readSize==0){ //EOF
      break;
    }
    for(int j=0;j<readSize;j++)
      *sum=*sum+readBuf[j];
    memset(readBuf,0,sizeof(BYTE)*readSize);
  }
  fclose(fp);
}

void* calcSum(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  int first=para->first;
  int last=para->last;
  long int sum=0;
  for(int i=first;i<last;i++)
  {
    processAJob(i,&sum);
  }
  pthread_t tid = pthread_self();       
  printf("[%ld] thread (sum of inJobs[%04d]-inJobs[%04d]): \t %ld\n"
    , pthread_self()
    , first
    , last-1
    , sum);
  para->result=sum;
}

int main(int argc, char *argv[])
{
  int numOfWorkerThread=1;
  if(argc>=2)
    numOfWorkerThread=atoi(argv[1]);
  if(numOfWorkerThread>INPUT_JOB_NUM)
    numOfWorkerThread=INPUT_JOB_NUM;
  if(argc>=3)
    THE_HEAVY_WEIGHT=atoi(argv[2]);

  struct timeval tvGenStart,tvEnd;
  struct timeval tvMainStartCacl,tvMainEndCacl;
  struct timeval tvWorkerStartCacl,tvWorkerEndCacl;

  printf("Generating input jobs ...\n");
  gettimeofday(&tvGenStart,NULL);
  long int totalBytes=generateJobs();
  gettimeofday(&tvEnd,NULL);
  printf("Generating input jobs done. Spend %.5lf s to finish. Total test input data size is %lf MBs\n",time_diff(tvGenStart,tvEnd)/1E6,(double)totalBytes/1E6);

  printf("Main thread start doing jobs ...\n");
  gettimeofday(&tvMainStartCacl,NULL);
  ThreadParas thParaMain;
  thParaMain.first=0;
  thParaMain.last=INPUT_JOB_NUM;
  calcSum(&thParaMain);
  gettimeofday(&tvMainEndCacl,NULL);
  printf("Main thread finish jobs. Spend %.5lf s to finish.\n",time_diff(tvMainStartCacl,tvMainEndCacl)/1E6);

  printf("Worker threads start doing jobs ...\n");
  gettimeofday(&tvWorkerStartCacl,NULL);
  pthread_t th[numOfWorkerThread];
  ThreadParas thPara[numOfWorkerThread];
  for(int i=0;i<numOfWorkerThread;i++)
  {
    int first=(int)(INPUT_JOB_NUM/numOfWorkerThread)*i;
    int last;
    if(i!=numOfWorkerThread-1)
      last=(int)(INPUT_JOB_NUM/numOfWorkerThread)*(i+1);
    else
      last=INPUT_JOB_NUM;
    thPara[i].first=first;
    thPara[i].last=last;

    if(pthread_create(&th[i], NULL, calcSum, &thPara[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  for(int i=0;i<numOfWorkerThread;i++)
    pthread_join(th[i], NULL);
  gettimeofday(&tvWorkerEndCacl,NULL);
  printf("Worker threads finish jobs. Spend %.5lf s to finish.\n",time_diff(tvWorkerStartCacl,tvWorkerEndCacl)/1E6);

  long int workerSum=0;
  for(int i=0;i<numOfWorkerThread;i++)
    workerSum=workerSum+thPara[i].result;
  printf("Sum of all %d threads: \t\t %ld\n", numOfWorkerThread, workerSum);

  //In real project, do free the memory and destroy mutexes and semaphores
  exit(0);
}