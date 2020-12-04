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
	lui a0, 0x10000   #carrega array
	lui a3, 0x10000   #carrega contador
	addi a3,a3, 100	 #
	lw a4,(a3)  #deferencia a3
	add a0, a4, a0
	lw a0,(a0) #seleciona o fundo somando o contador 	
	addi a0,a0,8		
LOOP.FUNDOS: beq a1,a2,FORA.FUNDOS
	lw a5,0(a0)		
	sw a5,0(a1)		
	addi a1,a1,4		
	addi a0,a0,4
	j LOOP.FUNDOS			
FORA.FUNDOS: addi a4,a4,4
	sw a4, (a3)	
	
	li a0,0xFF200604
	sw zero,0(a0)
	mv ra, s2
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
	
	sw zero,0(s0)
	li t1,0xFF200000		# carrega o endereï¿½o de controle do KDMMIO
LOOP2: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP2		# nï¿½o tem tecla pressionada entï¿½o volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
   	li a0,49
   	bne t2,a0,LOOP2

.end_macro
	
.macro INICIALIZACAO()
	lui a0, 0x10000   #array dos fundos  0x100000000
	la t0, fundo1
	sw t0, (a0)
	la t0, fundo2
	sw t0, 4(a0)
	la t0, fundo3
	sw t0, 8(a0)
	lui a0, 0x10000    #contador dos fundos/fases 0x10000100
	addi a0,a0,100     #
	sw  zero, (a0)	   #zera contadpr
	mv ra, s2
.end_macro

.macro INPUT() 
.end_macro
	
.macro PROCESSAMENTO()
.end_macro
.macro DESENHAR()
# Desenha a Sonica pela primeira vez numa posição específica (0,0) {t0, t1}
Sonica0:li t0 100
	li t1 100
	la t4 Sonica
	Desenhar(t0 t1 t4)
	li t2 0xFF200604
	addi t3 zero 1
	sw t3 0(t2)
.end_macro
	
.macro TELA_FINAL()
.end_macro