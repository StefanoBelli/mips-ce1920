# Preserve dei registri
===
### Procedura chiamante
===

  * preserva i seguenti registri, se vuole:
   * `$a0`-`$a3`
   * `$t0`-`$t7`
   * `$v0` e `$v1`
  * passa gli argomenti a partire dal registro `$a0`-`$a3`, ulteriori arg. pushati sullo stack
  * effettua una jump and link: `$ra` viene *modificato*
  
  
### Procedura chiamata
===

  * preserva i seguenti registri (se necessario):
   * `$ra`
   * `$fp`
   * `$s0` - `$s7`

# Uso dello stack
===

Quando un registro viene preservato e/o si vuole pushare un valore sullo stack, è necessario riservare spazio,
sottraendo dallo stack pointer il numero di byte desiderato, e poi usare store word

Alla fine di ogni procedura lo stack pointer deve essere ripristinato a come era esattamente dopo la jump and link


   
   
