#include <stdio.h>
#include <stdlib.h>
#include <sys/epoll.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <unistd.h>
#include <netdb.h>
#include <errno.h>
#include <string.h>
#include <time.h>

#define MAXREQ 256
#define MAX_EVENT 20
#define READ_BUF_LEN 256

int main(int argc, char *argv[])
{
    if(argc!=2)
    {
      printf("usage: %s port\n",argv[0]);
      return 1;
    }
    int port=atoi(argv[1]);

    // epoll 实例 file describe
    int epfd = 0;
    int listenfd = 0;
    int result = 0;
    struct epoll_event ev, event[MAX_EVENT];
    // 绑定的地址

    struct sockaddr_in my_addr; 
    my_addr.sin_family=AF_INET;
    my_addr.sin_addr.s_addr=INADDR_ANY;
    my_addr.sin_port=htons(port);

    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    if (-1 == listenfd) {
        perror("Open listen socket");
        return -1;
    }
    /* Enable address reuse */
    int on = 1;
    // 打开 socket 端口复用, 防止测试的时候出现 Address already in use
    result = setsockopt( listenfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on) );
    if (-1 == result) {
        perror ("Set socket");
        return 0;
    }

    result = bind(listenfd, (const struct sockaddr *)&my_addr, sizeof (my_addr));
    if (-1 == result) {
        perror("Bind port");
        return 0;
    }

    result = listen(listenfd, 5);
    if (-1 == result) {
        perror("Start listen");
        return 0;
    }

    // 创建epoll实例
    epfd = epoll_create1(0);
    if (1 == epfd) {
        perror("Create epoll instance");
        return 0;
    }

    ev.data.fd = listenfd;
    ev.events = EPOLLIN;
    // 设置epoll的事件
    result = epoll_ctl(epfd, EPOLL_CTL_ADD, listenfd, &ev);

    if(-1 == result) {
        perror("Set epoll_ctl");
        return 0;
    }

    int inComeConnNum=0;
    while (1) {
        int wait_count;
        // 等待事件
        wait_count = epoll_wait(epfd, event, MAX_EVENT, -1);

        for (int i = 0 ; i < wait_count; i++) {
            uint32_t events = event[i].events;
            // IP地址缓存
            char host_buf[NI_MAXHOST];
            // PORT缓存
            char port_buf[NI_MAXSERV];

            int __result;
            // 判断epoll是否发生错误
            if ( events & EPOLLERR || events & EPOLLHUP || (! events & EPOLLIN)) {
                printf("Epoll has error\n");
                close (event[i].data.fd);
                continue;
            } else if (listenfd == event[i].data.fd) {
                // listen的 file describe 事件触发， accpet事件
                struct sockaddr in_addr = { 0 };
                socklen_t in_addr_len = sizeof (in_addr);
                int accp_fd = accept(listenfd, &in_addr, &in_addr_len);
                if (-1 == accp_fd) {
                    perror("Accept");
                    continue;
                }
                __result = getnameinfo(&in_addr, sizeof (in_addr),
                                       host_buf, sizeof (host_buf) / sizeof (host_buf[0]),
                                       port_buf, sizeof (port_buf) / sizeof (port_buf[0]),
                                       NI_NUMERICHOST | NI_NUMERICSERV);

                if (! __result) {
                    inComeConnNum++;
                    printf("[%d connections accepted] from client %s:%s\n", inComeConnNum, host_buf, port_buf);
                }
                else {
                    perror("Client address");
                    continue;
                }

                ev.data.fd = accp_fd;
                ev.events = EPOLLIN | EPOLLET;
                // 为新accept的 file describe 设置epoll事件
                __result = epoll_ctl(epfd, EPOLL_CTL_ADD, accp_fd, &ev);

                if (-1 == __result) {
                    perror("epoll_ctl");
                    return 0;
                }
            } else {
                // 其余事件为 file describe 可以读取
                ssize_t result_len = 0;
                char buf[READ_BUF_LEN] = { 0 };

                result_len = read(event[i].data.fd, buf, sizeof (buf) / sizeof (buf[0]));
                //Read client's request

                if (result_len <= 0) {
                    perror ("Error: Read data");
                } else {
                  int n;
                  // n=write(STDOUT_FILENO, buf, result_len);
                  // fflush(stdout);
                  n=write(event[i].data.fd, buf, result_len);
                  //Echo client's request as response
                  if (n <= 0) 
                    perror("Error: write to socket");
                }
                // printf("Closed connection\n");
                close (event[i].data.fd);
            }
        }
    }
    close (epfd);
    return 0;
}