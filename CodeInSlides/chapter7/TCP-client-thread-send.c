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

#define MAX_REQUEST_BUFFER_LEN 100000

typedef struct {
  int threadID;
  int requestID;
  char padding[10240];
} RequestInfo;

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

void recvRequest(int sock)
{
  char fileName[128]={0};
  sprintf(fileName,"thread%03d.log",0);
  FILE *fp;
  if((fp = fopen(fileName,"w"))==NULL)
  {
    perror("fopen ERROR!");
    exit(1);
  }
  int totalRequestNum=0;
  RequestInfo* dInfo=malloc(MAX_REQUEST_BUFFER_LEN*sizeof(RequestInfo));
  while(1) {
    if(recvAllChunk(sock,(char*)&(dInfo[totalRequestNum]),sizeof(RequestInfo))==-1)
      break;
    totalRequestNum++;
  }
  for(int i=0;i<totalRequestNum;i++)
  {
    fprintf(fp,"request \t %09d \t %09d \t ",dInfo[i].threadID, dInfo[i].requestID);
    for(int j=0;j<10240;j++)
      fprintf(fp,"%c",dInfo[i].padding[j]);
    fprintf(fp,"\n");
  }
  fflush(fp);
  printf("Received %d requests in total!\n",totalRequestNum);
}

int main(int argc, char *argv[])
{
  if(argc!=3)
  {
    printf("usage: %s destIP port\n",argv[0]);
    exit(1);
  }
  int client_sockfd;
  int len;
  struct in_addr server_addr;
  if(!inet_aton(argv[1], &server_addr)) 
    perror("inet_aton");
  struct sockaddr_in remote_addr;
  char buf[BUFSIZ];
  memset(&remote_addr,0,sizeof(remote_addr));
  remote_addr.sin_family=AF_INET;
  remote_addr.sin_addr=server_addr;
  int port=atoi(argv[2]);
  remote_addr.sin_port=htons(port);

  if((client_sockfd=socket(AF_INET,SOCK_STREAM,0))<0)
  {
    perror("socket");
    return 1;
  }

  if(connect(client_sockfd,(const struct sockaddr *)&remote_addr,sizeof(remote_addr))<0)
  {
    perror("connect");
    return 1;
  }
  printf("connected to server %s\n",inet_ntoa(remote_addr.sin_addr));

  recvRequest(client_sockfd);

  close(client_sockfd);
  return 0;
}