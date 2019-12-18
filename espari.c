/* 
Scrivere una prima funzione in C che, dato in ingresso un array di interi,  
restituisce la lista contenente gli elementi dell'array ed il loro indice. 
Scrivere una seconda funzione in C che, presa in input la lista creata dalla 
funzione precedente, restituisce in output una lista formata dagli elementi 
dell'array con indice pari.  
*/
#include <stdio.h>
#include <stdlib.h>

struct node {
	int elem;
	int idx;
	struct node *next;
};

struct node* new_node(int e, int i) {
	struct node* nd = (struct node*) malloc(sizeof(struct node));
	if(nd == NULL)
		return NULL;
	
	nd->elem = e;
	nd->idx = i;
	nd->next = NULL;

	return nd;
}

struct node* enumerate(int *arr, int n) {
	if(n == 0)
		return NULL;

	struct node* head = new_node(arr[0], 0);
	if(head == NULL)
		return NULL;

	struct node* realhead = head;

	for(int i = 1; i < n; ++i) {
		head->next = new_node(arr[i], i);
		head = head->next;
	}
	
	return realhead;
}

struct node* filter_list(struct node* head) {
	struct node* nd = new_node(head->elem, head->idx);
	if(nd == NULL)
		return NULL;
	
	struct node* realhead = nd;

	for(head = head->next->next; head; head = head->next->next, nd = nd->next) 
		nd->next = new_node(head->elem, head->idx);

	return realhead;
}

void print_list(struct node *head) {
	printf("[ ");
	for(; head; head = head->next)
		printf("(%d, %d) ", head->elem, head->idx);
	printf(" ]");
}

void free_list(struct node **head) {
	struct node* tmp;
	while(*head) {
		tmp = (*head)->next;
		free(*head);
		*head = tmp;
	}
}

int main() {
	int arr[10] = {-1, 10, 90, 8, 1, 5, 9, 0, 6, 100 };

	struct node* enumerated_list = enumerate(arr, 10);
	struct node* even_list = filter_list(enumerated_list);
	
	print_list(even_list);
	
	free_list(&even_list);
	free_list(&enumerated_list);

	return 0;
}
