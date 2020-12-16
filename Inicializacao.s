.macro Inicializacao()
	#Criacao do array de fundos
	la a0, Fundos
	lw a0, (a0)
	la t0, fundo1
	sw t0, 0(a0)
	la t0, fundo2
	sw t0, 4(a0)
	la t0, fundo3
	sw t0, 8(a0)
	la a0, Fundo    #contador dos fundos 0x10000020
	sw zero, (a0)	   #zera contador
	
	#Animacoes player
	la a1, AnimacoesPlayer #a1= endereï¿½o da lista de animacoes do player
	
	la a3, Player #Setar primeira imagem player
	la t0, ola1 #t0=endereï¿½o da imagem
	sw t0, 12(a3) #Img0 = t0
	
#Andar
#andar6, andar5, andar6
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la t0, andar6 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	li t1, 16 #dx
	sw t1, 12(a4)
	la t0, andar5 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, andar6 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 4(a1) #Salvar o tamanho na lista de animacoes
	

#High Punch (Soco Alto)
#jab1,jab2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 8(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la t0, jab1 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	la t0, jab2 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, jab1 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 12(a1) #Salvar o tamanho na lista de animacoes
#Jump
#voadora2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 16(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -4 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 4 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 32 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 20(a1) #Salvar o tamanho na lista de animacoes

#Forward somersault (Cambalhota)
#cambalhota1, cambalhota 2, misc1, cambalhota3
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 24(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, cambalhota1 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, cambalhota2 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, -16 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, misc1 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, 16 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, cambalhota3 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, 32 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 28(a1) #Salvar o tamanho na lista de animacoes
#Walk Back (Mesmo do Andar)
#andar6, andar5 andar6
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 32(a1) #a4 = endereco de inicio da animacao
	la t0, andar6 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	li t1, -16 #dx
	sw t1, 12(a4)
	la t0, andar5 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, andar6 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 36(a1) #Salvar o tamanho na lista de animacoes
#Back Somersault (cambalhota para trás)
#cambalhota3, misc1, cambalhota2, cambalhota1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 40(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, cambalhota3 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, misc1 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, -16 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, cambalhota2 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, 16 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, cambalhota1 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, 32 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 44(a1) #Salvar o tamanho na lista de animacoes
#Crouch (Agaixar)
#defesasentado
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 48(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 52(a1) #Salvar o tamanho na lista de animacoes
#jab (Soco médio) Pra gente vai ser soco baixo
#jab1, socoacachado
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 56(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, jab1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, socoagachado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 12 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, jab1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -12 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
		
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 60(a1) #Salvar o tamanho na lista de animacoes
	
#Mid Kick (Chute Médio)
#highkick1, chutegirando7, midkick
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 64(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, chutegirando1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, midkick #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 68(a1) #Salvar o tamanho na lista de animacoes

#High Kick (Chute Alto)
#highkick1, chutediagonalcima, highkick2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 72(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, chutediagonacima #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, highkick2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 76(a1) #Salvar o tamanho na lista de animacoes

#Flying kick (voadora)
#voadora2, voadora1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 80(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 8 #dx
	li t2, -16 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, 8 #dx
	li t2, -8 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, voadora1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, -8 #dx
	li t2, 8 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, voadora2 #t0=endereco da imagem
	li t1, -8 #dx
	li t2, 16 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 84(a1) #Salvar o tamanho na lista de animacoes

#High back Kick (Chute alto pra trás)
#prepvoltachuteatras, misc2, chutetras
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 88(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, prepvoltachuteatras #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, misc2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, chuteatras #t0=endereco da imagem
	li t1, -12 #dx
	li t2, 2 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, misc2 #t0=endereco da imagem
	li t1, 12 #dx
	li t2, -2 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 92(a1) #Salvar o tamanho na lista de animacoes

#Round House (Chute giratorio)
#chutegirando 1 a 7 
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 96(a1) #a4 = endereco de inicio da animacao #####################################
	####Separacao de frame
	la t0, chutegirando1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, chutegirando2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, chutegirando3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, chutegirando4 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, chutegirando5 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
	####Separacao de frame
	la t0, chutegirando6 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 60(a4) #img
	sw t2, 64(a4) #dx
	sw t0, 68(a4) #dy
	####Separacao de frame
	la t0, chutegirando7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 72(a4) #img
	sw t2, 76(a4) #dx
	sw t0, 80(a4) #dy
		
	li t0, 7 #t0 = tamahno da animacao
	sw t0, 100(a1) #Salvar o tamanho na lista de animacoes

#Backwards sweep (Rasteira pra trás)
#defesasentado, prepvoltchuteinferior, chuteesquerdabaixo
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 104(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, prepvoltchuteinferior #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, chuteesquerdabaixo #t0=endereco da imagem
	li t1, -20 #dx
	li t2, 10 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, prepvoltchuteinferior #t0=endereco da imagem
	li t1, 20 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy	 
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 108(a1) #Salvar o tamanho na lista de animacoes

#Forward sweep (Rasteira pra frente)
#defesasentado, chutedireitabaixo
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 112(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, chutedireitabaixo #t0=endereco da imagem
	li t1, -20 #dx
	li t2, 10 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, defesasentado #t0=endereco da imagem
	li t1, 20 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy	
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 116(a1) #Salvar o tamanho na lista de animacoes

#Short jab kick (Chute baixo)
#highkick1, chuteinferior
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 120(a1) #a4 = endereco de inicio da animacao
####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, chuteinferior #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy

		
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 124(a1) #Salvar o tamanho na lista de animacoes

#Idle
#Andar7
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 128(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
		
	li t0, 1 #t0 = tamahno da animacao
	sw t0,132(a1) #Salvar o tamanho na lista de animacoes

#saudacao inicial
#curvar1, curvar2, curvar1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 136(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, curvar1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, curvar2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, curvar2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, curvar1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 140(a1) #Salvar o tamanho na lista de animacoes

#Saudacao final
#ola1, ola2, ola3, ola4
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 144(a1) #a4 = endereco de inicio da animacao
####Separacao de frame
	la t0, ola1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, ola2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, ola3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, ola4 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, ola3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 148(a1) #Salvar o tamanho na lista de animacoes
	
	
	
########################################################
	#Animacoes enemy
	la a1, AnimacoesEnemy #a1= endereï¿½o da lista de animacoes do enemy
	
	la a3, Enemy #Setar primeira imagem enemy
	la t0, P2andar7 #t0=endereï¿½o da imagem
	sw t0, 12(a3) #Img0 = t0
	
#Andar
#andar6, andar5, andar6
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la t0, P2andar6 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	li t1, 16 #dx
	sw t1, 12(a4)
	la t0, P2andar5 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, P2andar6 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 4(a1) #Salvar o tamanho na lista de animacoes
#High Punch (Soco Alto)
#jab1,jab2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 8(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la t0, P2jab1 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	la t0, P2jab2 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, P2jab1 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 12(a1) #Salvar o tamanho na lista de animacoes
#Jump
#voadora2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 16(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -4 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 4 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 32 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 20(a1) #Salvar o tamanho na lista de animacoes

#Forward somersault (Cambalhota)
#cambalhota1, cambalhota 2, misc1, cambalhota3
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 24(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2cambalhota1 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2cambalhota2 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, -16 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2misc1 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, 16 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2cambalhota3 #t0=endereco da imagem
	li t1, 16 #dx
	li t2, 32 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 28(a1) #Salvar o tamanho na lista de animacoes
#Walk Back (Mesmo do Andar)
#andar6, andar5 andar6
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 32(a1) #a4 = endereco de inicio da animacao
	la t0, P2andar6 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	li t1, -16 #dx
	sw t1, 12(a4)
	la t0, P2andar5 #t0=endereco da imagem
	sw t0, 20(a4) #Salvar imagem no frame da animacao
	la t0, P2andar6 #t0=endereco da imagem
	sw t0, 32(a4) #Salvar imagem no frame da animacao
	
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 4(a1) #Salvar o tamanho na lista de animacoes
#Back Somersault (cambalhota para trás)
#cambalhota3, misc1, cambalhota2, cambalhota1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 40(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2cambalhota3 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, -32 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2misc1 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, -16 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2cambalhota2 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, 16 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2cambalhota1 #t0=endereco da imagem
	li t1, -16 #dx
	li t2, 32 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 44(a1) #Salvar o tamanho na lista de animacoes
#Crouch (Agaixar)
#defesasentado
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 48(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 52(a1) #Salvar o tamanho na lista de animacoes
#jab (Soco médio) Pra gente vai ser soco baixo
#jab1, socoacachado
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 56(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2jab1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2socoagachado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 12 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2jab1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -12 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
		
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 60(a1) #Salvar o tamanho na lista de animacoes
	
#Mid Kick (Chute Médio)
#highkick1, chutegirando7, midkick
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 64(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2chutegirando1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2midkick #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 68(a1) #Salvar o tamanho na lista de animacoes

#High Kick (Chute Alto)
#highkick1, chutediagonalcima, highkick2
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 72(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2chutediagonacima #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2highkick2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 76(a1) #Salvar o tamanho na lista de animacoes

#Flying kick (voadora)
#voadora2, voadora1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 80(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 8 #dx
	li t2, -16 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, 8 #dx
	li t2, -8 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2voadora1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, -8 #dx
	li t2, 8 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, P2voadora2 #t0=endereco da imagem
	li t1, -8 #dx
	li t2, 16 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 84(a1) #Salvar o tamanho na lista de animacoes

#High back Kick (Chute alto pra trás)
#prepvoltachuteatras, misc2, chutetras
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 88(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2prepvoltachuteatras #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2misc2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2chuteatras #t0=endereco da imagem
	li t1, -12 #dx
	li t2, 2 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2misc2 #t0=endereco da imagem
	li t1, 12 #dx
	li t2, -2 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 92(a1) #Salvar o tamanho na lista de animacoes

#Round House (Chute giratorio)
#chutegirando 1 a 7 
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 96(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2chutegirando1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2chutegirando2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2chutegirando3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2chutegirando4 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, P2chutegirando5 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
	####Separacao de frame
	la t0, P2chutegirando6 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 60(a4) #img
	sw t2, 64(a4) #dx
	sw t0, 68(a4) #dy
	####Separacao de frame
	la t0, P2chutegirando7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 72(a4) #img
	sw t2, 76(a4) #dx
	sw t0, 80(a4) #dy
		
	li t0, 7 #t0 = tamahno da animacao
	sw t0, 100(a1) #Salvar o tamanho na lista de animacoes

#Backwards sweep (Rasteira pra trás)
#defesasentado, prepvoltchuteinferior, chuteesquerdabaixo
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 104(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2prepvoltchuteinferior #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2chuteesquerdabaixo #t0=endereco da imagem
	li t1, 20 #dx
	li t2, 10 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2prepvoltchuteinferior #t0=endereco da imagem
	li t1, -20 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy
	####Separacao de frame	
	la t0, P2andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy	
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 108(a1) #Salvar o tamanho na lista de animacoes

#Forward sweep (Rasteira pra frente)
#defesasentado, chutedireitabaixo
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 112(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 10 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2chutedireitabaixo #t0=endereco da imagem
	li t1, 20 #dx
	li t2, 10 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2defesasentado #t0=endereco da imagem
	li t1, -20 #dx
	li t2, -10 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, P2andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, -10 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy	
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 116(a1) #Salvar o tamanho na lista de animacoes

#Short jab kick (Chute baixo)
#highkick1, chuteinferior
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 120(a1) #a4 = endereco de inicio da animacao
####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2chuteinferior #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2highkick1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy

		
	li t0, 3 #t0 = tamahno da animacao
	sw t0, 124(a1) #Salvar o tamanho na lista de animacoes

#Idle
#Andar7
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 128(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2andar7 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
		
	li t0, 1 #t0 = tamahno da animacao
	sw t0,132(a1) #Salvar o tamanho na lista de animacoes

#saudacao inicial
#curvar1, curvar2, curvar1
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 136(a1) #a4 = endereco de inicio da animacao
	####Separacao de frame
	la t0, P2curvar1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2curvar2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 12(a4) #img
	sw t2, 16(a4) #dx
	sw t0, 20(a4) #dy
	####Separacao de frame
	la t0, P2curvar2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2curvar1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
		
	li t0, 4 #t0 = tamahno da animacao
	sw t0, 140(a1) #Salvar o tamanho na lista de animacoes

#Saudacao final
#ola1, ola2, ola3, ola4
	li t4, 12
	mul t4, t4, t0
	add a4, a4, t4 #a4=endereço de início da proxima animacao
	sw a4, 144(a1) #a4 = endereco de inicio da animacao
####Separacao de frame
	la t0, P2ola1 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 0(a4) #img
	sw t2, 4(a4) #dx
	sw t0, 8(a4) #dy	
	####Separacao de frame
	la t0, P2ola2 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t0, 12(a4) #img
	sw t1, 16(a4) #dx
	sw t2, 20(a4) #dy
	####Separacao de frame
	la t0, P2ola3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 24(a4) #img
	sw t2, 28(a4) #dx
	sw t0, 32(a4) #dy
	####Separacao de frame
	la t0, P2ola4 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 36(a4) #img
	sw t2, 40(a4) #dx
	sw t0, 44(a4) #dy	
	####Separacao de frame
	la t0, P2ola3 #t0=endereco da imagem
	li t1, 0 #dx
	li t2, 0 #dy
	sw t1, 48(a4) #img
	sw t2, 52(a4) #dx
	sw t0, 56(a4) #dy
		
	li t0, 5 #t0 = tamahno da animacao
	sw t0, 148(a1) #Salvar o tamanho na lista de animacoes
	
.end_macro
