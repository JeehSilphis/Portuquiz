# Portuquiz — Geek Quiz em Portugol

Jogo de perguntas e respostas escrito em **Portugol**, feito no [Portugol Studio](https://univali-lite.github.io/Portugol-Studio/).
O jogador escolhe um tema, define quantas perguntas quer responder e, no fim, vê a revisão de cada resposta
com o total de acertos e erros.

## Como jogar

1. Abra o jogo: aparece a tela inicial com a imagem do quiz e a música de fundo.
2. Pressione **ENTER** para começar ou **ESC** para sair.
3. Escolha um dos temas pelo número.
4. Informe quantas perguntas quer responder (**de 5 a 10**).
5. Responda cada pergunta digitando a alternativa (**1 a 4**).
6. No final, o jogo mostra:
   - a revisão de todas as perguntas, com a resposta correta e a sua resposta;
   - se você acertou ou errou cada uma;
   - as estatísticas: total de perguntas, acertos e erros.
7. Depois de alguns segundos, o jogo volta para a tela inicial.

As perguntas são **sorteadas sem repetição** dentro do tema escolhido, então cada partida é diferente.

## Temas

São 90 perguntas, 10 em cada tema:

| | | |
|---|---|---|
| Televisão Brasileira | Videogames | Música |
| Cinema | Animes | Automobilismo |
| Ciência | Computadores | História da Arte |

## Como executar

1. Instale o **Portugol Studio**.
2. Baixe este repositório (botão **Code → Download ZIP**) e extraia a pasta.
3. Abra o arquivo `prova_portugol_quiz.por` no Portugol Studio.
4. Clique em **Executar**.

Os arquivos `quiz.txt`, `moeda.jpeg` e o arquivo de música precisam ficar **na mesma pasta** do `.por`,
porque o programa os procura ali.

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| `prova_portugol_quiz.por` | Código do jogo |
| `quiz.txt` | Banco de perguntas |
| `moeda.jpeg` | Imagem da tela inicial |
| `mario.mp3` | Música de fundo |

## Como adicionar perguntas

Cada linha do `quiz.txt` é uma pergunta, com os campos separados por `|`:

```
pergunta|tema|número da alternativa correta|alternativa 1|alternativa 2|alternativa 3|alternativa 4
```

Exemplo:

```
Qual é o nome do mascote da Sega?|Videogames|2|Alex Kidd|Sonic|Tails|Knuckles
```

Um tema novo é criado automaticamente quando aparece pela primeira vez no arquivo.
O jogo aceita até 100 perguntas e 10 temas.

## Conceitos de programação utilizados

- Vetores e matrizes para guardar perguntas, temas, alternativas e respostas
- Leitura de arquivo de texto e separação dos campos pelo caractere `|`
- Funções, laços de repetição (`enquanto`, `para`, `faca...enquanto`) e validação das entradas
- Sorteio sem repetição de itens
- Bibliotecas do Portugol Studio: `Arquivos`, `Texto`, `Tipos`, `Util`, `Sons`, `Teclado` e `Graficos`

## Autoria

Desenvolvido por [Jéssica Soares](https://github.com/JeehSilphis).
