#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node {
	char* data;
	struct node *next;
} node_t;

node_t* create_node() {
	node_t* n = (node_t*) malloc(sizeof(node_t));
	if(n == NULL)
		return NULL;

	n->data = NULL;
	n->next = NULL;
}

int len(const char* s) {
	int i = 0;

	for (; *(s + i) != ' ' && *(s + i) != 0; ++i) 
		;

	return i;
}

node_t* tokenizer(const char* s, int n) {
	node_t* beg = create_node();
	if(beg == NULL)
		return NULL;

	node_t* head = beg;
	node_t* before_last = head;

	for(int i = 0; i < n; ++i) {
		while(s[i] == ' ')
			++i;
		
		int l = len(s + i);

		if(l > 0) {
			beg->data = (char*) malloc(sizeof(char) * l);
			if(beg->data == NULL)
				return NULL;

			strncpy(beg->data, s + i, l);

			beg->next = create_node();
			before_last = beg;
			beg = beg->next;

			i += l;
		}
	}

	free(before_last->next->data);
	free(before_last->next);
	before_last->next = NULL;

	return head;
}

void print_list(node_t* head) {
	printf("[ ");
	while(head) {
		printf("\"%s\", ", head->data);
		head = head->next;
	}
	printf("]");
}

void free_list(node_t** head) {
	node_t* tmp = *head;
	while(*head) {
		tmp = (*head)->next;
		free((*head)->data);
		free(*head);
		*head = tmp;
	}
}

int main() {
	char* str = "Esame di Calcolatori";
	node_t* tokens = tokenizer(str, strlen(str));
	print_list(tokens);
	free_list(&tokens);
	
	return 0;
}

