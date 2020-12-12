.include "MACROSv21.s"

.data
.include ".\Imagens\Fundos\abertura.s"
.include ".\Imagens\Fundos\fundo1.s"
.include ".\Imagens\Fundos\fundo2.s"
.include ".\Imagens\Fundos\fundo3.s"
#.include "Sonica.s"
NUMNOTAS: .word 54
NOTAS: 60,2856,67,357,69,357,71,1428,71,357,71,357,62,2856,71,714,69,178,67,178,65,178,67,178,69,1785,62,2856,65,357,67,357,69,357,71,714,69,357,67,357,60,2856,65,535,64,357,65,178,67,1963,60,2856,64,357,67,178,65,178,67,178,69,178,67,178,71,357,74,535,75,357,74,178,62,2856,72,357,67,357,69,357,71,357,67,892,71,357,69,178,62,2856,67,357,71,535,65,535,69,535,63,357,65,178,67,178,60,2856,65,178
Aperte: .string "Aperte 1 para iniciar"
#X0, Y0, P0, Img0, Frame, Anim, Size
PLAYER:0, 0, 0, 0, 0, 0, 0
ENEMY: 0, 0, 0, 0, 0, 0, 0
ANIMACOES: 0, 0
FUNDO: 0
FASE: 0
PONTUACAOPLAYER: 0
PONTUACAOENEMY: 0
SCORE: 0


.text	
.include "Macros.s"	
		

MENU:	TELAINICIAL()
	INICIALIZACAO() #Setagem de todos os arrays e valores salvos na mem�ria
	
FASE_LOOP:
	DESENHAR_FUNDO()

	#ZerarPontua��o()
	li t0, 0x10000020 #Endere�o da pontua��o 0x10000022
	lw t1, (t0)
	li t2, 0xFFFF0000
	and t1, t1, t2
	sw t1, (t0)

VIDA_LOOP:

	#Reposicionar Jogadores()
	#anima��o de sauda��o
GAMELOOP:
	#IA() #Calcula pr�xima a��o da IA
	
	#a0=current time
	li a7, 30
	ecall
	addi t0, a0, 200 #t0=currentTime+200ms
INPUT_LOOP:
	INPUT() #Get input #####
	#Wait 10 ms
	li a7, 32
	li a0, 50
	ecall
	#a0=current time
	li a7, 30
	ecall	
	blt a0, t0, INPUT_LOOP #Checa se passaram 200 ms
	PROCESSAMENTO() #Chamar a fun��o Processamento (Interpretar o input e o resultado da IA. escolher frames. checar hits)
	DESENHAR_TUDO() #Desenhar ambos os personagens em duas respectivas anima��es
	
	
	j GAMELOOP
FORA_GAMELOOP:

	#Checar vitoria ou derrota
	li t1, 0x10000020
	lw t2, (t1) #(fundo,fase, pontua��o player, pontua��o enemy)
	li t5, 0x0000FF00
	and t3, t2, t5 #t3=Pontua��o Player
	srli t3, t3, 8
	li t0, 4

	
	bge t3, t0, VITORIA
	j VIDA_LOOP
VITORIA:

	#Mudar Fundo
	#FaseAtual+=1
	#Dificuldade+=1
	j FASE_LOOP
DERROTA:
	TELA_FINAL()
	
	li a7,10# exit
	ecall


.include "SYSTEMv21.s"
