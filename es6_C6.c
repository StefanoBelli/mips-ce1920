#include <stdio.h>
#include <stdlib.h>

typedef struct node {
	int nzelem;
	int nzrow;
	int nzcol;
	struct node *next;
} node_t;

node_t* create_node() {
	node_t* n = (node_t*) malloc(sizeof(node_t));
	if (n == NULL)
		return NULL;

	n->nzelem = 0;
	n->nzrow = 0;
	n->nzcol = 0;
	n->next = NULL;
	
	return n;
}

node_t* sparse_enum(int m, int n, int sparse[m][n]) {
	node_t *beg = create_node();
	if(beg == NULL)
		return NULL;

	node_t *head = beg;
	node_t *last = head;

	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			if (sparse[i][j] != 0) {
				beg->nzelem = sparse[i][j];
				beg->nzrow = i;
				beg->nzcol = j;
				beg->next = create_node();
				if(beg->next == NULL)
					return NULL;
				last = beg;
				beg = beg->next;
			}
		}
	}

	free(last->next);
	last->next = NULL;

	return head;
}

void print_list(node_t* l) {
	printf("[ ");
	while(l) {
		printf("(%d,%d,%d) ", l->nzelem, l->nzrow, l->nzcol);
		l = l->next;
	}
	printf("]");
}

void free_list(node_t** l) {
	node_t *tmp = *l;

	while(*l) {
		tmp = (*l)->next;
		free(*l);
		*l = tmp;
	}

}

int main() {
	int A[4][4] = { 
		{ 0, 0, 0, 0 }, 
		{ 5, 8, 0, 0 }, 
		{ 0, 0, 3, 0 }, 
		{ 0, 6, 0, 0 } 
	};

	node_t* list = sparse_enum(4, 4, A);
	print_list(list);
	free_list(&list);

	return 0;
}
