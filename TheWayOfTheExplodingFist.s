.data
.include "Includes.s"
Numnotas: .word 54
Notas: .word 60,2856,67,357,69,357,71,1428,71,357,71,357,62,2856,71,714,69,178,67,178,65,178,67,178,69,1785,62,2856,65,357,67,357,69,357,71,714,69,357,67,357,60,2856,65,535,64,357,65,178,67,1963,60,2856,64,357,67,178,65,178,67,178,69,178,67,178,71,357,74,535,75,357,74,178,62,2856,72,357,67,357,69,357,71,357,67,892,71,357,69,178,62,2856,67,357,71,535,65,535,69,535,63,357,65,178,67,178,60,2856,65,178,0,-1
Notas1: .word 60,107,60,107,60,107,60,107,60,214,60,214,60,107,60,107,60,107,60,321,60,107,60,107,64,107,64,107,64,107,64,107,64,214,65,107,65,107,65,107,65,107,65,214,64,107,64,107,62,107,62,107,64,107,64,107,64,107,64,107,64,214,62,107,62,107,62,107,62,107,62,214,62,107,62,107,64,107,64,107,67,107,67,107,67,107,67,107,67,214,65,107,65,107,65,107,65,107,65,214,64,107,64,107,62,107,62,107,64,107,64,107,64,107,64,107,64,214,65,107,65,107,65,107,65,107,6,214,64,107,64,107,65,107,65,107,67,107,67,107,67,107,67,107,67,214,65,107,65,107,65,107,65,107,65,214,64,107,64,107,62,107,62,107,60,107,60,107,60,107,60,107,60,214,59,107,59,107,59,107,59,107,59,214,55,107,55,107,59,214,57,107,57,107,57,107,57,107,57,214,57,107,57,107,55,107,55,107,55,107,55,107,55,107,55,107,55,107,55,107,0,-1
Aperte: .string "Aperte 1 para iniciar"
TempoLimite: .string "/30"
SeuScore: .string "Seu Score:"
Obrigado: .string "Obrigado por Jogar!"
Pena: .string "Uma pena,"
Perdeu:.string "Mas voce perdeu!"
Parabens: .string "Parabens,"
Ganhou:.string " Voce ganhou!"
#X0, Y0, P0, Img0, Frame, Anim, Size
Player: .word 100, 180, 0xFF10E164, 0, 0, 128, 1
Enemy: .word 168, 180, 0xFF10E1A8, 0, 0, 128, 1
AnimacoesPlayer: .word 0x10001000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4, 0x10000000, 4
AnimacoesEnemy: .word  0x10002000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4, 0x10001000, 4
Fundos: .word 0x10002000
Fundo: .word 0
Fase: .word 0
PontuacaoPlayer: .word 0
PontuacaoEnemy: .word 1
Score: .word 0
Vencer: .word 0
HighScore: .word 0
Tempo: .word 0
TempoMusica: .word 0
NotaAtual: .word 0
Input: .word 64, 0
IAinimigo: .word 0 #0 se aproximar, 1 se afastar, 2 ataque alto , 3 ataque baixo, 4 defesa
VulnPlayer: .word 0  #0 vulenerável, 1 apenas em baixo, 2 ivulner
TempoInicial: .word 0
Relogio: .word 0

.exte
.extern DadosAnimacoesPlayer 576
#.extern DadosAnimacoesEnemy 576


.text	
.include "MACROSv21.s"
.include "Macros.s"	
.include "Inicializacao.s"
		
Menu:	Inicializacao() #Setagem de todos os arrays e valores salvos na memoria
	TelaInicial()

	
FaseLoop:
	DesenharFundo()
Reset:		#Reset de fase 
				#ZerarPontua��o()
	la t0, PontuacaoPlayer #Endere�o da pontuaacao 0x10000022
	sw zero, (t0)
	la t0, PontuacaoEnemy
	sw zero, (t0)
	#Medir tempo inicial
	li a7, 30
	ecall
	la a1, TempoInicial
	sw a0, (a1)
	la a1 , Relogio
	sw zero, (a1)
VidaLoop:
	Pontos() #Pontuacao (score e pontuacao)
	#Reposicionar Jogadores()
	#anima��o de sauda��o

	#Função
GameLoop:
	IA() #Calcula pr�xima a��o da IA
	#a0=current time

InputLoop:
	Input() #Get input #####
	la t0, Notas1
	PlayMusic(t0)
	Cronometro()
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
	addi t0, a0, 300 #t0=currentTime+xms
	la t1, Tempo
	sw t0, 0(t1)
	
	Processamento() #Chamar a fun��o Processamento (Interpretar o input e o resultado da IA. escolher frames. checar hits)
	la s0, Player
	la t1, AnimacoesPlayer
	ProcessaFrame(s0, t1)
	la s1, Enemy
	la t1, AnimacoesEnemy
	ProcessaFrame(s1, t1)
	# Desenha Player
	lw a1 8(s0) # Carrega a posicao do obj. da memoria
	lw t6 12(s0) # Carrega a imagem do obj. da memoria
	Desenhar(a1 t6)
	# Refresh Screen
	li a0 0xFF200604
	li a1 0
	sw a1 0(a0)
	li a1 1
	sw a1 0(a0)
	# Desenha Enemy
	lw a1 8(s1) # Carrega a posicao do obj. da memoria
	lw t6 12(s1) # Carrega a imagem do obj. da memoria
	Desenhar(a1 t6)
	
	la a0, Relogio   
	lw a0, (a0)
	beqz  a0, GameLoop   #continua se o tempo nao acabou
	j FimTempo	#Acabou o tempo
ForaGameLoop:
	#Checar vitoria ou derrota
	la t1, PontuacaoPlayer
	lw t2, (t1) #(fundo,fase, pontua��o player, pontua��o enemy)
	li t0, 4
	bge t2, t0, Vitoria
	j VidaLoop
FimTempo:la a1, PontuacaoEnemy
	lw a0, (a1)
	la a1, PontuacaoPlayer
	lw a1, (a1)
	bgt a0,a1 Derrota
	blt a0, a1, Vitoria
	li a0,0xc7    #limpagem de tela pra tirar scores anteriores
	li a7,148
	li a1,1
	ecall
	j Reset      # se o tempo acabar e a pontuacao estiver igual, reseta a fase
	
Vitoria:
  	li a0, 2
  	la a2, Fase
  	lw a1, (a2)
  	bge a1,a0, Ganhador
  	addi a1,a1,1
  	sw a1,(a2)
	j FaseLoop  	 	#Mudar Fundo	#FaseAtual+=1 #Dificuldade+=1	
Ganhador:la a0 ,Vencer
	li a1, 1
	sw a1, (a0)
Derrota:
	TelaFinal()
	
	li a7,10# exit
	ecall
.include "SYSTEMv21.s"
