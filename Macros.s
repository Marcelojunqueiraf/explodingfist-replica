# Macro de desenhar imagem
.macro Desenhar(%X %Y %Img)
	mv a4 zero
	addi a5 zero 320
	mul a1 a5 %Y
	add a0 %X a1
	li a3 0xFF100000
	add a3 a0 a3
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

# Macro de movimentar
.macro Mover(%X0 %Y0 %X1 %Y1 %Img)
	li a0 0xFF200604
	li a1 0xC7C7C7C7
	li a2 0xFF100000
	add a2 a2 %X0
	addi a3 zero 320
	mul a3 a3 %Y0
	add a2 a2 a3
	addi a3 zero 0
	sw a3 0(a0)
	lw a3 0(%Img)
	lw a4 4(%Img)
	mul a4 a3 a4
	addi a5 zero 0
LoopX:	beq a5 a3 LoopY
	sw a1 0(a2)
	addi a2 a2 4
	addi a4 a4 -4
	addi a5 a5 4
	j LoopX
LoopY:	addi a5 zero 0
	beqz a4 Fora
	sub a2 a2 a3
	addi a2 a2 320
	j LoopX
Fora:	mv a1 zero
	mv a2 zero
	mv a3 zero
	Desenhar(%X1 %Y1 %Img)
	li a0 0xFF200604
	addi a1 zero 1
	sw a1 0(a0)
	mv a0 zero
	mv a1 zero
.end_macro

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
	add a0, a4, a0	#a0 = ponteiro do endere�o do fundo a ser renderizado
	lw a0,(a0) #a0 = endere�o do fundo a ser renderizado 	
	addi a0,a0,8	#pula os bytes que indicam o tamanho da imagem
LOOP.FUNDOS: beq a1,a2,FORA.FUNDOS
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j LOOP.FUNDOS			
FORA.FUNDOS: 
	addi a4,a4,4 #Selecionar o pr�ximo fundo
	li t0, 12 
	rem a4, a4, t0 #Se passar do �ltimo fundo, voltar para o primeiro
	slli a4, a4, 24
	sw a4, (a3) #Escrever o fundo atual na mem�ria
	
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
		
	la s0,NUMNOTAS 	#parte da música
	lw s1,0(s0)
	la s0,NOTAS		# define o endereço das notas
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
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
ACORDE:	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi s2,s2,1  	#terimna parte da musica
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP2		# n�o tem tecla pressionada ent�o volta ao loop
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
	sw  zero, (a0)	   #zera contadpr
.end_macro

.macro INPUT() 
	li t1, 0xFF200000		# carrega o endere�o de controle do KDMMIO
	li t2, 0x10000024
	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo��o volta ao loop
   	beq zero, t0, SKIP_READING
   	lw t3,4(t1)			# le o valor da tecla
   	sw t3, (t2)
SKIP_READING:
.end_macro
	
.macro PROCESSAMENTO()
.data
BreakLine: .ascii "\n"
Space: .ascii " "
.text
	li t1, 0x10000020
	lw t0, 4(t1) #input
	sw zero, 4(t1)
	lw t2, (t1) #(fundo,fase, pontua��o player, pontua��o enemy)
	li t5, 0x0000FF00
	and t3, t2, t5 #t3=Pontua��o Player
	srli t3, t3, 8
	srli t5, t5, 8 
	and t4, t2, t5 #t4=Pontua��o Enemy
	li t2, 'd'
	
	bne t0, t2, SKIP_POINT #adicionar 1 � pontua��o do player e sair gameloop
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
# Desenha a Sonica pela primeira vez numa posi��o espec�fica (0,0) {t0, t1}
Sonica0:li t0 52
	li t1 160
	la t4 Sonica
	Desenhar(t0 t1 t4)
	li t2 0xFF200604
	addi t3 zero 1
	sw t3 0(t2)
.end_macro
	
.macro TELA_FINAL()
.end_macro

# Macro de limpar // Recebe %X - Tamanho X pra apagar, %Y - Tamanho Y pra apagar, %Z - Endere�o do pixel 0
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

# Macro de desenhar imagem // Recebe %Z - Endere?o do p?xel 0, %Img - Imagem a desenhar
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

# Macro de renderizar // Recebe %X - Delta X, %Y - Delta Y, %P0 - Endere?o da posi??o do obj. na mem?ria, %S0 - Endere?o Sprite 1 (apagar) na mem?ria, %S1 - Sprite 2 (desenhar) na mem?ria
.macro Render(%X %Y %P0 %S0 %S1)
	# Coleta posi??o na tela do objeto
	lw a6 0(%P0)
	# Ret?ngulo Vermelho
	mv a2 a6
	bltz %X XMenorR
	lw a0 0(%S0)
	sub a0 a0 %X
	add a2 a2 %X
	j FimRX
XMenorR:lw a0 0(%S1)
	add a0 a0 %X
FimRX:	bltz %Y YMenorR
	mv a1 %Y
	j FimRY
YMenorR:lw a1 4(%S0)
	lw a3 4(%S1)
	add a3 a3 %Y
	sub a1 a1 a3
	li a4 320
	mul a3 a3 a4
	add a2 a2 a3
FimRY:	Limpar(a0 a1 a2)
	# Ret?ngulo Azul
	mv a3 a6
	lw a2 4(%S0)
	bltz %X XMenorB
	mv a1 %X
	j FimB
XMenorB:lw a1 0(%S0)
	sub a1 a1 a0
	add a3 a3 a0
FimB:	Limpar(a1 a2 a3)
	# Desenhar pr?xima sprite
	li a0 320
	mul a1 %Y a0
	add a1 a1 %X
	add a1 a1 a6
	sw a1 0(%P0) # Atualiza a posi??o do obj. na mem?ria
	Desenhar(a1 %S1)
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
.end_macro
