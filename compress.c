#include <stdlib.h>

// s: stringa da comprimere
// ritorna: NULL se len(s) == 0 o malloc fallisce, la stringa compressa altrimenti.
char* comprimi(char* s) {
	int s_len = 1; //impostato a uno per tenere conto del terminatore nella nuova stringa (non devo incrementare s_len dopo)
	char* bak_s = s;
	while(*bak_s++ != 0)
		s_len++;

	if(s_len == 1) // se la lunghezza è pari a 0
		return NULL;

	int cnt = 0; //conta il numero di caratteri 'chr' trovati di seguito
	char chr = 0; //il carattere corrente
	
	char* ns = (char*) malloc(sizeof(char) * s_len); //nuova stringa
	if(ns == NULL) //se malloc fallisce (memoria esaurita)
		return NULL;

	int ns_i = 0; //tiene traccia delle posizioni scritte in ns

	for(int i = 0; i < s_len; ++i) {
		if(chr == s[i])
			cnt++; //incrementa il contatore di caratteri successivi se s[i] è uguale al carattere precedente
		else { //sequenza interrotta
			if(cnt < 3) { //in questo caso il numero di caratteri letti è < 3, quindi scrivili senza comprimere
				for(int j = 0; j < cnt; ++j) {
					ns[ns_i] = chr;
					ns_i++;
				}

			} else { //il numero di caratteri letti è K >= 3, scrivi Kc
				ns[ns_i] = cnt + 48; // codifica ascii per il numero 'K'
				ns[ns_i + 1] = chr;  // scrivi in posizione successiva il carattere 'c'
				ns_i += 2;
			}

			chr = s[i]; //nuovo carattere
			cnt = 1;
		}
	}

	// ridimensiona per un uso ottimale dello spazio
	// ns_i <= s_len
	ns = (char*) realloc(ns, sizeof(char) * (ns_i + 1));
	if(ns == NULL)
		return NULL;

	ns[ns_i] = 0; //aggiungi il terminatore

	return ns;
}

int main() {
	char* rle = comprimi("");

	if(rle != NULL)
		printf("%s\n", rle);

	free(rle);
	return 0;
}

