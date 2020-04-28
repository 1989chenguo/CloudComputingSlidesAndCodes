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

  int server_sockfd;//UDP server socket
  if((server_sockfd=socket(AF_INET,SOCK_DGRAM,0))<0)
  {  
    perror("socket");
    return 1;
  }
  
  if (bind(server_sockfd,(struct sockaddr *)&my_addr,sizeof(my_addr))<0)
  {
    perror("bind");
    return 1;
  }

  char buf[BUFSIZ];
  int totalReceivedTimes=0;
  int len=0;
  int totalReceivedBytes=0;
  while(1)
  {
    // usleep(1000);
    memset(buf,0,BUFSIZ*sizeof(buf[0]));
    len = recvfrom(server_sockfd,buf,BUFSIZ,0,NULL,NULL);
    if(len<0)
    {
      printf("recvfrom failed!\n");
      break;
    }

    printf("[%4d, %8d] Received: ",totalReceivedTimes,totalReceivedBytes);
    for(int i=0;i<len;i++)
      printf("%c",buf[i]);
    printf("\n");

    totalReceivedTimes++;
    totalReceivedBytes=totalReceivedBytes+len;
  }

  close(server_sockfd);

  return 0;
}