.data
.include "Sonica.s"

.text
.include "Macros.s"

# Seta Frame 1 como transparente
	li t0 0xFF100000
	li t1 0xFF112C00
	li t2 0xc7c7c7c7
Loop: 	beq t0 t1 Fora
	sw t2 0(t0)
	addi t0 t0 4
	j Loop

# Desenha a Sonica pela primeira vez numa posição específica (0,0) {t0, t1}
Fora:	li t0 0
	li t1 0
	la t4 Sonica
	Desenhar(t0 t1 t4)
	li t2 0xFF200604
	addi t3 zero 1
	sw t3 0(t2)
	li a7 32
	li a0 250
	ecall

# Simula um game loop onde ela se move com ?X = 28 e ?Y = 19, a cada 250ms
	addi t5 zero 10
GLoop:	beqz t5 Fim
	addi t5 t5 -1
	addi t2 t0 28
	addi t3 t1 19
	li a7 32
	li a0 250
	ecall
	Mover(t0 t1 t2 t3 t4)
	mv t0 t2
	mv t1 t3
	j GLoop

Fim:	li a7 10
	ecall