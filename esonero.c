#include <stdio.h>

#define swap(a, b) \
{ \
	int swptmp = a; \
	a = b; \
	b = swptmp; \
}

int diag_swap(int m, int n, int mat[m][n]) {
	if (m != n)
		return 1;


	for(int i = 0; i < m; ++i)
		swap(mat[i][m - i - 1], mat[i][i]);

	return 0;
}

void print_matrix(int m, int n, int mat[m][n]) {
	for(int i = 0; i < m; ++i) {
		for(int j = 0; j < n; ++j) {
			printf("%d ", mat[i][j]);
		}
		puts("");
	}
}


int main() {
	int m[3][3] = { {1,4,5}, {2,5,3}, {6,3,8} };
	print_matrix(3, 3, m);
	int rv = diag_swap(3, 3, m);
	printf("diag_swap: %d\n\n", rv);
	print_matrix(3, 3, m);
	
	return 0;
}

