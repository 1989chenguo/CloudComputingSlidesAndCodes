#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pthread.h>

#define TEST_COKE_NUM 100000
#define BUF_CAPACITY 10

int producerNum=1;
int consumerNum=1;

int bufSize=0;

pthread_mutex_t mutex;
pthread_cond_t cndFull;
pthread_cond_t cndEmpty;

void* Producer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/producerNum;i++)
  {
    pthread_mutex_lock(&mutex);
    if(bufSize==BUF_CAPACITY) {
      // printf("[%ld] producer: wait ...\n",pthread_self());
      pthread_cond_wait(&cndFull,&mutex);
    }
    bufSize++;
    if(bufSize>BUF_CAPACITY)
      printf("[%ld] producer: OVERFLOW! enqueue a coke, bufSize %d\n",pthread_self(),bufSize);
    // printf("[%ld] producer: enqueue a coke, bufSize %d\n",pthread_self(),bufSize);

    // printf("[%ld] producer: wakeup waiting consumers\n",pthread_self());
    pthread_cond_broadcast(&cndEmpty);
    pthread_mutex_unlock(&mutex);
  }
}

void* Consumer(void* args) {
  for(int i=0;i<TEST_COKE_NUM/consumerNum;i++)
  {
    pthread_mutex_lock(&mutex);
    if(bufSize==0) {
      // printf("[%ld] consumer: wait ...\n",pthread_self());
      pthread_cond_wait(&cndEmpty,&mutex);
    }
    bufSize--;
    if(bufSize<0)
      printf("[%ld] consumer: UNDERFLOW! dequeue a coke, bufSize %d\n",pthread_self(),bufSize);
    // printf("[%ld] consumer: dequeue a coke, bufSize %d\n",pthread_self(),bufSize);

    // printf("[%ld] consumer: wakeup waiting producers\n",pthread_self());
    pthread_cond_broadcast(&cndFull);
    pthread_mutex_unlock(&mutex);
  }
}

int main(int argc, char *argv[])
{
  if(argc>=2)
  {
    producerNum=atoi(argv[1]);
    consumerNum=atoi(argv[2]);
  }

  pthread_cond_init(&cndFull,NULL);
  pthread_cond_init(&cndEmpty,NULL);
  pthread_mutex_init(&mutex,NULL);

  printf("Before run: \t\t coke_num \t\t %d\n", bufSize);

  pthread_t th1[producerNum];
  for(int i=0;i<producerNum;i++)
  {
    if(pthread_create(&th1[i], NULL, Producer, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  pthread_t th2[consumerNum];
  for(int i=0;i<consumerNum;i++)
  {
    if(pthread_create(&th2[i], NULL, Consumer, NULL)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }

  for(int i=0;i<producerNum;i++)
    pthread_join(th1[i], NULL);
  for(int i=0;i<consumerNum;i++)
    pthread_join(th2[i], NULL);

  printf("After run: \t\t coke_num \t\t %d\n", bufSize);

  pthread_cond_destroy(&cndFull);
  pthread_cond_destroy(&cndEmpty);
  pthread_mutex_destroy(&mutex);

  exit(0);
}