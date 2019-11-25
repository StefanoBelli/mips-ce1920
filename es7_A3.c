#include <stdio.h>

int f(int);

int min3(int a, int b, int c) {
	int first_min = a < b ? a : b;
	return first_min < c ? first_min : c;
}

int g(int i) {
	if (i < 3)
		return 4;

	return min3(f(i/2), g(i - 1), i);
}

int f(int i) {
	if (i < 2)
		return 1;
	
	return 2*f(i - 2) + 5*g(i - 1) + i - 3;
}

int main() {
	printf("%d\n", f(10));
}

