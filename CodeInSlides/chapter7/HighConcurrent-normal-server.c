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

#define MAXREQ 256

void* server(void* args) {
  int* consockfdAddr=(int *) args; 
  int consockfd=*consockfdAddr;
  char reqbuf[MAXREQ];
  int n;
                    
  memset(reqbuf,0, MAXREQ);
  n = read(consockfd,reqbuf,MAXREQ-1); /* Recv request*/
  if (n <= 0) {
    perror("Error: read from socket");
    close(consockfd);
    free(consockfdAddr);
    return NULL;
  }
  // n=write(STDOUT_FILENO, reqbuf, strlen(reqbuf));
  // fflush(stdout);
  n = write(consockfd, reqbuf, strlen(reqbuf)); /* echo as response*/
  if (n <= 0) {
    perror("Error: write to socket");
    close(consockfd);
    free(consockfdAddr);
    return NULL;
  }

  close(consockfd);
  free(consockfdAddr);
  return NULL;
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
  if(listen(server_sockfd,5)<0)
  {
    perror("listen");
    return 1;
  }

  int inComeConnNum=0;
  while (1) {
    int *client_sockfd=malloc(sizeof(int));
    if((*client_sockfd=accept(server_sockfd,(struct sockaddr *)&remote_addr,&sin_size))<0)
    {
      perror("Error: accept");
      return 1;
    }
    inComeConnNum++;
    printf("[%d connections accepted] from client %s:%d\n",inComeConnNum,inet_ntoa(remote_addr.sin_addr),ntohs(remote_addr.sin_port));

    pthread_t th;
    if(pthread_create(&th, NULL, server, client_sockfd)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }

  }
  close(server_sockfd);

  return 0;
}