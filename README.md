# master_mind
Preciso criar uma funcao que decode o codigo o codigo do mastermind,
de forma que para cada acerto exato (posicao e cor) me retorne um numero,
depois continue procurando para saber se tem mais acertos e retornar outro
numero.

A minha ideia inicial era usar dois loops each with index, dentro do
segundo loop, fazer uma verificacao se o numero com o indice corresponde a outro numero com indice. Guardar qual a posicao que a ultima correspondencia aconteceu, depois fazer uma segunda verificacao a com a 
array, usar any? para saber se cada numero individual existe na array, para cada sim, adicionamos uma correcao parcial.

A segunda ideia consiste em usar apenas um loop each with index (ou map)
para verificar se cada cada player_code possui uma corresondencia em opponent_code, depois remover os indices que nao existem. Usar o length do novo array para saber da onde comecar  a proxima verificacao.

Com o array  que me da os acertos exatos, gravo o tamanho da array. Com o tamanho da array, pegamos o player_guess e removemos o numero de indices indicados pelo tamanho, depois utilizamos
outro map with index para perguntar se any? numero esta presente. Caso esteja mando uma informacao correspondente pra casa do array, caso nao esteja, pula. Ao final teremos um codigo com a representacao (2) para acertos completos e (1) parciais.

Como o jogo so acaba com todos os acertos, a verificacao se o jogo acabou deve ser uma simples comparacao se todos os numeros batem. Tentando criar uma funcao ou classe para distinguir.