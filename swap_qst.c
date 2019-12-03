#include <stdio.h>

void swap2(int x, int y) {
	puts("swap2()");
}

void swap(int x, int y) {
	puts("swap()");
}

void swap3(int* x, int* y) {
	int* tmp = x;
	x = y;
	y = tmp;
}

int main() {
	int x = 8, y = 7;

	if (x < y) // mai verificata 
		swap(x, y);
	if (x < y) // mai verificata
		swap2(x, y);
	if (x >= y)
		swap3(&x, &y);

	printf("%d, %d\n", x, y);
	return 0;
}

