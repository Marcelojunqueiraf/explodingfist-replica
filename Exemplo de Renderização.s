.data
.include "Sonica.s"
.include ".\Imagens\Fundos\fundo1.s"
Player:.word 0, 0, 0, 0
Anim: .word 32, 0, 0x10010000, 0, 32, 0x10010000, -32, 0, 0x10010000, 0, -32, 0x10010000, 32, 32, 0x10010000, -32, -32, 0x10010000, 32, 0, 0x10010000, -32, 32, 0x10010000, 32, -32, 0x10010000

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
	la t1 Sonica
	la t2 Player
	sw t0 8(t2)
	sw t1 12(t2)
	Desenhar(t0 t1)
	li t2 0xFF200604
	addi t3 zero 1
	sw t3 0(t2)
	li a7 32
	li a0 250
	ecall

# Simula uma movimentação onde ela se move 2x pra direita, 2x pra baixo, 2x pra esquerda e 2x pra cima
	li s0 9
Loop0:	beqz s0 Fim
	la t0 Player
	la t1 Anim
	Render(t0 t1)
	# Delay
	li a7 32
	li a0 250
	ecall
	addi s0 s0 -1
	j Loop0
	
################### Final da simulação ################### Final da simulação ################### Final da simulação ###################
Fim:	li a7 10
	ecall
