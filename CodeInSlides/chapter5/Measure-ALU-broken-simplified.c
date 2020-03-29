#define RUN_TIMES 1000000000

int main(int argc, char *argv[])
{
  {
    int A=17, B=13, C=0;
    int i;
    for(i=0;i<RUN_TIMES;i++)
    {
    }
  }

  {
    int A=17, B=13, C=0;
    int i;
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A*B;
    }
  }

  {
    int A=17, B=13, C=0;
    int i;
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A/B;
    }
  }

  {
    double A=17, B=13, C=0;
    int i;
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A*B;
    }
  }

  {
    double A=17, B=13, C=0;
    int i;
    for(i=0;i<RUN_TIMES;i++)
    {
      C=A/B;
    }
  }
}