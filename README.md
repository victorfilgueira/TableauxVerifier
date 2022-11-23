# TableauxVerifier

Trabalho Linguagens de Programação 2022.2

Gabriel Brandão & Victor Filgueira

No arquivo "main.hs" insira uma fórmula válida na linha 66 conforme indicado abaixo:

* A fórmula deve estar em um padrão F(x)op(y), onde 'F' é o primeiro valor que nega a fórmula, 
'x' e 'y' são os termos da fórmula, que por sua vez são compostos por 'avb' ou 'a^b' ou 'a>b', por exemplo
E 'op' é o operador principal da fórmula

Exs: 
- F(avb)v(bva)
- F(a>b)>(b>a)
- F(b^a)>(avb)
- F(bva)^(b^a)

Agora, para executar o código existem 2 maneiras:

 - No terminal do seu SO (testado em Windows Powershell com ghci instalado. Caso não possua, instale por este link 
 https://www.haskell.org/downloads/)
 
  Digite "ghc --make main.hs"

  Em seguida, digite quando acabar de processar, digite "./main" para executar o código

  Aperte "Enter"

  O terminal colocará na tela a árvore feita e dirá se existe contradição ou não
  
  - Ou, no terminal do seu SO, digite ghci
  
  Em seguida compile o código com ":l main"
  
  E digite "bar" para chamar a função principal
  
  Esta função colocará na tela a árvore feita e dirá se existe contradição ou não
