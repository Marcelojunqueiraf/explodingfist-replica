.macro 	ReposicionarJogadores()
	la a2, Player
	lw a0, 12(a2)
	lw a1, 4(a0)
	lw a0, (a0)
	lw a2, 8(a2)
	#X, Y, Img
	Limpar(a0, a1, a2)
	la a2, Enemy
	lw a0, 12(a2)
	lw a1, 4(a0)
	lw a0, (a0)
	lw a2, 8(a2)
	#X, Y, Img
	Limpar(a0, a1, a2)

	la a0, Player			#reset de posicao
	li a1, 0xFF10E114
	sw a1, 8(a0)
	li a1, 20
	sw a1, 0(a0)
	li a1, 0
	sw a1, 16(a0)
	li a1, 128
	sw a1, 20(a0)
	li a1, 1
	sw a1, 24(a0)
	li a1, 3
	sw a1, 28(a0)
	li a1, 0
	sw a1, 32(a0)
	li a1, 0
	sw a1, 36(a0)
	li a1, 0
	sw a1, 40(a0)
	li a1, 0
	sw a1, 44(a0)
	
	
	la a0, Enemy
	li a1, 0xFF10E1F8
	sw a1, 8(a0)	
	li a1, 248
	sw a1, 0(a0)	
	li a1, 0
	sw a1, 16(a0)
	li a1, 128
	sw a1, 20(a0)
	li a1, 1
	sw a1, 24(a0)
	li a1, 3
	sw a1, 28(a0)
	li a1, 0
	sw a1, 32(a0)
	li a1, 0
	sw a1, 36(a0)
	li a1, 0
	sw a1, 40(a0)
	li a1, 0
	sw a1, 44(a0)
.end_macro


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
	add a0, a0, a4 #a0 = endereco do endere?o fundo a ser renderizado
	lw a0,(a0) #a0 = endere?o do fundo
	addi a0,a0,8	#pula os bytes que indicam o tamanho da imagem
Loop.Fundos: beq a1,a2,Fora.Fundos
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j Loop.Fundos			
Fora.Fundos: 
	addi a4,a4,4 #Selecionar o pr?ximo fundo
	li t0, 12 
	rem a4, a4, t0 #Se passar do ?ltimo fundo, voltar para o primeiro
	sw a4, (a3) #Escrever o fundo atual na mem?ria
	
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
	li t1,0xFF200000		# carrega o endere?o de controle do KDMMIO
	#parte da m�sica
	la s0,Numnotas
	lw s1,0(s0)
	la s0,Notas		# define o endere�o das notas
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
	mv a0,a1		# passa a dura??o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
ACORDE:	addi s0,s0,8		# incrementa para o endere?o da pr?xima nota
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

	lw a5, (a5) #a5 = Tempo de inicio da pr?xima nota
	blt a0, a5, Skip #Checa se j? ? hora de tocar a nota

	la a4, NotaAtual
	lw a4, (a4) #a4 = nota atual * 8

	add %Musica, %Musica, a4 #%Musica = endere?o na nota a ser tocada
	lw a0, 0(%Musica) #a0 = nota a ser tocada
	lw a1, 4(%Musica) #a1 = tempo da nota a ser tocada
	
	bge a1, zero, NotNegative #Checa se a dura??o da nota ? negativa, ou seja, a musica acabou
	la a4, NotaAtual
	sw zero, (a4) #Zerar Nota atual (Recomeca a musica)
	j Skip
NotNegative: 
	beq a0, zero, Pause #Checa se ? uma pausa
	li a2, 1 #Seleciona o instrumento 1
	li a3, 100 #Volume m?ximo
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
	li t1, 0xFF200000		# carrega o endere?o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo??o volta ao loop
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
   	li t0, 8
   	sw t0, (t2)
   	j SkipReading
Skip2:   li t0, 'w'
   	bne a0, t0, Skip3
   	li t0, 16
   	sw t0, (t2)
   	j SkipReading
Skip3: 	li t0, 'q'
   	bne a0, t0, Skip4
   	li t0, 24
   	sw t0, (t2)
   	j SkipReading
Skip4:   li t0, 'a'
   	bne a0, t0, Skip5
   	li t0, 32
   	sw t0, (t2)
   	j SkipReading
Skip5: 	li t0, 'z'
   	bne a0, t0, Skip6
   	li t0, 40
   	sw t0, (t2)
   	j SkipReading
Skip6:   li t0, 'x'
   	bne a0, t0, Skip7
   	li t0, 48
   	sw t0, (t2)
   	j SkipReading
Skip7: 	li t0, 'c'
   	bne a0, t0, Skip8
   	li t0, 56
   	sw t0, (t2)
   	j SkipReading
Skip8:   li t0, 'f'
   	bne a0, t0, Skip9
   	li t0, 64
   	sw t0, 4(t2)
Skip9:  li t0, 'h'
   	bne a0, t0, SkipReading
   	j FaseLoop
SkipReading:
.end_macro
	
.macro Processamento()
.text	#Seletor de animacao do Player
	la t2, Player
	lw t0, 16(t2) #t0 = frame atual 
	lw t1, 36(t2) #t1 = framehit

	bne t0, t1, SkipHit 
	beqz t0, SkipHit
	li a0, 'F'
	li a7, 11
	ecall
	
	lw t0, 0(t2) #t0= x do player
	la t1, Enemy #t1 = endereco enemyw
	lw t3, 0(t1) #t3 = x enemy
	sub t0, t3, t0 #t0 = posicao relativa
	lw t4, 32(t2) #t4 = alvo player
	lw t5, 28(t1) #t5 = estado enemy
	and t4, t5, t4
	beq t4, zero, SkipHit

	lw t4, 40(t2) #t4 = x0
	lw t5, 44(t2) #t4 = xf

	blt t0, t4, SkipHit #x<x0
	bgt t0, t5, SkipHit #x>xf
	#Acertar hit do player no inimigo
	
	la t0, Enemy
	li t1, 152
	sw zero, 16(t0)
	sw t1, 20(t0)
	li t1, 5
	sw t1, 24(t0)
	
	la t0, Player
	li t1, 144
	sw zero, 16(t0)
	sw t1, 20(t0)
	li t1, 5
	sw t1, 24(t0)
	sw zero, 36(t0)
	
	la t0, Venceu
	li t1, 1
	sw t1, (t0)
	
	li a0, 'D'
	li a7, 11
	ecall
	li a0, 60
	li a1, 1000
	li a2, 126
	li a3, 127
	li a7 31
	ecall
	
SkipHit:
	lw t0, 16(t2) #t0 = frame atual
	lw t1, 24(t2) #t1 = Tamanho da anima??o atual
	blt t0, t1, Skip1 #Se a anima??o naoo tiver terminado pule
	la t0, Venceu
	lw t0, (t0)
	beqz t0, SkipVic  
	la t0, PontuacaoPlayer
	lw t1, (t0)
	addi t1, t1, 1
	sw t1, (t0)
	la t0, Score
	lw t1, (t0)
	addi t1, t1, 500
	sw t1, (t0)
	
	la t0, Venceu
	sw zero, (t0)
	
	j ForaGameLoop
SkipVic:
	la t0, Morreu
	lw t0, (t0)
	beqz t0, SkipPerd  
	la t0, PontuacaoEnemy
	lw t1, (t0)
	addi t1, t1, 1
	sw t1, (t0)
	
	la t0, Morreu
	sw zero, (t0)
	
	j ForaGameLoop
SkipPerd:
	la t0, Input
	lw t1, (t0) #dire??o
	
	li t3, 64
	bgt t1, t3, SkipFire
	lw t3, 4(t0) #FireButton
	sw zero, 4(t0)
	add t1, t1, t3 #Soma direcao com firebutton
SkipFire:
	sw t1, 20(t2) #Muda a Anima??o
	sw zero, 16(t2) #Zera o contador (frame atual)
	la t0, AnimacoesPlayer
	add t0, t0, t1 #t0 = endereco do endereco da animacao nova
	mv s0, t0
	lw t0, 4(t0) #t0 = numero de frames da animacao nova
	sw t0, 24(t2) #Salva o tamanho da animacao em Player
	#Dados 
	#t1 = indice animacao*8
	mv t0, s0
	li t0, 3
	mul t0, t1, t0 #t1 = endere?o no dadosAnimacoes
	la t1, DadosAnimacoesPlayer

	add t0, t0, t1 #t0=endere?o do dado das animacoes
	

	la t2, Player
	lw t3, (t0) #t3 = estados
	sw t3, 28(t2) # estados
	lw t3, 4(t0) # alvos
	sw t3, 32(t2) # alvos
	lw t3, 8(t0) # framehit
	sw t3, 36(t2) # framehit
	lw t3, 12(t0) # x0
	sw t3, 40(t2) # x0
	lw t3, 16(t0) # xf
	sw t3, 44(t2) # xf
	 
Skip1:	
	li t0, 128
	la t1, Input
	sw t0, (t1)

#Seletor de animacao do Enemy
	la t2, Enemy
	lw t0, 16(t2) #t0 = frame atual 
	lw t1, 36(t2) #t1 = framehit

	bne t0, t1, SkipHit2
	beqz t0, SkipHit2

	lw t0, 0(t2) #t0= x do player
	la t1, Player #t1 = endereco enemyw
	lw t3, 0(t1) #t3 = x enemy
	sub t0, t3, t0 #t0 = posicao relativa
	lw t4, 32(t2) #t4 = alvo player
	lw t5, 28(t1) #t5 = estado enemy
	and t4, t5, t4
	beq t4, zero, SkipHit2

	lw t4, 40(t2) #t4 = x0
	lw t5, 44(t2) #t4 = xf

	blt t0, t4, SkipHit2 #x<x0
	bgt t0, t5, SkipHit2 #x>xf
	#Acertar hit do player no inimigo
	
	la t0, Player
	li t1, 152
	sw zero, 16(t0)
	sw t1, 20(t0)
	li t1, 5
	sw t1, 24(t0)
	
	la t0, Enemy
	li t1, 144
	sw zero, 16(t0)
	sw t1, 20(t0)
	li t1, 5
	sw t1, 24(t0)
	sw zero, 36(t0)
	
	la t0, Morreu
	li t1, 1
	sw t1, (t0)
	
	ecall
	li a0, 60
	li a1, 1000
	li a2, 126
	li a3, 127
	li a7 31
	ecall
SkipHit2:
	lw t0, 16(t2) #t0 = frame atual
	lw t1, 24(t2) #t1 = Tamanho da anima??o atual
	blt t0, t1, Skip2 #Se a anima??o naoo tiver terminado pule
	
	la t0, IAinimigo
	lw t1, (t0) #dire??o
	
	sw t1, 20(t2) #Muda a Anima??o
	sw zero, 16(t2) #Zera o contador (frame atual)
	la t0, AnimacoesEnemy
	add t0, t0, t1 #t0 = endereco do endereco da animacao nova
	mv s0, t0
	lw t0, 4(t0) #t0 = numero de frames da animacao nova
	sw t0, 24(t2) #Salva o tamanho da animacao em Player
	#Dados 
	#t1 = indice animacao*8
	mv t0, s0
	li t0, 3
	mul t0, t1, t0 #t1 = endere?o no dadosAnimacoes
	la t1, DadosAnimacoesEnemy
	add t0, t0, t1 #t0=endere?o do dado das animacoes
	la t2, Enemy
	lw t3, (t0) #t3 = estados
	sw t3, 28(t2) # estados
	lw t3, 4(t0) # alvos
	sw t3, 32(t2) # alvos
	lw t3, 8(t0) # framehit
	sw t3, 36(t2) # framehit
	lw t3, 12(t0) # x0
	sw t3, 40(t2) # x0
	lw t3, 16(t0) # xf
	sw t3, 44(t2) # xf
	 
Skip2:	
					
.end_macro


#Recebe %obj=Objeto, %array=array de animacoes do objeto
.macro ProcessaFrame(%obj, %array)
	lw a1, 20(%obj) #a1 = animacao atual
	add a1, a1, %array #a1 = endere?o do endereco da animacao atual
	lw a1, 0(a1) #a1 = endere?o da anima??o (Array de frames)
	li a2, 12
	lw a3, 16(%obj) #a3 = numero do frame atual
	mul a2, a2, a3
	addi a3, a3, 1 #Adicionar 1 ao frame
	sw a3, 16(%obj) #Salvar o novo numero de frames na memoria
	add a1, a1, a2 #a1=endereco do frame atual
	mv t1, a1
	Render(%obj t1)
	# Atualiza X e Y
	lw a0 0(t1)
	lw a1 4(t1)
	lw a2 0(%obj)
	lw a3 4(%obj)
	add a2 a2 a0
	add a3 a3 a1
	sw a2 0(%obj)
	sw a3 4(%obj)
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
	lw a5 0(%Anim) # dX
	lw t5 4(%Anim) # dY
	lw a6 8(%Obj) # P0
	lw a7 12(%Obj) # S0
	lw t6 8(%Anim) # S1
	# Retangulo Vermelho
	lw a1 0(a7)
	lw a2 4(a7)
	Limpar(a1 a2 a6)
	# Desenhar proxima sprite
	li a0 320
	mul a1 t5 a0
	add a1 a1 a5
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
	sub a3,a2,a1
	li a5,1
	beq a0,a5,D2
	li a5,2
	beq a0,a5,D3	 

	#D1  		IA 1 - Se aproxima at� 80, se afasta a partir de 50 ,sempre ataca alto entre as duas distancias
	#sub a3,a2,a1
	li a0,30      	#80 de distãncia, número arbitrário, tamanho médio de sprite = 40
	ble a3,a0,PertoD1
	li a1,0
	sw a1,(a4)    #se aproxima caso esteja mais que isso
	j Dfim 
PertoD1:li a0,10
	ble a3,a0,AfastarD1
	li a0 ,8 	 #ataque alto 
	sw a0,(a4)
	j Dfim 
AfastarD1:li a0, 32
	sw a0, (a4)  #se afasta
	j Dfim

	#D2 		IA 2 - Se aproxima até 60 , se afasta a partir de 45, ataca alto e baixo randomicamente entre as duas distancias
D2:	li a0,30
	ble a3,a0,PertoD2
	li a1,0
	sw a1,(a4)
	j Dfim
PertoD2:li a0,10
	ble a3,a0,AfastarD2    
	la a1,Player   #1cima  1tronco 1 em baixp
	addi a1,a1, 28
	lw a1, 0(a1)
	li a2, 2
	ble a1,a2,D2chute  # adiciona 2 pra transformar em ataque / alto(3) ou ou baixo (4)
	li a0, 8
	j D2store
D2chute:li a0, 112
D2store:sw a0,(a4)
	j Dfim
AfastarD2:li a0, 32
	sw a0, (a4)  #se afasta
	j Dfim

	#D3  		IA 3- Se aproxima at� 35~40?(testar), n�o se afasta,defende, ataca alto ou baixo  dependendo da Vulnerabilidade do player

D3:	li a0, 55
	ble a3,a0,PertoD3
	li a1, 0
	sw a1,(a4)
	j Dfim
PertoD3:la a1,Player   #1cima  1tronco 1 em baixp
	li a0,5
	ble a3,a0,AfastarD3
	addi a1,a1, 28
	lw a1, 0(a1)
	li a2, 1
	ble a1,a2, Defesa      #Invul em todos, defesa
	li a2, 2
	bge a1, a2,Baixo   #defesa em cima, ataca em baixo
	li a0,8	   #em cima
	sw a0, (a4)
	j Dfim
Defesa:	li a0, 48
	sw a0, (a4)
	j Dfim
Baixo:	li a0, 112
	sw a0, (a4)
	j Dfim
AfastarD3:li a0, 24
	sw a0(a4)
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
	li a1, 1000 #transforma em segundos
	div a0,a0,a1		
	li a5, 61
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
