#include <stdio.h>
#include <stdlib.h>

struct node {
	int numero;
	int occorrenze;
	struct node *next;
};

struct node* create_node(int numero, int occ, struct node* next) {
	struct node* beg = (struct node*) malloc(sizeof(struct node));
	if (beg == NULL)
		return NULL;

	beg->numero = numero;
	beg->occorrenze = occ;
	beg->next = next;
	
	return beg;
}

int verifica_esistenza(struct node* a, int elem) {
	while (a->next) {
		if (a->numero == elem)
			return 1;
		a = a->next;
	}

	return 0;
}

int conta_occ(int* arr, int n, int elem) {
	int c = 0;

	for (int i = 0; i < n; ++i) {
		if (arr[i] == elem)
			c++;
	}

	return c;
}

struct node* numero_occorrenze(int* arr, int n) {
	struct node* list = create_node(0, 0, NULL);
	if (list == NULL)
		return NULL;

	struct node* head = list;
	struct node* last = NULL;

	for(int i = 0; i < n; ++i) {
		if(!verifica_esistenza(head, arr[i])) {
			list->numero = arr[i];
			list->occorrenze = conta_occ(arr, n, arr[i]);
			list->next = create_node(0, 0, NULL);
			if(list->next == NULL)
				return NULL;
			last = list;
			list = list->next;
		}
	}

	free(last->next);
	last->next = NULL;
	return head;
}

void print_list(struct node* list_head) {
	printf("[ ");
	while (list_head) {
		printf("(%d,%d) ", list_head->numero, list_head->occorrenze);
		list_head = list_head->next;
	}
	printf("]");
}

void free_list(struct node* list) {
	struct node* bak = list;

	while (list) {
		bak = list->next;
		free(list);
		list = bak;
	}
}

int main() {
	int A[7] = { 3,0,3,4,4,4,4 };

	struct node *list_head;
	
	list_head = numero_occorrenze(A,7);

	print_list(list_head);
	
	free_list(list_head);
	list_head = NULL;
	return 0;
}

