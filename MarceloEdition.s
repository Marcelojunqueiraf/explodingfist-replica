.include "MACROSv21.s"
.data
.include "abertura.s"
.include "fundo1.s"
.include "fundo2.s"
.include "fundo3.s"
Aperte: .string "Aperte 1 para iniciar"
.text				
	jal s2, TELAINICIAL
	jal s2, CONTADORES
	
GAMELOOP:
	jal s2, FUNDOS
	li a7,10		# exit
	ecall
	
	
	
FUNDOS:	li a2,0xFF200604	# frame 1 selecionado
	li a0, 1
	sw a0,0(a2)
	li a0,0x07    #limpagem de tela pra renderizar telinha
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
	ret
	
TELAINICIAL:	li s0,0xFF200604	# frame 0
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
LOOP2: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP2		# n�o tem tecla pressionada ent�o volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
   	li a0,49
   	bne t2,a0,LOOP2

   	li a0,0x00
	li a7,148
	li a1,0
	ecall	
	
	mv ra, s2
	ret
CONTADORES:
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
	ret
	
.include "SYSTEMv21.s"
