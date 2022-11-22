# TableauxVerifier

Trabalho Linguagens de Programação 2022.2

Gabriel Brandão & Victor Filgueira

Para executar o código:

Inserir a fórmula que deseja na linha 74 do arquivo "main.hs". 

* A fórmula deve estar em um padrão F(x)op(y), onde 'F' é o primeiro valor que nega a fórmula, 
'x' e 'y' são os termos da fórmula, que por sua vez são compostos por 'avb' ou 'a^b' ou 'a>b', por exemplo. 
E 'op' é o operador principal da fórmula.

Exs: 
- F(avb)v(bva)
- F(a>b)>(b>a)
- F(b^a)>(avb)
- F(bva)^(b^a)


A seguir digite no terminal: ghci

Digite então: :l main.hs para compilar o arquivo.

agora basta chamar a função principal digitando "bar".

O ghci colocará na tela a árvore feita e dirá se existe contradição ou não.
