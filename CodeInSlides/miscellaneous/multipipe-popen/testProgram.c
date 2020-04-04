#include <stdio.h>
#include <string.h>

int main()
{
	char buff[1024]={0};
	int totalLine=0;
	while(fgets(buff, 1024, stdin)!=NULL)
	{
		fprintf(stdout, "Line %d: %s", totalLine, buff);
		fflush(stdout); //如果用户程序没有主动flush，程序没结束的话外面可能永远看不到他的输出，测量出来的时间也很长
		//但没关系，这个时间是用户程序没写好导致的，算到他头上也不亏
		totalLine++;
		memset(buff,0,sizeof(buff[0])*1024);
	}
}