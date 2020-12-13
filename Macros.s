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
	add a0, a0, a4 #a0 = endereco do endereço fundo a ser renderizado
	lw a0,(a0) #a0 = endereço do fundo
	addi a0,a0,8	#pula os bytes que indicam o tamanho da imagem
Loop.Fundos: beq a1,a2,Fora.Fundos
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j Loop.Fundos			
Fora.Fundos: 
	addi a4,a4,4 #Selecionar o prï¿½ximo fundo
	li t0, 12 
	rem a4, a4, t0 #Se passar do ï¿½ltimo fundo, voltar para o primeiro
	sw a4, (a3) #Escrever o fundo atual na memï¿½ria
	
	li a2,0xFF200604	# frame 0 selecionado
	sw zero,0(a2)
.end_macro


.macro TelaInicial()
	li a7, 30
	ecall 
	la t0, TempoMusica
	sw a0, (t0) #seta Temoo Musica como tempo atual


	li s0,0xFF200604	# frame 0
	li a0, 1
	sw a0,0(s0)
	li t1,0xFF000000	
	li t2,0xFF012C00
	la s1,abertura
	addi s1,s1,8		
Loop1: 	beq t1,t2,Fora1
	lw t3,0(s1)		
	sw t3,0(t1)		
	addi t1,t1,4		
	addi s1,s1,4
	j Loop1	
Fora1:	la a0,Aperte      #texto de apertar 1 
	la a0,Aperte      #texto de apertar 1 
	li a1, 140
	li a2, 220
	li a3, 0xFF00
	li a4, 0
	li a7, 104
	ecall
	sw zero,0(s0)
		
Loop2:
	la t0, Notas
	PlayMusic(t0)
	li t1,0xFF200000		# carrega o endereï¿½o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,Loop2		# nï¿½o tem tecla pressionada entï¿½o volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
   	li a0,49
   	bne t2,a0,Loop2
   	la t0, NotaAtual
   	sw zero(t0)
.end_macro 

.macro PlayMusic(%Musica)
	li a7, 30
	ecall #a0 = Tempo atual
	la a5, TempoMusica

	lw a5, (a5) #a5 = Tempo de inicio da próxima nota
	blt a0, a5, Skip #Checa se já é hora de tocar a nota

	la a4, NotaAtual
	lw a4, (a4) #a4 = nota atual * 8

	add %Musica, %Musica, a4 #%Musica = endereço na nota a ser tocada
	lw a0, 0(%Musica) #a0 = nota a ser tocada
	lw a1, 4(%Musica) #a1 = tempo da nota a ser tocada

	bge a1, zero, NotNegative #Checa se a duração da nota é negativa, ou seja, a musica acabou
	la a4, NotaAtual
	sw zero, (a4) #Zerar Nota atual (Recomeca a musica)
	j Skip
NotNegative: 
	
	li a2, 1 #Seleciona o instrumento 1
	li a3, 127 #Volume máximo
	li a7, 31 #sys call de midi
	ecall
	la a3, TempoMusica
	add a0, a5, a1
	sw a0, (a3) #Atualizar Tempo Musica
	la a3, NotaAtual
	addi a4, a4, 8
	sw a4, (a3) #Adicionar 8 a Nota Atual
Skip:	
.end_macro
	
	
.macro Inicializacao()
	#Criacao do array de fundos
	la a0, Fundos
	lw a0, (a0)
	la t0, fundo1
	sw t0, 0(a0)
	la t0, fundo2
	sw t0, 4(a0)
	la t0, fundo3
	sw t0, 8(a0)
	la a0, Fundo    #contador dos fundos 0x10000020
	sw zero, (a0)	   #zera contador
	
	#Animacoes player
	la a1, AnimacoesPlayer #a1= endereço da lista de animacoes do player
	#lw a4, n*4(a1)
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la a3, Player
	la a5, Enemy
	la t0, ola1 #t0=endereço da imagem
	sw t0, 12(a3) #Img0 = t0
	sw t0, 12(a5) #Img0 = t0
	sw t0, 8(a4) #Salvar imagem no frame da animação
	la t0, ola2 #t0=endereço da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animação
	la t0, ola3 #t0=endereço da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animação
	la t0, ola4 #t0=endereço da imagem
	sw t0, 44(a4) #Salvar imagem no frame da animação
	
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 4(a1) #Salvar o tamanho na lista de animacoes
	
		#Animacoes Enemy
	la a1, AnimacoesEnemy #a1= endereço da lista de animacoes do player
	#lw a4, n*4(a1)
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la a5, Enemy
	la t0, ola1 #t0=endereço da imagem
	sw t0, 12(a5) #Img0 = t0
	sw t0, 8(a4) #Salvar imagem no frame da animação
	la t0, ola2 #t0=endereço da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animação
	la t0, ola3 #t0=endereço da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animação
	la t0, ola4 #t0=endereço da imagem
	sw t0, 44(a4) #Salvar imagem no frame da animação
	
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 4(a1) #Salvar o tamanho na lista de animacoes
.end_macro

.macro Input() 
	li t1, 0xFF200000		# carrega o endereï¿½o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativoï¿½ï¿½o volta ao loop
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
	lw t1, 24(t2) #t1 = Tamanho da animação atual
	blt t0, t1, Skip1 #Se a animação não tiver terminado pule
	sw zero, 16(t2) #Zera o contador (frame atual)
Skip1:	
	la t2, Enemy
	lw t0, 16(t2) #t0 = frame atual
	lw t1, 24(t2) #t1 = Tamanho da animação atual
	blt t0, t1, Skip2 #Se a animação não tiver terminado pule
	sw zero, 16(t2) #Zera o contador (frame atual)
Skip2:	
	
	la t0, Input
	lw a0, 0(t0)
	li a7 1
	ecall
	li a0, ' '
	li a7, 11
	ecall
	lw a0, 4(t0)
	li a7, 1
	ecall
	li a0, '\n'
	li a7, 11
	ecall
					
	la t1, PontuacaoPlayer
	lw t3, (t1) #t3 = Pontuacao do Player
	la t1, PontuacaoEnemy
	lw t4, (t1) #t4 = Pontuacao do Enemy
	#Pegar input salvo na memória
	la t1, Input
	lw t0, (t1) #armazenar valor do input
	li t3, 64
	sw t3, (t1) #zerar input
	sw zero, 4(t1)
	bne t0, zero, SkipPoint #Checar se o input é 'd'
	la t1, PontuacaoPlayer
	lw t2, (t1) #Ler Pontuacao Player
	addi t2, t2, 4 #Adicionar 4
	sw t2, (t1) #Salvar pontuacao nova Player
	j ForaGameLoop
SkipPoint:
.end_macro


#Recebe %obj=Objeto, %array=array de animacoes do objeto
.macro DesenharFrame(%obj, %array)
	lw a1, 20(%obj) #a1 = animacao atual
	li a2, 8
	mul a1, a1, a2 #a1 = a1*8
	add a1, a1, %array #a1 = endereço do endereço da animação atual
	lw a1, 0(a1) #a1 = endereço da animação (Array de frames)
	li a2, 12
	lw a3, 16(%obj) #a3 = numero do frame atual
	mul a2, a2, a3
	addi a3, a3, 1 #Adicionar 1 ao frame
	sw a3, 16(%obj) #Salvar o novo numero de frames na memória
	add a1, a1, a2 #a1=endereco do frame atual
	mv t1, a1
	Render(%obj, t1)	
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
	Desenhar(a1 t6)
.end_macro
