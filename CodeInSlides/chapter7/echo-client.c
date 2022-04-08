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

char *getreq(char *inbuf, int len) {
  /* Get request char stream */
  printf("REQ: ");              /* prompt */
  memset(inbuf,0,len);          /* clear for good measure */
  return fgets(inbuf,len,stdin); /* read up to a EOL */
}


void client(int sockfd) {
  int n;
  char sndbuf[MAXIN]; char rcvbuf[MAXOUT];
  getreq(sndbuf, MAXIN);        /* prompt */
  while (strlen(sndbuf) > 0) {
    n=write(sockfd, sndbuf, strlen(sndbuf)); /* send */
    if (n <= 0) {
      perror("Error: write to socket");
      return;
    }
    memset(rcvbuf,0,MAXOUT);               /* clear */
    n=read(sockfd, rcvbuf, MAXOUT-1);      /* receive */
    if (n <= 0) {
      perror("Error: read from socket");
      return;
    }
    n=write(STDOUT_FILENO, rcvbuf, n);        /* echo */
    getreq(sndbuf, MAXIN);                 /* prompt */
  }
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
  struct sockaddr_in localAddress;
  socklen_t addressLength = sizeof(localAddress);
  getsockname(client_sockfd, (struct sockaddr*)&localAddress, &addressLength);

  printf("I'm %s:%d \t connected to server %s:%d\n"
    ,inet_ntoa( localAddress.sin_addr),ntohs(localAddress.sin_port)
    ,inet_ntoa(remote_addr.sin_addr),ntohs(remote_addr.sin_port));

  client(client_sockfd);

  close(client_sockfd);
  return 0;
}