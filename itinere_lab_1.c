#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct node {
	char *word;
	struct node *next;
};

void insert(struct node **list, char* value) {
	struct node* new_node = (struct node*) malloc(sizeof(struct node));
	if (new_node == NULL)
		return;
	new_node->word = value;
	new_node->next = NULL;

	if (*list == NULL) { //first insertion
		*list = new_node;
	} else {
		struct node* initial = *list;
		while (initial->next) {
			if (strcmp(initial->word, value) == 0) {
				free(new_node);
				return;
			}
			initial = initial->next;
		}

		initial->next = new_node;
	}
}

void print_list(struct node *list) {
	printf("[ ");
	for(; list; list = list->next)
		printf("%s ", list->word);
	printf("]");
}

float avg_word_length(struct node *list) {
	float s = 0;
	int i = 0;

	for(; list; list = list->next, ++i)
		s += strlen(list->word);

	return s / i;
}

void free_list(struct node **list) {
	struct node *bak = *list;

	while(*list) {
		bak = (*list)->next;
		free(*list);
		(*list) = bak;
	}

	*list = NULL;
}

int main() {
	struct node *list_head = NULL;

	insert(&list_head, "elettronici");
	print_list(list_head);

	insert(&list_head, "calcolatori");
	print_list(list_head);

	insert(&list_head, "prova pratica");
	print_list(list_head);

	insert(&list_head, "calcolatori");
	print_list(list_head);

	printf("Media lunghezza = %f\n", avg_word_length(list_head));

	free_list(&list_head);
	return 0;
}
