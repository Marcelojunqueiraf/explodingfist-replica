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