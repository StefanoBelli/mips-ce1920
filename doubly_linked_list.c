#include <stdlib.h>
#include <stdio.h>

typedef struct node {
	int data;
	struct node *next;
	struct node *prev;
} node_t;

void insert_list(node_t **head, int at, int data) {
	node_t *new_node = (node_t*) malloc(sizeof(node_t));
	if(new_node == NULL)
		return;

	new_node->next = NULL;
	new_node->prev = NULL;
	new_node->data = data;

	if(*head == NULL)
		*head = new_node;
	else if(at == 0) {
		node_t *oldhead = *head;
		new_node->next = oldhead;
		oldhead->prev = new_node;
		*head = new_node;
	} else {
		node_t *bakhead = *head;
		for(int i = 0; i < at - 1; ++i)
			*head = (*head)->next;

		new_node->next = (*head)->next;
		new_node->prev = (*head);
		 
		if(new_node->next)
			new_node->next->prev = new_node;
		
		(*head)->next = new_node;

		*head = bakhead;
	}
}

void delete_node_list(node_t **head, int at) {
	if (at == 0) {
		node_t* n = (*head)->next;
		if(n)
			n->prev = NULL;
		free(*head);
		*head = n;
	} else {
		node_t *bakhead = *head;
		for(int i = 0; i < at - 1; ++i)
			*head = (*head)->next;

		node_t *delnode = (*head)->next;
		(*head)->next = delnode->next;
		
		if((*head)->next)
			(*head)->next->prev = *head;

		free(delnode);
		*head = bakhead;
	}
}

void delete_list(node_t **head) {
	for(;*head;)
		delete_node_list(head, 0);
}

void print_list(node_t *head) {
	printf("[ ");
	while(head) {
		printf("%d ", head->data);
		head = head->next;
	}
	printf("]");
}

void print_reversed_list(node_t *head) {
	if(head) {
		while(head->next)
			head = head->next;
	}

	printf("[ ");
	while(head) {
		printf("%d ", head->data);
		head = head->prev;
	}
	printf("]");
}


int main() {
	node_t *head = NULL;

	for(int i = 0; i < 1000; ++i)
		insert_list(&head, i, i+1);
	delete_list(&head);
	return 0;
}

