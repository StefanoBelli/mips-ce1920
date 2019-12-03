#include <stdio.h>
#include <stdlib.h>

//nz x 3
int** sparse_enum(int r, int c, int A[r][c], int nz) {
	int** B = (int**) malloc(sizeof(int*) * nz);
	if ((int*)B == NULL)
		return NULL;

	for(int i = 0; i < nz; ++i) {
		B[i] = (int*) malloc(sizeof(int) * 3);
		if(B[i] == NULL)
			return NULL;
	}

	int nz_count = 0;
	for(int i = 0; i < r; ++i) {
		for(int j = 0; j < c; ++j) {
			if(A[i][j] != 0) {
				B[nz_count][0] = A[i][j];
				B[nz_count][1] = i;
				B[nz_count][2] = j;
				nz_count++;
			}
		}
	}

	return B;
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
	int sparse[5][6] = { 
		{ 4,0,0,3,0,0 }, 
		{ 0,1,0,0,0,0 }, 
		{ 0,1,0,0,0,9 },
		{ 0,0,0,1,0,0 },
		{ 0,0,1,0,6,0 }
	};

	print_matrix(5, 6, sparse);
	puts("");

	int** enumerate = sparse_enum(5, 6, sparse, 8);

	for(int i = 0; i < 8; ++i) {
		for(int j = 0; j < 3; ++j) {
			printf("%d ", enumerate[i][j]);
		}
		puts("");
	}

	free(enumerate);
}

