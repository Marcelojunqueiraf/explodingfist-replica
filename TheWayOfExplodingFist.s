.include "MACROSv21.s"
.data
.include "abertura.s"
.2
Aperte: .string "Aperte 1 para iniciar"
.text
	jal s2, TELAINICIAL
	jal s2, CONTADORES
	
	
	
	li a7,10		# exit
	ecall
	
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
FORA1:	la a0,Aperte
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
	j s2

CONTADORES:
	lui a0, 0x1000   # Contador das fases
	
	



.include "SYSTEMv21.s"