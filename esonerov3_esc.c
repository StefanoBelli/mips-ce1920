#include <stdio.h>

int central_swap(int m, int n, int mat[m][n]) {
	if(m != n)
		return 1;

	int mid = (int) m / 2;

	for(int i = 0; i < m; ++i) {
		int tmp = mat[mid][i];
		mat[mid][i] = mat[i][mid];
		mat[i][mid] = tmp;
	}

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

        central_swap(3, 3, A);

        print_matrix(3,3, A);

}

