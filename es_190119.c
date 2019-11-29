#include <stdio.h>

int do_smt(int m, int n, int k, int mat[m][n], int vec[k]) {
	int sum = 0;

	for(int i = 0; i < m; ++i) {
		for(int j = 0; j < n; ++j) {
			if(mat[i][j] < vec[i])
				mat[i][j] = 0;
			else
				sum++;
		}
	}

	if(m == k) 
		return sum;

	return -1;
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
	int A[3][2] = { {4,8}, {1, -3}, {2, 1} };
	int vk[3] = { 5, -1, 3 };

	int s = do_smt(3, 2, 3, A, vk);
	printf("%d\n", s);
	print_matrix(3, 2, A);

	return 0;
}

