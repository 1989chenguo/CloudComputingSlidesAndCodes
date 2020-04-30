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

void sendData(int sock, int sentTimes)
{
  char bufSent[BUFSIZ];
  int totalSentTimes=0;
  int bytesToSend=0;
  int totalSentBytes=0;
  while(1)
  {
    usleep(1000);
    if(totalSentTimes>=sentTimes)
      break;
    memset(bufSent,0,BUFSIZ*sizeof(bufSent[0]));
    sprintf(bufSent,"*%07d*",totalSentTimes);
    bytesToSend=strlen(bufSent);

    if(sendAllChunk(sock,bufSent,bytesToSend)==-1)
      exit(1);

    printf("[%7d, %9d] Sent: ",totalSentTimes,totalSentBytes);
    for(int i=0;i<bytesToSend;i++)
      printf("%c",bufSent[i]);
    printf("\n");

    totalSentTimes++;
    totalSentBytes=totalSentBytes+bytesToSend;
  }
  printf("Sent %d B in total!\n",totalSentBytes);
}

int main(int argc, char *argv[])
{
  if(argc!=4)
  {
    printf("usage: %s destIP port sentTimes\n",argv[0]);
    exit(1);
  }
  int client_sockfd;
  int len;
  struct in_addr server_addr;
  if(!inet_aton(argv[1], &server_addr)) 
    perror("inet_aton");
  struct sockaddr_in remote_addr;
  memset(&remote_addr,0,sizeof(remote_addr));
  remote_addr.sin_family=AF_INET;
  remote_addr.sin_addr=server_addr;
  int port=atoi(argv[2]);
  remote_addr.sin_port=htons(port);
  int sentTimes=atoi(argv[3]);

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

  
  DataInfo dInfo;
  dInfo.ID=0;
  dInfo.len=sentTimes*9; //Each time sent 9 bytes
  if(sendAllChunk(client_sockfd,(char*)&dInfo,sizeof(dInfo))==-1)//Send data header
    exit(1);

  sendData(client_sockfd,sentTimes);

  if(recvAllChunk(client_sockfd,(char*)&dInfo,sizeof(dInfo))==-1)//Receive data acknowledgment
    exit(1);

  printf("The receiver has successfully received data(ID:%d, len:%d B)!\n"
    ,dInfo.ID,dInfo.len);
  
  close(client_sockfd);
  return 0;
}