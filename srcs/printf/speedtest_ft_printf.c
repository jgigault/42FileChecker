#include <string.h>
#include <stdint.h>
#include <time.h>
int ft_printf(char const *str, ...);
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
  ft_printf("\n");
  ft_printf("%%\n");
  ft_printf("%d\n", 42);
  ft_printf("%d%d\n", 42, 41);
  ft_printf("%d%d%d\n", 42, 43, 44);
  ft_printf("%ld\n", l);
  ft_printf("%lld\n", ll);
  ft_printf("%x %X %p %20.15d\n", 505, 505, &ll, 54321);
  ft_printf("%-10d % d %+d %010d %hhd\n", 3, 3, 3, 1, c);
  ft_printf("%jd %zd %u %o %#08x\n", im, (size_t)i, i, 40, 42);
  ft_printf("%x %#X %S %s%s\n", 1000, 1000, L"ݗݜशব", "test", "test2");
  ft_printf("%s%s%s\n", "test", "test", "test");
  ft_printf("%C\n", 15000);
 }
 return (0);
}
