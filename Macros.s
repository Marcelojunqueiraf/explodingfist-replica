
.macro DESENHAR_FUNDO()
	li a2,0xFF200604	# frame 1 selecionado
	li a0, 1
	sw a0,0(a2)
	li a0,0xc7    #limpagem de tela pra renderizar telinha
	li a7,148
	li a1,1
	ecall	
	li a1,0xFF000000	
	li a2,0xFF012C00	
	li a0, 0x10000300   #carrega array
	li a3, 0x10000020   #carrega contador
	lw a4,(a3)  #A4 = contador
	srli a4, a4, 24
	add a0, a4, a0	#a0 = ponteiro do endereï¿½o do fundo a ser renderizado
	lw a0,(a0) #a0 = endereï¿½o do fundo a ser renderizado 	
	addi a0,a0,8	#pula os bytes que indicam o tamanho da imagem
LOOP.FUNDOS: beq a1,a2,FORA.FUNDOS
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j LOOP.FUNDOS			
FORA.FUNDOS: 
	addi a4,a4,4 #Selecionar o prï¿½ximo fundo
	li t0, 12 
	rem a4, a4, t0 #Se passar do ï¿½ltimo fundo, voltar para o primeiro
	slli a4, a4, 24
	sw a4, (a3) #Escrever o fundo atual na memï¿½ria
	
	li a2,0xFF200604	# frame 0 selecionado
	sw zero,0(a2)
.end_macro
	
.macro TELAINICIAL()
	li s0,0xFF200604	# frame 0
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
	la a0,Aperte      #texto de apertar 1 
	li a1, 140
	li a2, 220
	li a3, 0xFF00
	li a4, 0
	li a7, 104
	ecall
	sw zero,0(s0)
		
	la s0,NUMNOTAS 	#parte da mÃºsica
	lw s1,0(s0)
	la s0,NOTAS		# define o endereÃ§o das notas
	li a2,1			# instrumento
	li a3,127		# volume
	li s2,0			#contador da nota
	LOOP2:  blt  s2,s1,RESETM	#reseta musica
	li s2,0
	la s0,NOTAS
RESETM:	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall	
	li s3, 2000
	bgt a1,s3,ACORDE
	mv a0,a1		# passa a duraï¿½ï¿½o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
ACORDE:	addi s0,s0,8		# incrementa para o endereï¿½o da prï¿½xima nota
	addi s2,s2,1  	#terimna parte da musica
	
	li t1,0xFF200000		# carrega o endereï¿½o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP2		# nï¿½o tem tecla pressionada entï¿½o volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
   	li a0,49
   	bne t2,a0,LOOP2

.end_macro
	
.macro INICIALIZACAO()
	li a0, 0x10000300   #array dos fundos  0x100000300
	la t0, fundo1
	sw t0, (a0)
	la t0, fundo2
	sw t0, 4(a0)
	la t0, fundo3
	sw t0, 8(a0)
	li a0, 0x10000020    #contador dos fundos 0x10000020
	sw  zero, (a0)	   #zera contador
.end_macro

.macro INPUT() 
	li t1, 0xFF200000		# carrega o endereï¿½o de controle do KDMMIO
	li t2, 0x10000024
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativoï¿½ï¿½o volta ao loop
   	beq zero, t0, SKIP_READING
   	lw t3,4(t1)			# le o valor da tecla
   	sw t3, (t2)
SKIP_READING:
.end_macro
	
.macro PROCESSAMENTO()
	la t2, FRAME
	lw t0, 0(t2) #t0 = frame atual
	la t1, SIZE 
	lw t1, 0(t1) #t1 = Tamanho da animação atual
	blt t0, t1, SKIP #Se a animação não tiver terminado pule
	sw zero, 0(t2) #Zera o contador (frame atual)
SKIP:
.data
BreakLine: .ascii "\n"
Space: .ascii " "
.text
	li t1, 0x10000020
	lw t0, 4(t1) #input
	sw zero, 4(t1)
	lw t2, (t1) #(fundo,fase, pontuaï¿½ï¿½o player, pontuaï¿½ï¿½o enemy)
	li t5, 0x0000FF00
	and t3, t2, t5 #t3=Pontuaï¿½ï¿½o Player
	srli t3, t3, 8
	srli t5, t5, 8 
	and t4, t2, t5 #t4=Pontuaï¿½ï¿½o Enemy
	li t2, 'd'
	
	bne t0, t2, SKIP_POINT #adicionar 1 ï¿½ pontuaï¿½ï¿½o do player e sair gameloop
	addi t3, t3, 4
	lw t2, (t1)
	li t5, 0xffff00ff
	slli t3, t3, 8
	and t2, t2,t5
	add t2, t2, t3
	srli t3, t3, 8
	sw t2, (t1)

	j FORA_GAMELOOP

SKIP_POINT:
	mv a0, t3
	li a7, 1
	ecall
	la t0, Space
	lb a0, (t0)
	li a7, 11
	ecall
	mv a0, t4
	li a7, 1
	ecall
	la t0, BreakLine
	lb a0, (t0)
	li a7, 11
	ecall
	
.end_macro
.macro DESENHAR_TUDO()
	la t0, PLAYER
	lw t1, 20(t0) #t1 = animacao atual
	li t2, 8
	mul t1, t1, t2 #t1 = t1*8
	la t2, ANIMACOES
	add t1, t1, t2 #t1 = endereço do endereço da animação atual
	lw t1, 0(t1) #t1 = endereço da animação
	li t2, 12
	la t4, FRAME
	lw t3, 0(t4) #t3 = numero do frame atual
	mul t2, t2, t3
	addi t3, t3, 1 #Adicionar 1 ao frame
	lw t3, 0(t4) #Salvar o novo numero de frames na memória
	add t1, t1, t2 #t1=endereco do frame atual
	Render(t0, t1)
	#Alterar X0 e Y0
	lw t1, 8(t1)
	sw t1, 12(t0) #Img0 = Img
	


.end_macro
	
.macro TELA_FINAL()
.end_macro

# Macro de limpar // Recebe %X - Tamanho X pra apagar, %Y - Tamanho Y pra apagar, %Z - Endereco do pixel 0
.macro Limpar(%X %Y %Z)
	mv a0 %X
	mv a1 %Y
	mv a2 %Z
	mv a3 zero
	li a4 0xC7C7C7C7
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
Fora:	mv a0 zero
	mv a2 zero
	mv a4 zero
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
Fora:	mv a0 zero
	mv a2 zero
	mv a3 zero
	mv a5 zero
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
	bltz t2 XMenorB
	mv a1 t2
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
	Desenhar(a1 t6)
	# Refresh
	li a0 0xFF200604
	li a1 0
	sw a1 0(a0)
	li a1 1
	sw a1 0(a0)
	# Limpa os Regs
	mv a0 zero
	mv a1 zero
	mv a6 zero
	mv a7 zero
.end_macro
