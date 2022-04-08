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

#define MAXIN 256
#define MAXOUT 256
#define MAX_THREAD_NUM 8092

char *getreq(char *inbuf, int len) {
  /* Get request char stream */
  // printf("REQ: ");              /* prompt */
  memset(inbuf,0,len);          /* clear for good measure */
  return fgets(inbuf,len,stdin); /* read up to a EOL */
}


void* client(void* args) {
  int* sockfdAddr=(int *) args;
  int sockfd=*sockfdAddr;
  int n;
  char sndbuf[MAXIN]; char rcvbuf[MAXOUT];
  getreq(sndbuf, MAXIN);        /* prompt */
  while (strlen(sndbuf) > 0) {
    n=write(sockfd, sndbuf, strlen(sndbuf)); /* send */
    if (n <= 0) {
      perror("Error: write to socket");
      close(sockfd);
      free(sockfdAddr);
      return NULL;
    }
    memset(rcvbuf,0,MAXOUT);               /* clear */
    n=read(sockfd, rcvbuf, MAXOUT-1);      /* receive */
    if (n <= 0) {
      perror("Error: read from socket");
      close(sockfd);
      free(sockfdAddr);
      return NULL;
    }
    n=write(STDOUT_FILENO, rcvbuf, n);        /* echo */
    getreq(sndbuf, MAXIN);                 /* prompt */
  }
  close(sockfd);
  free(sockfdAddr);
  return NULL;
}

int main(int argc, char *argv[])
{
  if(argc!=3)
  {
    printf("usage: %s destIP port\n",argv[0]);
    exit(1);
  }
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


  // for(int i=0;i<MAX_THREAD_NUM;i++)
  // {
    int *client_sockfd=malloc(sizeof(int));
    if((*client_sockfd=socket(AF_INET,SOCK_STREAM,0))<0)
    {
      perror("socket");
      return 1;
    }

    if(connect(*client_sockfd,(const struct sockaddr *)&remote_addr,sizeof(remote_addr))<0)
    {
      perror("connect");
      return 1;
    }
    struct sockaddr_in localAddress;
    socklen_t addressLength = sizeof(localAddress);
    getsockname(*client_sockfd, (struct sockaddr*)&localAddress, &addressLength);

    printf("I'm %s:%d \t connected to server %s:%d\n"
      ,inet_ntoa( localAddress.sin_addr),ntohs(localAddress.sin_port)
      ,inet_ntoa(remote_addr.sin_addr),ntohs(remote_addr.sin_port));

    client(client_sockfd);

    // pthread_t th;
    // if(pthread_create(&th, NULL, client, client_sockfd)!=0)
    // {
    //   perror("pthread_create failed");
    //   exit(1);
    // }
  // }
  
  return 0;
}