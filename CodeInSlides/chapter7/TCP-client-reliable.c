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
  int ID;
  int len;
} DataInfo;

void sendData(int sock, int sentTimes)
{
  char bufSent[MAX_DATAGRAM_SIZE];
  int totalSentTimes=0;
  int bytesToSend=0;
  int totalSentBytes=0;
  while(1)
  {
    usleep(1000);
    if(totalSentTimes>=sentTimes)
      break;
    memset(bufSent,0,MAX_DATAGRAM_SIZE*sizeof(bufSent[0]));
    sprintf(bufSent,"*%07d*",totalSentTimes);
    bytesToSend=strlen(bufSent);
    if(send(sock,bufSent,bytesToSend,0)<0)
    {
      perror("TCP send");
      exit(1);
    }

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

  char buf[MAX_DATAGRAM_SIZE];
  memset(buf,0,MAX_DATAGRAM_SIZE*sizeof(buf[0]));
  memcpy(buf,&dInfo,sizeof(dInfo));
  if(send(client_sockfd,buf,sizeof(dInfo),0)<0)
  {
    perror("TCP send");
    exit(1);
  }

  sendData(client_sockfd,sentTimes);

  memset(buf,0,MAX_DATAGRAM_SIZE*sizeof(buf[0]));
  if(recv(client_sockfd,buf,MAX_DATAGRAM_SIZE,0)>0)
  {
    printf("%s\n",buf);
    printf("The receiver has successfully received data(ID:%d, len:%d B)!\n"
      ,dInfo.ID,dInfo.len);
  }
  
  close(client_sockfd);
  return 0;
}