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
  int sock;
  int receivedNum;
} ThreadParas;

typedef struct {
  int threadID;
  int requestID;
  char padding[10240];
} RequestInfo;

void* recvRequest(void* args)
{
  ThreadParas* para = (ThreadParas*) args;
  int threadID=para->threadID;
  int sock=para->sock;

  char fileName[128]={0};
  sprintf(fileName,"thread%03d.log",threadID);
  FILE *fp;
  if((fp = fopen(fileName,"w"))==NULL)
  {
    perror("fopen ERROR!");
    exit(1);
  }
  int totalRequestNum=0;
  RequestInfo* dInfo=malloc(MAX_REQUEST_BUFFER_LEN*sizeof(RequestInfo));
  int requestBytes=sizeof(RequestInfo);
  int receivedBytesForThisRequest;
  int len;
  while(1) {
    receivedBytesForThisRequest=0;
    while(1) {
      if(requestBytes-receivedBytesForThisRequest==0)//This request has been received
        break;
      if(requestBytes-receivedBytesForThisRequest<0)//This request has been over received
      {
        fprintf(stderr, "%s\n", "ERROR: This request has been over received!");
        exit(1);
      }
      // len=read(sock,(char *)&(dInfo[totalRequestNum])+receivedBytesForThisRequest,requestBytes-receivedBytesForThisRequest);
      len=recv(sock,(char *)&(dInfo[totalRequestNum])+receivedBytesForThisRequest,requestBytes-receivedBytesForThisRequest,0);
      if(len<=0) {
        for(int i=0;i<totalRequestNum;i++)
        {
          fprintf(fp,"request \t %09d \t %09d \t ",dInfo[i].threadID, dInfo[i].requestID);
          for(int j=0;j<10240;j++)
            fprintf(fp,"%c",dInfo[i].padding[j]);
          fprintf(fp,"\n");
        }
        fflush(fp);
        para->receivedNum=totalRequestNum;
        printf("(thread %3d) Received %d requests!\n",threadID,totalRequestNum);
        return NULL;
      }
      receivedBytesForThisRequest=receivedBytesForThisRequest+len;
    }
    totalRequestNum++;
  }
}


int main(int argc, char *argv[])
{
  if(argc!=3)
  {
    printf("usage: %s port threadNum\n",argv[0]);
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


  pthread_t th[threadNum];
  ThreadParas para[threadNum];
  for(int i=0;i<threadNum;i++)
  {
    para[i].threadID=i;
    para[i].sock=client_sockfd;
    if(pthread_create(&th[i], NULL, recvRequest, &para[i])!=0)
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
    totalRequestNum=totalRequestNum+para[i].receivedNum;
  }
  printf("Received %d requests in total!\n",totalRequestNum);

  close(client_sockfd);
  close(server_sockfd);

  return 0;
}