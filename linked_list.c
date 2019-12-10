#include <stdlib.h>
#include <stdio.h>

typedef struct node {
	int data;
	struct node *next;
} node_t;

int insert_list(node_t** l, int at, int data) {
	node_t* nn = (node_t*) malloc(sizeof(node_t));
	if(nn == NULL)
		return -1;

	nn->data = data;
	nn->next = NULL;

	if (*l == NULL)
		*l = nn;
	else if(at == 0) {
		node_t* oldhead = *l;
		*l = nn;
		(*l)->next = oldhead;
	} else {
		node_t* bak = *l;

		for(int i = 0; i < at - 1; ++i)
			*l = (*l)->next;

		nn->next = (*l)->next;
		(*l)->next = nn;

		*l = bak;
	}

	return 0;
}

void print_list(node_t* l) {
	printf("[ ");
	while (l) {
		printf("%d ", l->data);
		l = l->next;
	}
	printf("]");
}

void delete_node_list(node_t** l, int at) {
	node_t* bak = *l;

	if (at == 0) {
		*l = (*l)->next;
		bak->data = 0;
		bak->next = NULL;
		free(bak);
	} else {
		for(int i = 0; i < at - 1; ++i)
			*l = (*l)->next;

		node_t* delnode = (*l)->next;
		(*l)->next = delnode->next;
		delnode->data = 0;
		delnode->next = NULL;
		free(delnode);
		
		*l = bak;
	}
}

void delete_list(node_t** l) {
	for(;*l;)
		delete_node_list(l, 0);
}

int len_list(node_t* l) {
	if (l == NULL)
		return 0;

	int i = 0;
	for(; l; i++)
		l = l->next;

	return i;
}

int main() {
	node_t* head = NULL;
	for(int i = 0; i < 100; ++i)
		insert_list(&head, i, i+1);

	delete_list(&head);
	return 0;
}

