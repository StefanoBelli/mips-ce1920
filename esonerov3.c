#include <stdio.h>

int min3(int x, int y, int z) {
	int curmin = x < y ? x : y;
	return curmin < z ? curmin : z;
}

int f(int);

int g(int i) {
	if(i < 3)
		return 5;
	
	return min3(f(i - 2), g(i / 4), i - 1);
}

int f(int i) {
	if(i < 2)
		return 3;
	
	return 4*g(i / 2) - 3*f(i - 1) + i + 5;
}

int main() {
	printf("%d\n", f(10));
}
