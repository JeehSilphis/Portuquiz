programa {
    
    //bilbiotecas utilizadas
    inclua biblioteca Util --> u
    inclua biblioteca Arquivos --> a
    inclua biblioteca Texto --> t
    inclua biblioteca Tipos --> p
    inclua biblioteca Sons --> s
    inclua biblioteca Teclado --> tc
    inclua biblioteca Graficos --> g
    
    // Estruturas para armazenar as perguntas
    cadeia perguntas[100]
    cadeia temas[100]
    inteiro respostas_corretas[100]
    cadeia alternativas[100][4]
    
    // Controle de temas únicos
    cadeia temas_unicos[10]
    inteiro contador_temas = 0
    inteiro total_perguntas = 0
    
    // Controle do jogo
    inteiro perguntas_selecionadas[100]
    inteiro respostas_usuario[100]
    inteiro quantidade_jogo = 0
    
    //Variáveis para mostrar a imagem inicial
    inteiro imagem = g.carregar_imagem("moeda.jpeg")
    logico mostrar_imagem = verdadeiro
   
    funcao inicio() {
        musica_fundo()//chama música tema
        carregar_perguntas()//carrega quiz
        desenhar()}//carrega imagem inicial
        
    //função que cria a imagem do inicio
    funcao desenhar(){
        g.iniciar_modo_grafico(verdadeiro)
        g.definir_dimensoes_janela(1600, 900)
        g.definir_titulo_janela("Quiz - Pressione ENTER para jogar ou ESC para sair")
	        enquanto(mostrar_imagem){
	            // Limpa a tela
	           g.definir_cor(g.COR_BRANCO)
	           g.limpar()	            
	            // Desenha a imagem
	           g.desenhar_imagem(0, 0, imagem)	            
	            	   // Verifica as teclas
		          se (tc.tecla_pressionada(tc.TECLA_ENTER)) {
			        	mostrar_imagem = verdadeiro
					g.encerrar_modo_grafico()
			          iniciar_jogo()}		            
		          se (tc.tecla_pressionada(tc.TECLA_ESC)) {
		              	mostrar_imagem = falso
		              	sair_do_jogo()}	            	            
	           //cria a imagem
	           g.renderizar()}}        
   
    //função para encerrar o jogo caso o usuario tecle ESC
    funcao sair_do_jogo(){
        escreva("\n\nEncerrando o programa, Até logo...\n")
        g.fechar_janela() }
   
    //função para trazer a trilha sonora de fundo
    funcao musica_fundo() {
        cadeia arquivo_musica = "./mario.mp3"
        se(a.arquivo_existe(arquivo_musica)) {
            inteiro mmmusica = s.carregar_som(arquivo_musica)
            s.definir_volume(50)
            s.reproduzir_som(mmmusica, verdadeiro)}}      
    
    // Função para carregar perguntas do arquivo QUIZ.TXT
    funcao logico carregar_perguntas() {
        cadeia nome_arquivo = "quiz.txt"
        inteiro arquivo        
        // Inicializa contadores
        total_perguntas = 0
        contador_temas = 0        
             //procura e abre o arquivo com as perguntas
	        se(a.arquivo_existe(nome_arquivo)) {
	            arquivo = a.abrir_arquivo(nome_arquivo, a.MODO_LEITURA)            
	            enquanto(nao a.fim_arquivo(arquivo) e total_perguntas < 100) {
	                cadeia linha = a.ler_linha(arquivo)                
	                // Ignora linhas vazias
	                se(linha != "") {
	                    processar_linha(linha)} }             
		            //se encontrar o arquivo
		           a.fechar_arquivo(arquivo)
		           retorne verdadeiro}
	        //se não encontrar o arquivo
	        senao {
	            escreva("Arquivo QUIZ.TXT não encontrado!\n")
	            retorne falso}}       
	       
    // Processa uma linha do arquivo
    funcao processar_linha(cadeia linha) {
        cadeia partes[7]
        inteiro num_partes = dividir_por_pipe(linha, partes)       
	        se(num_partes >= 7) {
	            perguntas[total_perguntas] = partes[0]//atribui a pergunta ao vetor 0
	            temas[total_perguntas] = partes[1]//atribui o tema ao vetor 1
	            respostas_corretas[total_perguntas] = p.cadeia_para_inteiro(partes[2], 10)//converte a resposta para numero inteiro            
	            para(inteiro i = 0; i < 4; i++) {
	                alternativas[total_perguntas][i] = partes[3 + i]} //atribui as alternativas aos vetores 3,4,5,6           
			      adicionar_tema_unico(partes[1])
			      total_perguntas++}}        
    
    //encontra o texto entre os pipes e extrai para os vetores
    funcao inteiro dividir_por_pipe(cadeia texto, cadeia partes[]) {
        inteiro contador = 0
        inteiro inicio_1 = 0
        inteiro tamanho = t.numero_caracteres(texto)       
	        para(inteiro i = 0; i <= tamanho e contador < 7; i++) {
	        		//encontra o Pipe no texto
	            se(i == tamanho ou t.obter_caracter(texto, i) == '|') {
	                se(i > inicio_1) {
	                	//extrai o texto entre pipes
	                    partes[contador] = t.extrair_subtexto(texto, inicio_1, i)
	                    //remove espaços 
	                    partes[contador] = remover_espacos(partes[contador])}
	                 senao {
		                partes[contador] = ""}
		                
			           contador++
			           inicio_1 = i + 1}}            	        	
	          retorne contador}
    
    //remove os espaços entre as questões e o pipe
   funcao cadeia remover_espacos(cadeia texto) {
        inteiro inicio_2 = 0
        inteiro fim = t.numero_caracteres(texto) - 1       
	        enquanto(inicio_2 <= fim e t.obter_caracter(texto, inicio_2) == ' ') {
	            inicio_2++}	               
	        enquanto(fim >= inicio_2 e t.obter_caracter(texto, fim) == ' ') {
	            fim--}	                
	        se(inicio_2 <= fim) {
	            retorne t.extrair_subtexto(texto, inicio_2, fim + 1)}
	        senao {
	            retorne ""}}
    
	//conta quantos temas tem e exibe ao usuário 
    funcao adicionar_tema_unico(cadeia tema) {
        logico existe = falso        
	        para(inteiro i = 0; i < contador_temas; i++) {
	            se(t.caixa_alta(temas_unicos[i]) == t.caixa_alta(tema)) {
	                existe = verdadeiro
	                pare }}	                    
		        se(nao existe e contador_temas < 10) {
		            temas_unicos[contador_temas] = tema
		            contador_temas++}}
	   
    //conta quantidades de perguntas
    funcao inteiro contar_perguntas_tema(cadeia tema) {
        inteiro count = 0
	        para(inteiro i = 0; i < total_perguntas; i++) {
	            se(t.caixa_alta(temas[i]) == t.caixa_alta(tema)) {
	                count++}}	 
	        		retorne count}
    
   //função para sortear as perguntas
	funcao selecionar_perguntas_aleatorias(cadeia tema, inteiro quantidade) {
		    inteiro indices_tema[100]
		    inteiro count_tema = 0		    
		    // Coleta todos os índices das perguntas do tema especificado
			    para(inteiro i = 0; i < total_perguntas; i++) {
			        	se(t.caixa_alta(temas[i]) == t.caixa_alta(tema)) {
			            indices_tema[count_tema] = i
			            count_tema++} }		
				    	// Verifica se encontrou perguntas do tema
				    	se(count_tema == 0) {
				        quantidade_jogo = 0
				        retorne}		    		
					    // Verifica se há perguntas suficientes do tema
					se(quantidade > count_tema) {
					        escreva("Aviso: Solicitadas ", quantidade, " perguntas, mas só há ", count_tema, " disponíveis.\n")
					        quantidade = count_tema}		    		
				    		   quantidade_jogo = quantidade		    
				    	// Sorteia perguntas sem repetição
			    para(inteiro i = 0; i < quantidade; i++) {
				     se(count_tema > 0) {
				         inteiro indice_aleatorio
				     se(count_tema == 1) {
				         indice_aleatorio = 0}
				     senao {
				         indice_aleatorio = u.sorteia(0, count_tema - 1)}		            
				         perguntas_selecionadas[i] = indices_tema[indice_aleatorio]		            
				// Remove o índice sorteado
			    para(inteiro j = indice_aleatorio; j < count_tema - 1; j++) {
				    indices_tema[j] = indices_tema[j + 1]}		            		           
				    count_tema-- }}}

    //inicia o quiz
    funcao executar_quiz() {
        escreva("\n=============================================================== INICIANDO QUIZ ================================================================\n")        
        para(inteiro i = 0; i < quantidade_jogo; i++) {
            inteiro indice = perguntas_selecionadas[i]           
	            //escreve a pergunta sorteada de acordo com a quantidade de perguntas escolhidas pelo usuário
	            escreva("\n\n---------------- Pergunta " + (i+1) + "/" + quantidade_jogo + " ----------------\n")
	            escreva(perguntas[indice] + "\n\n")	
	   //exibe as alternativas ao usuário            
	   para(inteiro j = 0; j < 4; j++) {
	            escreva((j+1) + ". " + alternativas[indice][j] + "\n")}	                       
	       //solicita ao usuário a resposta
	       inteiro resposta
		       escreva("\nSua resposta (1-4): ")
		       leia(resposta)
	            //se resposta menor que 1 ou maior que 4
	       se(resposta < 1 ou resposta > 4) {
	           escreva("Resposta inválida! Considerando como erro.\n")
	           resposta = 0}                       
                respostas_usuario[i] = resposta}}
           		           
    //mostra o resultado final
    funcao mostrar_resultado_final(cadeia tema) {
        inteiro acertos = 0
        inteiro erros = 0       
        escreva("\n=============================================================== RESULTADO FINAL ===============================================================\n")
        escreva("Tema: " + tema + "\n")
        escreva("Quantidade de perguntas: " + quantidade_jogo + "\n\n")        
        escreva("============================================================= REVISÃO DAS PERGUNTAS ===========================================================\n")       
	        para(inteiro i = 0; i < quantidade_jogo; i++) {
	            inteiro indice = perguntas_selecionadas[i]           
	            escreva("\n---------------- Pergunta " + (i+1) + " ----------------\n")
	            escreva(perguntas[indice] + "\n")          
	            para(inteiro j = 0; j < 4; j++) {
		                escreva((j+1) + ". " + alternativas[indice][j])
		                 //mostra resposta correta
		                se(j+1 == respostas_corretas[indice]) {
		                    escreva(" ← RESPOSTA CORRETA ✓✓ ☻ ☻ ")}	                
		                //mostra resposta do usuário
		                se(j+1 == respostas_usuario[i]) {
		                    escreva(" ← SUA RESPOSTA")}	                
		                escreva("\n")}            
		            //se resposta certa
	            se(respostas_usuario[i] == respostas_corretas[indice]) {
	                escreva("\n ✓✓ ACERTOU!\n")
	                acertos++}             
	            //se resposta errada
	            senao {
	                escreva("\n ✗✗ ERROU!\n")
	                erros++} }                 
	        //mostra o total de erros e acertos
	        escreva("\n================================================================ ESTATÍSTICAS =================================================================\n")
	        escreva("Total de perguntas: " + quantidade_jogo + "\n")
	        escreva("Acertos: " + acertos + "\n")
	        escreva("Erros: " + erros + "\n")}  
	         
	//função que carrega o quiz        
	funcao iniciar_jogo() {        
		inteiro tema_escolhido, quantidade
		cadeia tema_selecionado
		inteiro perguntas_disponiveis	    
		    faca {
		        escreva("\n================================================================== GEEK QUIZ ==================================================================\n\n")		        
		        // Seleção do tema
		        faca {
		            escreva("\nEscolha um tema:\n\n")
		            para(inteiro i = 0; i < contador_temas; i++) {
		                inteiro count = contar_perguntas_tema(temas_unicos[i])
		                escreva((i+1) + ". " + temas_unicos[i] + " (" + count + " perguntas)\n")}	        
			            escreva("\nDigite o número do tema: ")
			            leia(tema_escolhido)		            
		            se(tema_escolhido < 1 ou tema_escolhido > contador_temas) {
		                escreva("\nTema inválido! Tente novamente.\n")}}		            
		        enquanto(tema_escolhido < 1 ou tema_escolhido > contador_temas)		        
		        tema_selecionado = temas_unicos[tema_escolhido - 1]
		        perguntas_disponiveis = contar_perguntas_tema(tema_selecionado)		        
		        // Seleção da quantidade
		    escreva("\nTema selecionado: " + tema_selecionado + "\n")
		    escreva("Perguntas disponíveis: " + perguntas_disponiveis + "\n")		        
		        // Calcula o máximo permitido
			        inteiro maximo
			        se(perguntas_disponiveis < 10) {
			            maximo = perguntas_disponiveis}
			        senao {
				        maximo = 10}		  
					   escreva("Digite a quantidade de perguntas (5 a " + maximo + "): ")
					   leia(quantidade)		        
				        //se escolher menos que 5 alternativas, alerta ao usuário e retorna ao laço
				        se(quantidade < 5) {
					        escreva("Quantidade mínima é 5 perguntas!\n") 
					        limpa()}
				        //se escolher mais que 10 alternativas, alerta ao usuário e retorna ao laço
				        senao se(quantidade > perguntas_disponiveis) {
				     	   escreva("Quantidade máxima para este tema é " + perguntas_disponiveis + " perguntas!\n")}}		        
			     enquanto(quantidade < 5 ou quantidade > 10 ou quantidade > perguntas_disponiveis)			    			    
			// Executa o jogo
			selecionar_perguntas_aleatorias(tema_selecionado, quantidade)
			executar_quiz()
			//mostra os resultados
			mostrar_resultado_final(tema_selecionado)
			u.aguarde(9000)
			desenhar()}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 13678; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */