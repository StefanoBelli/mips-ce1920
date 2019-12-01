#include <stdio.h>

int T(int m, int n) {
	if (m < 3 || n < 3)
		return 1;

	return T(m - 1, n - 2) + T(m / 2, n - 2) + 2*m + n;
}

int main() {
	printf("%d", T(40, 41));
}
