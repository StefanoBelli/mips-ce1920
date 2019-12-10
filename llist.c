#include <stdlib.h>

typedef struct node {
	int data;
	struct node *next;
} node_t;

void insert_list(node_t** list, int at, int data) {
	node_t* n = (node_t*) malloc(sizeof(node_t));
	if(n == NULL)
		return;

	n->data = data;
	n->next = *list;

	if (list == NULL || at == 0)
		*list = n;
	else {
		node_t* cur = *list;

		for (int i = 0; i < at - 1; ++i)
			*list = (*list)->next;

		node_t* oldnext = (*list)->next;
		(*list)->next = n;
		n->next = oldnext;

		*list = cur;
	}
}

void print_list(node_t* from) {
	while(from) {
		printf("%d ", from->data);
		from = from->next;
	}
}

int len_list(node_t* from) {
	int i = 0;
	while(from) {
		from = from->next;
		++i;
	}
	return i;
}

void delete_node_list(node_t** l, int idx) {
	if(idx == 0) {
		node_t* oldnext = (*l)->next;
		(*l)->data = 0;
		(*l)->next = NULL;
		free(*l);
		*l = oldnext;
	} else {
		node_t* tmp = *l;
		for(int i = 0; i < idx - 1; ++i)
			*l = (*l)->next;

		node_t* todel = (*l)->next;
		(*l)->next = todel->next;
		todel->data = 0;
		todel->next = NULL;
		free(todel);
		
		*l = tmp;
	}
}

int main() {
	node_t* head = NULL;
	insert_list(&head, 0, 1);
	insert_list(&head, 1, 2);
	insert_list(&head, 2, 3);
	insert_list(&head, 3, 4);

	print_list(head);
	printf("%d\n", len_list(head));

	for(int i = 0; i < len_list(head); ++i)
		delete_node_list(&head, i);

	return 0;
}


