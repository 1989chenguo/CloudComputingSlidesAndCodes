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

#define REQUEST_PADDING_SIZE 10240

typedef struct {
  int threadID;
  int requestID;
  char padding[REQUEST_PADDING_SIZE];
} RequestInfo;

typedef struct {
  int threadID;
  int sentRequestNum;
  int sock;
} ThreadParas;

int sendAllChunk(int sock, char* buf, int chunkSize)
{
  int sentBytes=0;
  int len;
  while(1) {
    if(chunkSize-sentBytes==0)//This data chunk has all been sent
      break;
    // len=write(sock,buf+sentBytes,chunkSize-sentBytes);
    len=send(sock,buf+sentBytes,chunkSize-sentBytes,0);
    if(len<0)
    {
      perror("TCP send");
      return -1;//Error
    }
    sentBytes=sentBytes+len;
  }
  return 0;//Success
}

int recvAllChunk(int sock, char* buf, int chunkSize)
{
  int receivedBytes=0;
  int len;
  while(1) {
    if(chunkSize-receivedBytes==0)//This data chunk has all been received
      break;
    // len=read(sock,buf+receivedBytes,chunkSize-receivedBytes);
    len=recv(sock,buf+receivedBytes,chunkSize-receivedBytes,0);
    if(len<=0) {
      perror("TCP recv");
      return -1;//Error
    } 
    receivedBytes=receivedBytes+len;
  }
  return 0;//Success
}

void* sendRequest(void* args)
{
  ThreadParas* para = (ThreadParas*) args;
  int sentRequestNum=para->sentRequestNum;
  int threadID=para->threadID;
  int sock=para->sock;
  
  RequestInfo dInfo;
  memset(dInfo.padding,'A',REQUEST_PADDING_SIZE);
  for(int i=0;i<sentRequestNum;i++) 
  {
    dInfo.threadID=threadID;
    dInfo.requestID=i; //Each time sent 9 bytes
    if(sendAllChunk(sock,(char*)&dInfo,sizeof(dInfo))==-1)
      exit(1);
  }
  printf("(thread %3d) Sent %d requests!\n",threadID,sentRequestNum);
}

int main(int argc, char *argv[])
{
  if(argc!=3)
  {
    printf("usage: %s port threadNum sentRequestNum\n",argv[0]);
    return 1;
  }
  int port=atoi(argv[1]);
  int threadNum=atoi(argv[2]);

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

  int sentRequestNum;
  if(recvAllChunk(client_sockfd,(char*)&sentRequestNum,sizeof(sentRequestNum))==-1)//Receive from client that how many requests in total I'm gonna send
    exit(1);
  printf("Going to send %d requests in total...\n",sentRequestNum);

  pthread_t th[threadNum];
  ThreadParas para[threadNum];
  for(int i=0;i<threadNum;i++)
  {
    para[i].threadID=i;
    para[i].sentRequestNum=sentRequestNum/threadNum;
    para[i].sock=client_sockfd;
    if(pthread_create(&th[i], NULL, sendRequest, &para[i])!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }
  for(int i=0;i<threadNum;i++)
    pthread_join(th[i], NULL);

  int totalRequestNum=0;
  for(int i=0;i<threadNum;i++)
  {
    totalRequestNum=totalRequestNum+para[i].sentRequestNum;
  }
  printf("Sent %d requests in total!\n",totalRequestNum);
  
  close(client_sockfd);
  close(server_sockfd);

  return 0;
}