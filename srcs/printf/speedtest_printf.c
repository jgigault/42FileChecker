#include <string.h>
#include <stdio.h>
#include <stdint.h>
int main(void)
{
 long long a = 0;
 int i = 2147483647;
 long l = 2147483647;
 long long ll = 9223372036854775807;
 char c = 0;
 intmax_t im = 9223372036854775807;
 while (a++ < ll)
 {
  printf("\n");
  printf("%%\n");
  printf("%d\n", 42);
  printf("%d%d\n", 42, 41);
  printf("%d%d%d\n", 42, 43, 44);
  printf("%ld\n", l);
  printf("%lld\n", ll);
  printf("%x\n", 505);
  printf("%X\n", 505);
  printf("%p\n", &ll);
  printf("%20.15d\n", 54321);
  printf("%-10d\n", 3);
  printf("% d\n", 3);
  printf("%+d\n", 3);
  printf("%010d\n", 1);
  printf("%hhd\n", c);
  printf("%jd\n", im);
  printf("%zd\n", (size_t)i);
  printf("%u\n", i);
  printf("%o\n", 40);
  printf("%#08x\n", 42);
  printf("%x\n", 1000);
  printf("%#X\n", 1000);
  printf("%S\n", L"ݗݜशব");
  printf("%s%s\n", "test", "test");
  printf("%s%s%s\n", "test", "test", "test");
  printf("%C\n", 15000);
 }
 return (0);
}
