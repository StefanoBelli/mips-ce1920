# Calcolo indirizzi branching e jumps

Prima cosa da considerare: dipende da come viene posto il problema.

Si richiede infatti il calcolo:

* Dopo la fase di linking
* In fase d'esecuzione

## Branching

In mips per istruzioni che effettuano branching si intendono istruzioni `beq` e `bne` formato I:

```
+------+-----+-----+----------------+
|opcode| rs  | rt  | imm            |
+------+-----+-----+----------------+
31                                  0
```

il salto può essere effettuato solo a indirizzi distanti max. 16 bit dalla posizione delle istruzioni

## Jumps

In mips per istruzioni che effettuano jumps si intendono istruzioni: `j` e `jal`

 * `j` salta incondizionata
 * `jal` salta incondizionata e modifica `$ra`

Entrambe le istruzioni usano il formato J:

```
+------+--------------------------+
|opcode| imm                      |
+------+--------------------------+
31                                0
```

In questo caso il salto può essere effettuato fino a 26 bit. (Un indirizzo a 32 bit non c'entra)

#### Salto a indirizzo a 32 bit
Se si vuole effettuare un salto a 32 bit si deve usare `jr` (formato istruzione R)

```
+------+-----+-----+-----+-----+-----+
|opcode| rs  | rt  | rd  |shamt|funct|
+------+-----+-----+-----+-----+-----+
31                                   0
```


# Dopo la fase di linking

Se il problema viene posto dopo la fase di linking (collegamento):

* Nel caso di una branch, bisogna contare la destinazione 
		a partire dall'istruzione successiva a essa
		e dire quindi quale valore andrà a finire nel campo immediate.

Esempio:

```asm
	A: istr
	B: istr
	C: beq $t0, $0, F
	D: istr # 0
	E: istr # 1
	F: istr # 2
	G: istr

	Se voglio saltare all'istruzione F, quale sarà il campo immediate di BEQ?
	Risposta: 2
```

In questo caso le istruzioni di branching sono indipendenti dalla posizione del programma in memoria.

Dipendono dalla distanza dell'istruzione alla destinazione del salto.

*NON VENGONO MAI RILOCATE*

* Nel caso di una jump, bisogna assumere che il programma venga caricato a partire da 0:

```asm
	istr 		# 0x0
	jal main 	# 0x4
	istr 		# 0x8
	main: istr 	# 0xC

	determinare il campo imm di jal main dopo il linking
```

quindi contare di 4 l'avanzare delle istruzioni.

Il testo poi specifica che il modulo viene posizionato in memoria a partire da 0x00400D00, è quindi 
sufficiente sommare la posizione delle istruzioni contate da 0 a 0x00400D00

```asm
	istr 		# 0x00400D00 (inizio)
	jal main	# 0x00400D04 ----
	istr 		# 0x00400D08    |
	main: istr 	# 0x00400D0C <---

	main = 0x00400D0C

	RISPOSTA: jal 0x00400D0C, dopo la fase di collegamento nel campo immediate di jal c'è il valore 0x00400D0C
```


# In esecuzione

* Branch
per il calcolo dell'indirizzo assoluto:
	
```
	b(pc, imm) = (pc + 4) + sign_extend(imm << 2)
```

* Nel testo viene data come minimo la posizione in memoria del programma, è sufficiente calcolarsi il 		valore di pc all'istruzione di branch e applicare quella formula.

* `sign_extend` serve a estendere `imm << 2` a 32 bit. Se il numero è positivo si riempono i rimanenti 		14 bit di 0, altrimenti di 1.

* Jumps
per il calcolo dell'indirizzo assoluto:

* bisogna calcolare `pc + 4` (sempre per la posizione dell'istruzione di jump)

* estrarre i primi 4 bit di `pc + 4` (dalla *MSB*)

* prendere l'immediato a 26 bit dell'istruzione e shiftarlo a sinistra di 2 bit (equivalente a molt. per 4)

* da 26 bit abbiamo ottenuto un indirizzo a 28 bit, quindi:

* aggiungere i 4 bit di `pc + 4` ai 28 bit, per formarne 32.

```
		pc + 4 = 1100 0011 0011 0000 0000 1100 0001 1000
		addr = 0000 1111 1010 0101 0000 0101 1111

		 * addr << 2: 0011 1110 1001 0100 0001 0111 1100

		 * estrai i primi 4 bit di pc+4: 1100
		 
		 * aggiungili all'inizio (sinistra) di addr << 2: 1100 0011 1110 1001 0100 0001 0111 1100

		 l'indirizzo ottenuto è di 32 bit
```

Implementazione:
		```
		j(pc, imm) = (pc + 4) & 0xF0000000 | (imm << 2)
		```
