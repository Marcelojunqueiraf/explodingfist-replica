.include "MACROSv21.s"

.data
.include ".\Imagens\Fundos\abertura.s"
.include ".\Imagens\Fundos\fundo1.s"
.include ".\Imagens\Fundos\fundo2.s"
.include ".\Imagens\Fundos\fundo3.s"
.include "Sonica.s"
Aperte: .string "Aperte 1 para iniciar"

.text	
.include "Macros.s"	
		

MENU:	TELAINICIAL()
	INICIALIZACAO() #Setagem de todos os arrays e valores salvos na memória
	
FASE_LOOP:
	DESENHAR_FUNDO()
	#ZerarPontuação()
VIDA_LOOP:
	#Reposicionar Jogadores()
	#animação de saudação
GAMELOOP:
	#IA() #Calcula próxima ação da IA
	
	#a0=current time
	li a7, 30
	ecall
	addi t0, a0, 200 #t0=currentTime+200ms
INPUT_LOOP:
	INPUT() #Get input #####
	#Wait 10 ms
	li a7, 32
	li a0, 10
	ecall
	#a0=current time
	li a7, 30
	ecall	
	blt a0, t0, INPUT_LOOP #Checa se passaram 200 ms
	PROCESSAMENTO() #Chamar a função Processamento (Interpretar o input e o resultado da IA. escolher frames. checar hits)
	DESENHAR() #Desenhar ambos os personagens em duas respectivas animações
	
	
	j GAMELOOP
FORA_GAMELOOP:
	#Checar vitoria ou derrota
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
