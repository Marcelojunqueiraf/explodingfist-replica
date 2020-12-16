.data
Player: .word 0, 0, 0, 0, 0, 0, 0 #X0, Y0, P0, Img0, Frame, Anim, Size
AnimacoesPlayer: .word 0x10010024, 9
Anim: .word 32, 0, 0x10010090, 0, 32, 0x10010090, -32, 0, 0x10010090, 0, -32, 0x10010090, 32, 32, 0x10010090, -32, -32, 0x10010090, 32, 0, 0x10010090, -32, 32, 0x10010090, 32, -32, 0x10010090
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
	la t1 Sonica
	la t2 Player
	sw t0 8(t2)
	sw t1 12(t2)
	Desenhar(t0 t1)
	li t2 0xFF200604
	li t3 1
	sw t3 0(t2)
	# Delay
	li a7 32
	li a0 250
	ecall

# Simula uma animação onde ela se move 2x pra direita, 2x pra baixo, 2x pra esquerda e 2x pra cima
	li s0 9
	la s1 Player
	la s2 AnimacoesPlayer
	lw t0 4(s2)
	sw t0 24(s1)
Loop0:	beqz s0 Fim
	ProcessaFrame(s1 s2)
	lw a1 8(s1) # Carrega a posicao do obj. da memoria
	lw t6 12(s1) # Carrega a imagem do obj. da memoria
	Desenhar(a1 t6)
	# Refresh Screen
	li a0 0xFF200604
	li a1 0
	sw a1 0(a0)
	li a1 1
	sw a1 0(a0)
	# Delay
	li a7 32
	li a0 250
	ecall
	addi s0 s0 -1
	j Loop0

# Termina o programa
Fim:	li a7 10
	ecall
