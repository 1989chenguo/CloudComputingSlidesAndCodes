#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

long TEST_TIMES=1000000;
#define PRINT_STEP 10000

int x=0,y=0;
void* thread_1(void* args) {
  x = 1; printf("y=%d\n", y);
}

void* thread_2(void* args) {
  y = 1; printf("x=%d\n", x);
}

int main(int argc, char *argv[])
{
  if(argc>=2)
    TEST_TIMES=atoi(argv[1]);

  pthread_t th1;
  pthread_t th2;
  for(int i=0;i<TEST_TIMES;i++)
  {
    if(i%PRINT_STEP==0)
      fprintf(stderr,"%ld times to run....\n",TEST_TIMES-i);
    x=0;y=0;
    if(pthread_create(&th1, NULL, thread_1, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    if(pthread_create(&th2, NULL, thread_2, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
    pthread_join(th1, NULL);
    pthread_join(th2, NULL);

    printf("\n");
  }
 
  exit(0);
}