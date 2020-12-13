.include "MACROSv21.s"

.data
.include ".\Imagens\Fundos\abertura.s"
.include ".\Imagens\Fundos\fundo1.s"
.include ".\Imagens\Fundos\fundo2.s"
.include ".\Imagens\Fundos\fundo3.s"
.include ".\Imagens\Sprites\Saudacao\ola1.s"
.include ".\Imagens\Sprites\Saudacao\ola2.s"
.include ".\Imagens\Sprites\Saudacao\ola3.s"
.include ".\Imagens\Sprites\Saudacao\ola4.s"
#.include "Sonica.s"
NumNotas: .word 54
Notas: 60,2856,67,357,69,357,71,1428,71,357,71,357,62,2856,71,714,69,178,67,178,65,178,67,178,69,1785,62,2856,65,357,67,357,69,357,71,714,69,357,67,357,60,2856,65,535,64,357,65,178,67,1963,60,2856,64,357,67,178,65,178,67,178,69,178,67,178,71,357,74,535,75,357,74,178,62,2856,72,357,67,357,69,357,71,357,67,892,71,357,69,178,62,2856,67,357,71,535,65,535,69,535,63,357,65,178,67,178,60,2856,65,178
Aperte: .string "Aperte 1 para iniciar"
#X0, Y0, P0, Img0, Frame, Anim, Size
Player: .word 0, 0, 0xff000000, 0, 0, 0, 4
Enemy: .word 0, 0, 0, 0, 0, 0, 0
AnimacoesPlayer: .word 0x10000000, 4
AnimacoesEnemy: .word 0x1002000, 0
Fundos: .word 0x10002000
Fundo: .word 0
Fase: .word 0
PontuacaoPlayer: .word 0
PontuacaoEnemy: .word 0
Score: .word 0
Tempo: .word 0
Input:

.text	
.include "Macros.s"	
		
Menu:	TelaInicial()
	Inicializacao() #Setagem de todos os arrays e valores salvos na mem�ria
	
FaseLoop:
	DesenharFundo()

	#ZerarPontua��o()
	la t0, PontuacaoPlayer #Endere�o da pontuaacao 0x10000022
	sw zero, (t0)

VidaLoop:

	#Reposicionar Jogadores()
	#anima��o de sauda��o
	#Medir tempo inicial
	
GameLoop:
	#IA() #Calcula pr�xima a��o da IA
	#a0=current time

InputLoop:
	Input() #Get input #####
	
	#Pequeno delay
	li a7, 32
	li a0, 30
	ecall 
	
	li a7, 30
	ecall	#a0=tempo atual
	la t1, Tempo
	lw t0,0(t1) #t0 = tempo limite
	blt a0, t0, InputLoop #Checa se passaram x ms
	####Atualizar tempo futuro
	li a7, 30
	ecall	#a0=tempo atual
	addi t0, a0, 500 #t0=currentTime+xms
	la t1, Tempo
	sw t0, 0(t1)
	
	Processamento() #Chamar a fun��o Processamento (Interpretar o input e o resultado da IA. escolher frames. checar hits)
	la t0, Player
	la t1, AnimacoesPlayer
	DesenharFrame(t0, t1)
	#la t0, ENEMY
	#la t1, ANIMACOESENEMY
	#DESENHAR_FRAME(t0, t1)
	
	j GameLoop
ForaGameLoop:

	#Checar vitoria ou derrota
	la t1, PontuacaoPlayer
	lw t2, (t1) #(fundo,fase, pontua��o player, pontua��o enemy)
	li t0, 4
	bge t2, t0, Vitoria
	j VidaLoop
Vitoria:

	#Mudar Fundo
	#FaseAtual+=1
	#Dificuldade+=1
	j FaseLoop
Derrota:
	TelaFinal()
	
	li a7,10# exit
	ecall


.include "SYSTEMv21.s"
