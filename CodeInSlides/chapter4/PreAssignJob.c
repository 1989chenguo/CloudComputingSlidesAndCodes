#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>

#define INPUT_JOB_NUM 50
#define INPUT_FOLDER_NAME "testInput"

char *inJob[INPUT_JOB_NUM];

double time_diff(struct timeval x , struct timeval y)
{
  double x_ms , y_ms , diff;
  
  x_ms = (double)x.tv_sec*1000000 + (double)x.tv_usec;
  y_ms = (double)y.tv_sec*1000000 + (double)y.tv_usec;
  
  diff = (double)y_ms - (double)x_ms;

  if(diff<0)
  {
    fprintf(stderr, "ERROR! time_diff<0\n");
    printf("ERROR! time_diff<0\n");
    fflush(stdout);
    exit(1);
  }
  return diff;
}

void generateJob()
{
  mkdir(INPUT_FOLDER_NAME, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
  for(int i=0;i<INPUT_JOB_NUM;i++)
  {
    inJob[i]=malloc(sizeof(char)*256);
    sprintf(inJob[i], "%s/testInput%04d.txt",INPUT_FOLDER_NAME,i);
    // printf("%s\n",inJob[i]);
    FILE *fp;
    if((fp = fopen(inJob[i],"w"))==NULL)
    {
      perror("fopen ERROR!");
      exit(1);
    }
    for(int j=0;j<1000000;j++)
      fprintf(fp, "%d\n", 1);
    fclose(fp);   
  }
}

typedef struct {
  int first;
  int last;
  long int result;
} ThreadParas;

void* calcSum(void* args) {
  ThreadParas* para = (ThreadParas*) args;
  int first=para->first;
  int last=para->last;
  long int sum=0;
  FILE *fp;
  int value=0;
  for(int i=first;i<last;i++)
  {
    if((fp = fopen(inJob[i],"r"))==NULL)
    {
      perror("fopen ERROR!");
      exit(1);
    }
    while(fscanf(fp,"%d",&value)!=EOF)
      sum=sum+value;
  }
  fclose(fp);
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

  struct timeval tvGenStart,tvEnd;
  struct timeval tvMainStartCacl,tvMainEndCacl;
  struct timeval tvWorkerStartCacl,tvWorkerEndCacl;

  printf("Generating input jobs ...\n");
  gettimeofday(&tvGenStart,NULL);
  generateJob();
  gettimeofday(&tvEnd,NULL);
  printf("Generating input jobs done. Spend %.3lf s to finish.\n",time_diff(tvGenStart,tvEnd)/1E6);

  printf("Main thread doing jobs ...\n");
  gettimeofday(&tvMainStartCacl,NULL);
  ThreadParas thParaMain;
  thParaMain.first=0;
  thParaMain.last=INPUT_JOB_NUM;
  calcSum(&thParaMain);
  gettimeofday(&tvMainEndCacl,NULL);
  printf("Main thread finish jobs. Spend %.3lf s to finish.\n",time_diff(tvMainStartCacl,tvMainEndCacl)/1E6);

  printf("Worker threads doing jobs ...\n");
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
  printf("Worker threads finish jobs. Spend %.3lf s to finish.\n",time_diff(tvWorkerStartCacl,tvWorkerEndCacl)/1E6);

  long int workerSum=0;
  for(int i=0;i<numOfWorkerThread;i++)
    workerSum=workerSum+thPara[i].result;
  printf("Sum of all %d threads: \t\t %ld\n", numOfWorkerThread, workerSum);

  exit(0);
}