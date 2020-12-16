.macro DesenharFundo()
	li a2,0xFF200604	# frame 1 selecionado
	li a0, 1
	sw a0,0(a2)
	li a0,0xc7    #limpagem de tela pra renderizar telinha
	li a7,148
	li a1,1
	ecall	
	li a1,0xFF000000	
	li a2,0xFF012C00	
	la a0, Fundos   #carrega array
	lw a0, (a0) #a0 = endereco do array de fundos
	la a3, Fundo   #carrega contador
	lw a4,(a3)  #A4 = contador
	add a0, a0, a4 #a0 = endereco do endere�o fundo a ser renderizado
	lw a0,(a0) #a0 = endere�o do fundo
	addi a0,a0,8	#pula os bytes que indicam o tamanho da imagem
Loop.Fundos: beq a1,a2,Fora.Fundos
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j Loop.Fundos			
Fora.Fundos: 
	addi a4,a4,4 #Selecionar o pr�ximo fundo
	li t0, 12 
	rem a4, a4, t0 #Se passar do �ltimo fundo, voltar para o primeiro
	sw a4, (a3) #Escrever o fundo atual na mem�ria
	
	li a2,0xFF200604	# frame 0 selecionado
	sw zero,0(a2)
.end_macro

.macro TelaInicial()
	li s0,0xFF200604	
	li a0, 1
	sw a0,0(s0)
	li t1,0xFF000000	
	li t2,0xFF012C00	
	la s1,abertura		
	addi s1,s1,8		
LOOP1: 	beq t1,t2,FORA1
	lw t3,0(s1)		
	sw t3,0(t1)		
	addi t1,t1,4		
	addi s1,s1,4
	j LOOP1			
FORA1:	la a0,Aperte      #texto de apertar 1 
	li a1, 140
	li a2, 220
	li a3, 0xFF00
	li a4, 0
	li a7, 104
	ecall
	sw zero,0(s0)
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
	#parte da música
	la s0,Numnotas
	lw s1,0(s0)
	la s0,Notas		# define o endereço das notas
	li a2,1			# instrumento
	li a3,127		# volume
	li s2,0			#contador da nota
LOOP2:  blt  s2,s1,RESETM	#reseta musica
	li s2,0
	la s0,Notas
RESETM:	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall	
	li s3, 2000
	bgt a1,s3,ACORDE
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
ACORDE:	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi s2,s2,1
	#terimna parte da musica
	li t1,0xFF200000
	lw t0,0(t1)			
   	andi t0,t0,0x0001		
   	beq t0,zero,LOOP2		
   	lw t2,4(t1)			
   	li a0,49
   	bne t2,a0,LOOP2
.end_macro 

.macro PlayMusic(%Musica)
	li a7, 30
	ecall #a0 = Tempo atual
	la a5, TempoMusica

	lw a5, (a5) #a5 = Tempo de inicio da pr�xima nota
	blt a0, a5, Skip #Checa se j� � hora de tocar a nota

	la a4, NotaAtual
	lw a4, (a4) #a4 = nota atual * 8

	add %Musica, %Musica, a4 #%Musica = endere�o na nota a ser tocada
	lw a0, 0(%Musica) #a0 = nota a ser tocada
	lw a1, 4(%Musica) #a1 = tempo da nota a ser tocada
	
	bge a1, zero, NotNegative #Checa se a dura��o da nota � negativa, ou seja, a musica acabou
	la a4, NotaAtual
	sw zero, (a4) #Zerar Nota atual (Recomeca a musica)
	j Skip
NotNegative: 
	beq a0, zero, Pause #Checa se � uma pausa
	li a2, 1 #Seleciona o instrumento 1
	li a3, 100 #Volume m�ximo
	li a7, 31 #sys call de midi
	ecall
Pause:  mv t4, a1
	li a7, 30
	ecall
	la a3, TempoMusica
	add a0, a0, t4
	addi a0, a0, 50
	sw a0, (a3) #Atualizar Tempo Musica
	la a3, NotaAtual
	addi a4, a4, 8
	sw a4, (a3) #Adicionar 8 a Nota Atual
Skip:	
.end_macro

.macro Input() 
	li t1, 0xFF200000		# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo��o volta ao loop
   	beq zero, t0, SkipReading
   	la t2, Input
   	lw a0,4(t1)			# a0 = valor da tecla
   	li t0, 'd'
   	bne a0, t0, Skip1
   	li t0, 0
   	sw t0, (t2)
   	j SkipReading
Skip1: 	li t0, 'e'
   	bne a0, t0, Skip2
   	li t0, 4
   	sw t0, (t2)
   	j SkipReading
Skip2:   li t0, 'w'
   	bne a0, t0, Skip3
   	li t0, 8
   	sw t0, (t2)
   	j SkipReading
Skip3: 	li t0, 'q'
   	bne a0, t0, Skip4
   	li t0, 12
   	sw t0, (t2)
   	j SkipReading
Skip4:   li t0, 'a'
   	bne a0, t0, Skip5
   	li t0, 16
   	sw t0, (t2)
   	j SkipReading
Skip5: 	li t0, 'z'
   	bne a0, t0, Skip6
   	li t0, 20
   	sw t0, (t2)
   	j SkipReading
Skip6:   li t0, 'x'
   	bne a0, t0, Skip7
   	li t0, 24
   	sw t0, (t2)
   	j SkipReading
Skip7: 	li t0, 'c'
   	bne a0, t0, Skip8
   	li t0, 28
   	sw t0, (t2)
   	j SkipReading
Skip8:   li t0, 'f'
   	bne a0, t0, SkipReading
   	li t0, 32
   	sw t0, 4(t2)
SkipReading:
.end_macro
	
	
.macro Processamento()
.text	#Seletor de animacao
	la t2, Player
	lw t0, 16(t2) #t0 = frame atual 
	lw t1, 24(t2) #t1 = Tamanho da anima��o atual
	blt t0, t1, Skip1 #Se a anima��o n�o tiver terminado pule
	sw zero, 16(t2) #Zera o contador (frame atual)
Skip1:	
	la t2, Enemy
	lw t0, 16(t2) #t0 = frame atual
	lw t1, 24(t2) #t1 = Tamanho da anima��o atual
	blt t0, t1, Skip2 #Se a anima��o n�o tiver terminado pule
	sw zero, 16(t2) #Zera o contador (frame atual)
Skip2:	
					
	
	#Pegar input salvo na mem�ria
	la t1, Input
	lw t0, (t1) #armazenar valor do input
	li t3, 64
	sw t3, (t1) #zerar input
	sw zero, 4(t1)
	bne t0, zero, SkipPoint #Checar se o input eh 'd'
	la t1, PontuacaoPlayer
	lw t2, (t1) #Ler Pontuacao Player
	addi t2, t2, 1 #Adicionar 1
	sw t2, (t1) #Salvar pontuacao nova Player
	j ForaGameLoop
SkipPoint:
.end_macro


#Recebe %obj=Objeto, %array=array de animacoes do objeto
.macro LimparFrame(%obj, %array)
	lw a1, 20(%obj) #a1 = animacao atual
	li a2, 8
	mul a1, a1, a2 #a1 = a1*8
	add a1, a1, %array #a1 = endere�o do endereco da animacao atual
	lw a1, 0(a1) #a1 = endere�o da anima��o (Array de frames)
	li a2, 12
	lw a3, 16(%obj) #a3 = numero do frame atual
	mul a2, a2, a3
	addi a3, a3, 1 #Adicionar 1 ao frame
	sw a3, 16(%obj) #Salvar o novo numero de frames na memoria
	add a1, a1, a2 #a1=endereco do frame atual
	mv t1, a1
	#Alterar X0 e Y0
.end_macro
	
.macro TelaFinal()
.end_macro


# Macro de limpar // Recebe %X - Tamanho X pra apagar, %Y - Tamanho Y pra apagar, %Z - Endereco do pixel 0
.macro Limpar(%X %Y %Z)
	mv a0 %X
	mv a1 %Y
	mv a2 %Z
	mv a3 zero
	li a4 0xc7c7c7c7
	beqz a1 Fora
LoopX:	beq a3 a0 LoopY
	sw a4 0(a2)
	addi a3 a3 4
	addi a2 a2 4
	j LoopX
LoopY:	addi a1 a1 -1
	mv a3 zero
	beqz a1 Fora
	sub a2 a2 a0
	addi a2 a2 320
	j LoopX
Fora:
.end_macro


# Macro de desenhar imagem // Recebe %Z - Endereco do pixel 0, %Img - Imagem a desenhar
.macro Desenhar(%Z %Img)
	mv a4 zero
	mv a3 %Z
	lw a0 0(%Img)
	lw a1 4(%Img)
	addi a2 %Img 8
LoopX:	beq a4 a0 LoopY
	lw a5 0(a2)
	sw a5 0(a3)
	addi a4 a4 4
	addi a2 a2 4
	addi a3 a3 4
	j LoopX
LoopY:	addi a1 a1 -1
	mv a4 zero
	beqz a1 Fora
	sub a3 a3 a0
	addi a3 a3 320
	j LoopX
Fora:
.end_macro


# Macro de renderizar // Recebe %Obj - Endereco do obj. na memoria, %Anim - Endereco da animacao na memoria
.macro Render(%Obj %Anim) #(dX = t4, dY = t5, P0 = a6, S0 = a7, S1 = t6)
	lw t4 0(%Anim) # dX
	lw t5 4(%Anim) # dY
	lw a6 8(%Obj) # P0
	lw a7 12(%Obj) # S0
	lw t6 8(%Anim) # S1
	# Retangulo Vermelho
	mv a2 a6
	bltz t4 XMenorR
	lw a0 0(a7)
	sub a0 a0 t4
	add a2 a2 t4
	j FimRX
XMenorR:lw a0 0(t6)
	add a0 a0 t4
FimRX:	bltz t5 YMenorR
	mv a1 t5
	j FimRY
YMenorR:lw a1 4(a7)
	lw a3 4(t6)
	add a3 a3 t5
	sub a1 a1 a3
	li a4 320
	mul a3 a3 a4
	add a2 a2 a3
FimRY:	Limpar(a0 a1 a2)
	# Retangulo Azul
	mv a3 a6
	lw a2 4(a7)
	bltz t4 XMenorB
	mv a1 t4
	j FimB
XMenorB:lw a1 0(a7)
	sub a1 a1 a0
	add a3 a3 a0
FimB:	Limpar(a1 a2 a3)
	# Desenhar proxima sprite
	li a0 320
	mul a1 t5 a0
	add a1 a1 t4
	add a1 a1 a6
	sw a1 8(%Obj) # Atualiza a posicao do obj. na memoria
	sw t6 12(%Obj) # Atualiza a imagem do obj. na memoria
.end_macro


.macro IA()    # IAinimigo -flag- aproximar, afastar, ataque alto, ataque baixo , defesa  , Distancias de aproximar devem ser testadas depois
	la a0, Player
	lw a1, 0(a0)  #x0 do player
	la a0, Enemy
	lw a2, 0(a0)  #x0 do inimigo
	la a0, Fase    #contador da fase/dificuldade
	lw a0, (a0)
	la a4, IAinimigo
	li a3,1
	beq a0,a3,D2
	li a1,2
	beq a0,a3,D3	 
	
	#D1  		IA 1 - Se aproxima até 80, se afasta a partir de 50 ,sempre ataca alto entre as duas distancias
	sub a3,a2,a1
	li a0,80      	#80 de distãncia, número arbitrário, tamanho médio de sprite = 40
	ble a3,a0,PertoD1
	sw zero,(a4)    #se aproxima caso esteja mais que isso
	j Dfim 
PertoD1:li a0,50
	ble a3,a0,AfastarD1
	li a0 ,3  #ataque alto 
	sw a0,(a4)
	j Dfim 
AfastarD1:li a0, 1
	sw a0, (a4)  #se afasta
	j Dfim
	
	#D2 		IA 2 - Se aproxima até 60 , se afasta a partir de 45, ataca alto e baixo randomicamente entre as duas distancias
D2:	li a0,60
	ble a3,a0,PertoD2
	sw zero,(a4)
	j Dfim
PertoD2:li a0,45
	ble a3,a0,AfastarD2    
	li a7,40   #seta nvoa seed randômica
	ecall 
	li a1,1
	li a7,42
	ecall   #rola int random de 0 a 1
	addi a0,a0, 2  # adiciona 2 pra transformar em ataque / alto(3) ou ou baixo (4)
	sw a0,(a4)
	j Dfim
AfastarD2:li a0, 1
	sw a0, (a4)  #se afasta
	j Dfim
	
	#D3  		IA 3- Se aproxima até 35~40?(testar), não se afasta,defende, ataca alto ou baixo  dependendo da Vulnerabilidade do player
D3:	li a0, 40
	ble a0,a3,PertoD3
	sw zero,(a4)
	j Dfim
PertoD3:la a1,VulnPlayer  #checa a vulnerabilidade
	lw a1, 0(a1)
	beqz a1, Alto      #nenhuma defesa,ataca alto
	li a2, 1	
	beq a1, a2,Baixo   #defesa em cima, ataca em baixo
	li a0,5 	   #ivunerável, defende	
	sw a0, (a4)
	j Dfim
Baixo:	li a0, 3
	sw a0, (a4)
	j Dfim
Alto:	li a0, 4
	sw a0, (a4)
	j Dfim
Dfim:
.end_macro

.macro Pontos()
	li a7,101
	li a1, 60
	li a2, 40
	li a3, 0xc700
	li a4, 1
	la a0, Score
	lw a0, (a0)
	ecall
	la a1, HighScore
	lw a2, (a1)
	blt a0,a1,Menos
	sw a0, (a1)
Menos:  la a0,PontuacaoPlayer  #jogador
	lw a0, (a0)
	la t0, yin
	la t1, yinyang
	beqz a0,SPLfim  #zero pontos
	li t3,0xFF1012E8
	li a2,2
	beq a0,a2,PL2pontos
	li a2,3
	beq a0,a2,PL3pontos
	li a2,4
	bge a0,a2,PL4pontos
	Desenhar(t3,t0)	 #1 ponto
	j SPLfim
PL2pontos:Desenhar(t3,t1)	#2 pontos
	j SPLfim	
PL3pontos:Desenhar(t3,t1)	#3 pontos
	addi t3, t3, 20
	Desenhar(t3,t0)
	j SPLfim	
PL4pontos:Desenhar(t3,t1)	#4 ou mais pontos
	addi t3, t3, 20
	Desenhar(t3,t1)
SPLfim:	la a0,PontuacaoEnemy	#inimigo
	lw a0, (a0)
	beqz a0,SENfim 	 #zero pontos
	li t3,0xFF1012E8
	addi t3,t3, 176
	li a2,2
	beq a0,a2,EN2pontos
	li a2,3
	beq a0,a2,EN3pontos
	li a2,4
	bge a0,a2,EN4pontos
	Desenhar(t3,t0)	 	#1 ponto
	j SENfim
EN2pontos:Desenhar(t3,t1)	#2 pontos
	j SENfim
EN3pontos:Desenhar(t3,t1)	#3 pontos
	addi t3, t3, 20
	Desenhar(t3,t0)
	j SENfim
EN4pontos:Desenhar(t3,t1)	#4 ou mais pontos
	addi t3, t3, 20
	Desenhar(t3,t1)
SENfim:
.end_macro

.macro Cronometro()
	la a0,TempoLimite      #texto de tempo limite
	li a1, 146
	li a2, 40
	li a3, 0xc707
	li a4, 1
	li a7, 104
	ecall
	li a7, 30
	ecall
	la a1 , TempoInicial
	lw a1, (a1)
	sub a0, a0, a1  #diferenca
	li a1,1000	#transforma em segundos
	div a0,a0,a1		
	li a5, 31
	bge a0,a5,Cronzero
	li a7,101		#print do cronometro
	li a1, 130
	li a2, 40
	li a3, 0xc707
	li a4, 1
	ecall
	j CronFim
Cronzero:la a1, Relogio	
	li a0,1
	sw a0(a1)
CronFim:	
.end_macro

.macro 	TelaFinal()
	li a2,0xFF200604
	li a0, 0
	sw a0,0(a2)	
	li a0,0xc7    #limpagem de tela 
	li a7,148
	li a1,1
	ecall	
	li a0, 1
	sw a0,0(a2)
	li t1,0xFF000000
	li t2,0xFF012C00
	la s1,fundo3	          #desenho de fundo final
	addi s1,s1,8	
LoopFinal:beq t1,t2,ForaFinal	
	lw t3,0(s1)		
	sw t3,0(t1)		
	addi t1,t1,4		
	addi s1,s1,4
	j  LoopFinal	
ForaFinal:li t0, 0xFF10E18C
	la a0, Vencer
	lw a0, (a0)	
	beqz a0,Triste
	la t1, ola3
	j DesFin
Triste:	la t1, ola4
DesFin:	Desenhar(t0,t1)
	li a2,0xFF200604	# frame 0 selecionado
	sw zero,0(a2)
	la a0,SeuScore      #Frase "Seu score;"
	li a1, 200
	li a2, 200
	li a3, 0xc707
	li a4, 1
	li a7, 104
	ecall
	la a0,Score
	lw a0, (a0)
	li a7,101		#print do Score
	li a1, 200
	li a2, 216
	li a3, 0xc700
	li a4, 1
	ecall
	la a0,Obrigado      #Frase "Obrigado"
	li a1, 70
	li a2, 24
	li a3, 0xc700
	li a4, 1
	li a7, 104
	ecall
	la a0, Vencer
	lw a0, (a0)
	bnez a0, Vitoria   #checa se ganhou
	la a0, Pena
	li a1, 40
	li a2, 200
	li a3, 0xc700
	li a4, 1
	li a7, 104
	ecall                  #Frase de derrota
	la a0, Perdeu
	li a1, 10
	li a2, 215
	li a3, 0xc700
	li a4, 1
	li a7, 104
	ecall
	j FinFin
Vitoria:la a0, Parabens
	li a1, 40
	li a2, 200
	li a3, 0xc700
	li a4, 1
	li a7, 104
	ecall                  #Frase de derrota
	la a0, Ganhou
	li a1, 25
	li a2, 215
	li a3, 0xc700
	li a4, 1
	li a7, 104
	ecall	
FinFin:	li a0, 1
	li a2,0xFF200604
	sw a0,0(a2)
.end_macro
