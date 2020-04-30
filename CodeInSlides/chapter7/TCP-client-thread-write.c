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

void receiveData(int sock, int bytesToReceive)
{
  char *buf;
  buf=malloc(bytesToReceive);
  int totalReceivedTimes=0;
  int len=0;
  int totalReceivedBytes=0;
  while(1)
  {
    if(bytesToReceive-totalReceivedBytes<=0)//All received
      break;

    memset(buf,0,(bytesToReceive-totalReceivedBytes)*sizeof(buf[0]));
    len = read(sock,buf,bytesToReceive-totalReceivedBytes);
    if(len<=0)
      break;

    // printf("[%7d, %9d] Received: ",totalReceivedTimes,totalReceivedBytes);
    // for(int i=0;i<len;i++)
    //   printf("%c",buf[i]);
    // printf("\n");

    totalReceivedTimes++;
    totalReceivedBytes=totalReceivedBytes+len;
  }

  printf("\n\nReceived %d B in total!\n",totalReceivedBytes);
  free(buf);
}

int main(int argc, char *argv[])
{
  if(argc!=4)
  {
    printf("usage: %s destIP port bytesToReceive\n",argv[0]);
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
  int bytesToReceive=atoi(argv[3]);

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

  receiveData(client_sockfd,bytesToReceive);

  close(client_sockfd);
  return 0;
}