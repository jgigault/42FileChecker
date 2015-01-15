#include <string.h>
#include <stdint.h>
int ft_printf(char const *str, ...);
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
  ft_printf("\n");
  ft_printf("%%\n");
  ft_printf("%d\n", 42);
  ft_printf("%d%d\n", 42, 41);
  ft_printf("%d%d%d\n", 42, 43, 44);
  ft_printf("%ld\n", l);
  ft_printf("%lld\n", ll);
  ft_printf("%x\n", 505);
  ft_printf("%X\n", 505);
  ft_printf("%p\n", &ll);
  ft_printf("%20.15d\n", 54321);
  ft_printf("%-10d\n", 3);
  ft_printf("% d\n", 3);
  ft_printf("%+d\n", 3);
  ft_printf("%010d\n", 1);
  ft_printf("%hhd\n", c);
  ft_printf("%jd\n", im);
  ft_printf("%zd\n", (size_t)i);
  ft_printf("%U\n", i);
  ft_printf("%u\n", i);
  ft_printf("%o\n", 40);
  ft_printf("%#08x\n", 42);
  ft_printf("%x\n", 1000);
  ft_printf("%#X\n", 1000);
  ft_printf("%s\n", NULL);
  ft_printf("%S\n", L"ݗݜशব");
  ft_printf("%s%s\n", "test", "test");
  ft_printf("%s%s%s\n", "test", "test", "test");
  ft_printf("%C\n", 15000);
 }
 return (0);
}
