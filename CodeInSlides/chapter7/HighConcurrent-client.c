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

void* client(void* args) {
  int* sockfdAddr=(int *) args;
  int sockfd=*sockfdAddr;
  int n;
  char sndbuf[MAXIN]; char rcvbuf[MAXOUT];
  memset(sndbuf,0,MAXIN); 
  memcpy(sndbuf,"Hello\n",sizeof("Hello\n"));
  int sleepseconds=rand()%100+100; //Sleep 10s~20s to emulate user input 
  sleep(sleepseconds);
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
   
  close(sockfd);
  free(sockfdAddr);
  return NULL;
}

int main(int argc, char *argv[])
{
  if(argc!=4)
  {
    printf("usage: %s destIP port MAX_CONN_NUM\n",argv[0]);
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
  int MAX_CONN_NUM=atoi(argv[3]);


  srand(time(NULL));
  pthread_t *th=malloc(MAX_CONN_NUM*sizeof(pthread_t));
  for(int i=0;i<MAX_CONN_NUM;i++)
  {
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

    printf("[%d connection] I'm %s:%d \t connected to server %s:%d\n"
      ,i+1
      ,inet_ntoa( localAddress.sin_addr),ntohs(localAddress.sin_port)
      ,inet_ntoa(remote_addr.sin_addr),ntohs(remote_addr.sin_port));

    
    if(pthread_create(&th[i], NULL, client, client_sockfd)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }
  }

  for(int i=0;i<MAX_CONN_NUM;i++) {
    pthread_join(th[i], NULL);
    printf("[%d connection] Finished\n", i+1);
  }
  
  return 0;
}