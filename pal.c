#include <stdio.h>

int pal(const char* s, int n) {
	if(n < 2)
		return 1;

	if(s[0] != s[n - 1])
		return 0;
	
	return pal(s + 1, n - 2);
}

int main() {
	printf("%d\n", pal("osso", 4));
}