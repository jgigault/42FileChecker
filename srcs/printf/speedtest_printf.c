#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
int main(void)
{
 clock_t time;
 time = clock();
 int i = 2147483647;
 long l = 2147483647;
 long long ll = 9223372036854775807;
 char c = 0;
 intmax_t im = 9223372036854775807;
 while ((double)time/CLOCKS_PER_SEC < 15)
 {
  time = clock();
  printf("\n");
  fflush(stdout);
  printf("%%\n");
  fflush(stdout);
  printf("%d\n", 42);
  fflush(stdout);
  printf("%d%d\n", 42, 41);
  fflush(stdout);
  printf("%d%d%d\n", 42, 43, 44);
  fflush(stdout);
  printf("%ld\n", l);
  fflush(stdout);
  printf("%lld\n", ll);
  fflush(stdout);
  printf("%x %X %p %20.15d\n", 505, 505, &ll, 54321);
  fflush(stdout);
  printf("%-10d % d %+d %010d %hhd\n", 3, 3, 3, 1, c);
  fflush(stdout);
  printf("%jd %zd %u %o %#08x\n", im, (size_t)i, i, 40, 42);
  fflush(stdout);
  printf("%x %#X %S %s%s\n", 1000, 1000, L"ݗݜशব", "test", "test2");
  fflush(stdout);
  printf("%s%s%s\n", "test", "test", "test");
  fflush(stdout);
  printf("%C\n", 15000);
  fflush(stdout);
 }
 return (0);
}
