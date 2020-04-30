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

typedef struct {
  int ID;
  int len;
} DataInfo;

int sendAllChunk(int sock, char* buf, int chunkSize)
{
  int sentBytes=0;
  int len;
  while(1) {
    if(chunkSize-sentBytes==0)//This data chunk has all been sent
      break;
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
    len=recv(sock,buf+receivedBytes,chunkSize-receivedBytes,0);
    if(len<=0) {
      perror("TCP recv");
      return -1;//Error
    } 
    receivedBytes=receivedBytes+len;
  }
  return 0;//Success
}

void receiveData(int sock, int bytesToReceive)
{
  int totalReceivedBytes=0;
  int totalReceivedTimes=0;
  char buf[BUFSIZ];
  int chunkSize;
  while(1)
  {
    if(totalReceivedBytes>=bytesToReceive)
      break;
    if(bytesToReceive-totalReceivedBytes>=BUFSIZ)
      chunkSize=BUFSIZ;
    else
      chunkSize=bytesToReceive-totalReceivedBytes;
    if(recvAllChunk(sock,buf,chunkSize)==-1)
      exit(1);

    printf("[%7d, %9d] Received: ",totalReceivedTimes,totalReceivedBytes);
    for(int i=0;i<chunkSize;i++)
      printf("%c",buf[i]);
    printf("\n");

    totalReceivedTimes++;
    totalReceivedBytes=totalReceivedBytes+chunkSize;
  }

  printf("Received %d B in total!\n",totalReceivedBytes);
}

int main(int argc, char *argv[])
{
  if(argc!=2)
  {
    printf("usage: %s port\n",argv[0]);
    return 1;
  }
  int port=atoi(argv[1]);

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


  DataInfo dInfo;
  if(recvAllChunk(client_sockfd,(char*)&dInfo,sizeof(dInfo))==-1)//Receive data header
    exit(1);

  printf("Going to receive data(ID:%d, len:%d B)!\n",dInfo.ID,dInfo.len);

  receiveData(client_sockfd,dInfo.len);

  if(sendAllChunk(client_sockfd,(char*)&dInfo,sizeof(dInfo))==-1)//Send data acknowledgment
    exit(1);
  
  close(client_sockfd);
  close(server_sockfd);

  return 0;
}