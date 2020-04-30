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
} RequestInfo;

int main(int argc, char *argv[])
{
  if(argc!=4)
  {
    printf("usage: %s destIP port requestNum\n",argv[0]);
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
  int requestNum=atoi(argv[3]);

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

  
  for(int i=0;i<requestNum;i++) 
  {
    RequestInfo dInfo;
    dInfo.ID=i;
    dInfo.len=9; //Each time sent 9 bytes

    char buf[MAX_DATAGRAM_SIZE];
    memset(buf,0,MAX_DATAGRAM_SIZE*sizeof(buf[0]));
    memcpy(buf,&dInfo,sizeof(dInfo));
    if(send(client_sockfd,buf,sizeof(dInfo),0)<0)
    {
      perror("TCP send");
      exit(1);
    }
  }

  printf("Sent %d requests in total!\n",requestNum);
  
  close(client_sockfd);
  return 0;
}