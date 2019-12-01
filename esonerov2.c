#include <stdio.h>

#define swap(expr,expr1) \
{ \
	int tmp = expr; \
	expr = expr1; \
	expr1 = tmp; \
}

int swap_rc(int m, int n, int mat[m][n]) {
	if (m != n) 
		return 1;

	for (int i = 0; i < m; ++i)
		swap(mat[m - 1][i], mat[i][m - 1]);

	return 0;
}

void print_matrix(int m, int n, int mat[m][n]) {
	for(int i = 0; i < m; ++i) {
		for(int j = 0; j < n; ++j)
			printf("%d ",mat[i][j]);
		puts("");
	}
}


int main() {
	int A[3][3] = { {1, 4, 5}, {2, 5, 3}, {6, 7, 8} };

	swap_rc(3, 3, A);

	print_matrix(3,3, A);

}

