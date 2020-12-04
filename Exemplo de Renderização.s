.data
PosSonica:.word 0
.include "Sonica.s"
.include ".\Imagens\Fundos\fundo1.s"

.text
.include "Macros.s"

# Seta o Fundo
GStart:	li t0 0xFF000000
	li t1 0xFF012C00
	la t3 fundo1
	addi t3 t3 8
DFundo: beq t0 t1 Transp
	lw t2 0(t3)
	sw t2 0(t0)
	addi t0 t0 4
	addi t3 t3 4
	j DFundo

# Seta Frame 1 como transparente
Transp:	li t0 0xFF100000
	li t1 0xFF112C00
	li t2 0xc7c7c7c7
Loop: 	beq t0 t1 Sonica0
	sw t2 0(t0)
	addi t0 t0 4
	j Loop

# Desenha a Sonica pela primeira vez numa posição específica (t0), e salva isso na memória
Sonica0:li t0 0xFF100000
	li t2 0x10010000
	sw t0 0(t2)
	la t1 Sonica
	Desenhar(t0 t1)
	li t2 0xFF200604
	addi t3 zero 1
	sw t3 0(t2)
	li a7 32
	li a0 250
	ecall

# Simula uma movimentação onde ela se move 2x pra direita, 2x pra baixo, 2x pra esquerda e 2x pra cima
	la t2 PosSonica
	la t3 Sonica
	mv t4 t3
	
	li t0 32
	li t1 0
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 0
	li t1 32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 -32
	li t1 0
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 0
	li t1 -32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 32
	li t1 32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 -32
	li t1 -32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 32
	li t1 0
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 -32
	li t1 32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall
	
	li t0 32
	li t1 -32
	Render(t0 t1 t2 t3 t4)
	li a0 250
	ecall

################### Final da simulação ################### Final da simulação ################### Final da simulação ###################

	li a7 10
	ecall
