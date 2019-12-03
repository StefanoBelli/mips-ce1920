#include <stdio.h>

int sost_conta(int* arr, int m, int k, int h) {
	if(m == 1) {
		if(arr[0] == k) {
			arr[0] = h;
			return 1;
		} else {
			return 0;
		}
	} else {
		return sost_conta(arr, m/2, k, h) + sost_conta(arr+m/2,m/2, k, h);
	}
}


int main() {
	int arr[4] = { 1, 4, 3, 2 };
	int ret = sost_conta(arr, 1, 3, 2);
	printf("%d\n", ret);
	return 0;
}

