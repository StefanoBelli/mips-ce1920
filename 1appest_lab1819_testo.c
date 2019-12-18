/******************************************************************
You are editing the '/home/esame/prog.c' file. You cannot remove
this file, just edit it so as to produce your own program according to
the specification listed below.
 
In the '/home/esame/'directory you can find a Makefile that you can
use to compile this program to generate the executable for this examination.
Typing 'make' you will compile so to generate the 'prog' executable.
 
To run the program go to /home/esame and type:
./prog
 
Most of the requested header files are already included in the head of the
prog.c file you are editing.
 
============================================================================

Scrivere la funzione "matrix2list" (ed eventuali funzioni ausiliari) in C che, 
data in ingresso una matrice di interi avente numero di colonne fisso pari a N, 
restituisce la lista ordinata in modo crescente e senza ripetizioni dei numeri 
interi positivi presenti nella matrice, corredando ciascun numero nella lista 
del relativo numero di occorrenze.  

Gli elementi della lista sono definiti come segue:

struct node {
	int num;
	int occ; 
	struct node *next;
};

Esempio 1: assumendo N=3, se la matrice è A={{2, -1, 0},{4, 1, -2}}, 
la funzione restituisce il puntatore alla seguente lista di elementi di tipo struct node:
{(1, 1)}->{(2, 1)}->{(4, 1)}. 

Esempio 2: assumendo N=3, se la matrice è B={{3, 3, 3},{0, -5, 2},{2, 3, 6}}, 
la funzione restituisce il puntatore alla seguente lista di elementi di tipo struct node: 
{(2, 2)}->{(3, 4)}->{(6, 1)}.

Se nessun numero intero soddisfa la condizione sopra descritta, la funzione 
restituisce una lista vuota. 

Per l'implementazione e la verifica del corretto funzionamento della funzione 
realizzata, si usi lo scheletro di codice sotto riportato, e si implementi anche 
la funzione: 

print_list 

che stampa, per ogni elemento della lista, il valore del campo numero ed il 
relativo numero di occorrenze.

****************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 3

struct node {
	int num;
	int occ;
	struct node *next;
};

struct node *new_node(int n, int o) {
	struct node* nd = (struct node*) malloc(sizeof(struct node));
	if(nd == NULL)
		return NULL;

	nd->num = n;
	nd->occ = o;
	nd->next = NULL;

	return nd;
}

int in_list(struct node* head, int elem) {
	while(head) {
		if (head->num == elem)
			return 1;
		
		head = head->next;
	}

	return 0;
}

int count_occ(int m, int mat[m][N], int elem) {
	int c = 0;
	for(int i = 0; i < m; ++i) {
		for(int j = 0; j < N; ++j) {
			if (elem == mat[i][j])
				++c;
		}
	}

	return c;
}

struct node *matrix2list(int m, int mat[m][N]) {
	if(m == 0)
		return NULL;

	struct node *head = NULL;
	struct node *realhead = NULL;

	for(int i = 0; i < m; ++i) {
		for(int j = 0; j < N; ++j) {
			if(mat[i][j] > 0 && !in_list(head, mat[i][j])) {
				if(realhead == NULL) {
					if((head = new_node(mat[i][j], count_occ(m, mat, mat[i][j]))) == NULL)
						return NULL;
					realhead = head;
				} else {
					struct node* prev = head;
					while(head && mat[i][j] >= head->num) {
						prev = head;
						head = head->next;
					}

					if(head == NULL) {
						if((prev->next = new_node(mat[i][j], count_occ(m, mat, mat[i][j]))) == NULL)
							return NULL;
					} else if (head == realhead) {
						struct node* oldprev = head;
						if((head = new_node(mat[i][j], count_occ(m, mat, mat[i][j]))) == NULL)
							return NULL;
						head->next = oldprev;
						realhead = head;
					} else {
						struct node* oldprev = prev->next;
						if((prev->next = new_node(mat[i][j], count_occ(m, mat, mat[i][j]))) == NULL)
							return NULL;
						prev->next->next = oldprev;
					}
				}
				
				head = realhead;
			}
		}
	}

	return realhead;
}

void print_list(struct node* head) {
	printf("[ ");
	while(head) {
		printf("(%d, %d) ", head->num, head->occ);
		head = head->next;
	}
	printf("]");
}

void free_list(struct node **head) {
	struct node *next;
	while(*head) {
		next = (*head)->next;
		free(*head);
		*head = next;
	}
}

int main(int argc, char** argv) {

	int A[2][N]={{2, -1, 0},{4, 1, -2}};
	int B[3][N]={{3, 3, 3},{0, -5, 2},{2, 3, 6}};
	int C[6][N]={{7, 7, 0}, {7, 1, 3}, {7, 8, 6}, { 0, 0, 0}, {10,9,6}, {6,6,6}};

	struct node *list_head1, *list_head2, *list_head3;

	/* Invocare la funzione "matrix2list" con l'array A come argomento */
	list_head1 = matrix2list(2, A);
	print_list(list_head1);

	/* Invocare la funzione "matrix2list" con l'array B come argomento */
	list_head2 = matrix2list(3, B);
	print_list(list_head2);

	list_head3 = matrix2list(6, C);
	print_list(list_head3);

	free_list(&list_head1);
	free_list(&list_head2);
	free_list(&list_head3);

	return 0;
}
