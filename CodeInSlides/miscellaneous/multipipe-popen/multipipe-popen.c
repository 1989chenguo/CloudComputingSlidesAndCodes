/**
 * Copyright 2009-2010 Bart Trojanowski <bart@jukie.net>
 * Licensed under GPLv2, or later, at your choosing.
 *
 * bidirectional popen() call
 *
 * @param rwepipe - int array of size three
 * @param exe - program to run
 * @param argv - argument list
 * @return pid or -1 on error
 *
 * The caller passes in an array of three integers (rwepipe), on successful
 * execution it can then write to element 0 (stdin of exe), and read from
 * element 1 (stdout) and 2 (stderr).
 */
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h> 

int popenRWE(int *rwepipe, char *command) {
	int in[2];
	int out[2];
	int err[2];
	int pid;
	int rc;

	rc = pipe(in);
	if (rc<0)
		goto error_in;

	rc = pipe(out);
	if (rc<0)
		goto error_out;

	rc = pipe(err);
	if (rc<0)
		goto error_err;

	pid = fork();
	if (pid > 0) { /* parent */
		close(in[0]);
		close(out[1]);
		close(err[1]);
		rwepipe[0] = in[1];
		rwepipe[1] = out[0];
		rwepipe[2] = err[0];
		return pid;
	} else if (pid == 0) { /* child */
		close(in[1]);
		close(out[0]);
		close(err[0]);
		close(0);
		if(!dup(in[0])) {
			;
		}
		close(1);
		if(!dup(out[1])) {
			;
		}
		close(2);
		if(!dup(err[1])) {
			;
		}

		execl( "/bin/sh", "sh", "-c", command, NULL );
		_exit(1);
	} else
		goto error_fork;

	return pid;

error_fork:
	close(err[0]);
	close(err[1]);
error_err:
	close(out[0]);
	close(out[1]);
error_out:
	close(in[0]);
	close(in[1]);
error_in:
	return -1;
}

int pcloseRWE(int pid, int *rwepipe)
{
	int status;
	close(rwepipe[0]);
	close(rwepipe[1]);
	close(rwepipe[2]);
	waitpid(pid, &status, 0);
	return status;
}

void* ReadOutput(void* args) {
	int* read_fd = (int*) args;
	char bufferRead[BUFSIZ];
	int totalOutputBytes=0;
	memset(bufferRead,0,sizeof(bufferRead[0])*(BUFSIZ));
	int oByte=0;
	while((oByte=read(*read_fd,bufferRead,BUFSIZ))>0)
	{
		totalOutputBytes=totalOutputBytes+oByte;
		printf("%s",bufferRead);
		memset(bufferRead,0,sizeof(bufferRead[0])*(BUFSIZ));
		usleep(100000);//检测输出的间隔
	}
	printf("\n\nRead done!\n\n");
}

int main()
{
	int fd[3];
	int pid=0;
	pid=popenRWE(fd,"./testProgram");
    if(pid<0)
    {
    	fprintf(stderr, "popenRWE ERROR!\n");
    	exit(1);
    }
    int write_fd=fd[0];
    int read_fd=fd[1];

    printf("write_fd %d, read_fd %d\n",write_fd,read_fd);

    pthread_t th;
    if(pthread_create(&th, NULL, ReadOutput, &read_fd)!=0)
    {
      perror("pthread_create failed");
      exit(1);
    }

    char bufferWrite[BUFSIZ];
    int totalInputBytes=0;
    while(1)
    {
    	memset(bufferWrite,0,sizeof(bufferWrite[0])*(BUFSIZ));
    	sprintf(bufferWrite,"test input %d\n",totalInputBytes);
    	int byteToWrite=strlen(bufferWrite);
    	int byteWritten=0;
    	while(byteWritten<byteToWrite)
		{
			int nByte=0;
		    if((nByte=write(write_fd,bufferWrite+byteWritten,byteToWrite-byteWritten))<=0)
		    {
		      fprintf(stderr,"write() ERROR!\n");
		      exit(1);
		    }
		    byteWritten=byteWritten+nByte;
		}
    	// printf("Input %d-%d (B): %s",totalInputBytes,totalInputBytes+byteWritten,bufferWrite);

        totalInputBytes=totalInputBytes+byteWritten;
        if(totalInputBytes>=1000)
        {
        	close(write_fd); //关闭用户程序的stdin，相当于主动给用户程序发一个EOF，促使他结束（如果同学没写好没处理EOF，他可能会崩）
        	break;
        }
        usleep(100000);//给输入的间隔
    }
    pthread_join(th, NULL);
    pcloseRWE(pid,fd);
}
