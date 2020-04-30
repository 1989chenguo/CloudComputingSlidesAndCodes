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
    len = recv(sock,buf,bytesToReceive-totalReceivedBytes,0);
    if(len<=0)
      break;

    printf("[%7d, %9d] Received: ",totalReceivedTimes,totalReceivedBytes);
    for(int i=0;i<len;i++)
      printf("%c",buf[i]);
    printf("\n");

    totalReceivedTimes++;
    totalReceivedBytes=totalReceivedBytes+len;
  }

  printf("Received %d B in total!\n",totalReceivedBytes);
  free(buf);
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
  if(recv(client_sockfd,&dInfo,sizeof(dInfo),0)<=0)
    return 1;

  printf("Going to receive data(ID:%d, len:%d B)!\n",dInfo.ID,dInfo.len);

  receiveData(client_sockfd,dInfo.len);

  char *doneMsg="Receiver done!";
  if(send(client_sockfd,doneMsg,strlen(doneMsg),0)<0)
  {
    perror("TCP send");
    exit(1);
  }
  
  close(client_sockfd);
  close(server_sockfd);

  return 0;
}