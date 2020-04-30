#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <pthread.h>
#include <string.h>
#include <unistd.h>

#define MAX_DATAGRAM_SIZE 1400

typedef struct {
  int threadID;
  int sentTimes;
  int sock;
} ThreadParas;

void* sendData(void* args)
{
  ThreadParas* para = (ThreadParas*) args;
  int sentTimes=para->sentTimes;
  int threadID=para->threadID;
  int sock=para->sock;
  char bufSent[MAX_DATAGRAM_SIZE];
  int totalSentTimes=0;
  int bytesToSend=0;
  int totalSentBytes=0;
  while(1)
  {
    // usleep(1000);
    if(totalSentTimes>=sentTimes)
      break;
    memset(bufSent,0,MAX_DATAGRAM_SIZE*sizeof(bufSent[0]));
    sprintf(bufSent,"(thread %3d) *%07d%s*\n",threadID,totalSentTimes,"abcdefghijklmn");
    bytesToSend=strlen(bufSent);
    if(write(sock,bufSent,bytesToSend)<0)
    {
      perror("TCP send");
      exit(1);
    }

    // printf("(thread %3d) [%7d, %9d] Sent: ",threadID,totalSentTimes,totalSentBytes);
    // for(int i=0;i<bytesToSend;i++)
    //   printf("%c",bufSent[i]);
    // printf("\n");

    totalSentTimes++;
    totalSentBytes=totalSentBytes+bytesToSend;
  }
  printf("(thread %3d) Sent %d B in total!\n",threadID,totalSentBytes);
}

int main(int argc, char *argv[])
{
  if(argc!=4)
  {
    printf("usage: %s port threadNum sentTimes\n",argv[0]);
    return 1;
  }
  int port=atoi(argv[1]);
  int threadNum=atoi(argv[2]);
  int sentTimes=atoi(argv[3]);

  struct sockaddr_in my_addr; 
  my_addr.sin_family=AF_INET;
  my_addr.sin_addr.s_addr=INADDR_ANY;
  my_addr.sin_port=htons(port);

  int server_sockfd;
  int client_sockfd;
  if((server_sockfd=socket(AF_INET,SOCK_STREAM,0))<0)
  {  
    perror("socket");
    return 1;
  }

  int on=1;  
  if((setsockopt(server_sockfd,SOL_SOCKET,SO_REUSEADDR,&on,sizeof(on)))<0)  
  {  
      perror("setsockopt failed");  
      return 1;  
  }  
  
  if (bind(server_sockfd,(struct sockaddr *)&my_addr,sizeof(my_addr))<0)
  {
    perror("bind");
    return 1;
  }

  int sin_size=sizeof(struct sockaddr_in);
  struct sockaddr_in remote_addr;
  listen(server_sockfd,5);
  if((client_sockfd=accept(server_sockfd,(struct sockaddr *)&remote_addr,&sin_size))<0)
  {
    perror("Error: accept");
    return 1;
  }
  printf("accept client %s\n",inet_ntoa(remote_addr.sin_addr));

  pthread_t th[threadNum];
  ThreadParas para[threadNum];
  for(int i=0;i<threadNum;i++)
  {
    para[i].threadID=i;
    para[i].sentTimes=sentTimes;
    para[i].sock=client_sockfd;
    if(pthread_create(&th[i], NULL, sendData, &para[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  for(int i=0;i<threadNum;i++)
    pthread_join(th[i], NULL);
  
  close(client_sockfd);
  close(server_sockfd);

  return 0;
}