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
	la a5, DadosAnimacoesPlayer
	
	la a3, Player #Setar primeira imagem player
	la t0, ola1 #t0=endereï¿½o da imagem
	sw t0, 12(a3) #Img0 = t0
	
#Andar
#andar6, andar5, andar6
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)

        li t0, 3 #estado
        sw t0, 0(a5)
        li t0, 0 #alvo
        sw t0, 4(a5)
        li t0, 0 #framehit
        sw t0, 8(a5)
        li t0, 0 #x0
        sw t0, 12(a5)
        li t0, 0 #xf
        sw t0, 16(a5)

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
	
        li t0, 3 #estado
        sw t0, 24(a5)
        li t0, 0 #alvo
        sw t0, 28(a5)
        li t0, 0 #framehit
        sw t0, 32(a5)
        li t0, 0 #x0
        sw t0, 36(a5)
        li t0, 0 #xf
        sw t0, 40(a5)
	
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
	
        li t0, 2 #estado
        sw t0, 48(a5)
        li t0, 0 #alvo
        sw t0, 52(a5)
        li t0, 0 #framehit
        sw t0, 56(a5)
        li t0, 0 #x0
        sw t0, 60(a5)
        li t0, 0 #xf
        sw t0, 64(a5)

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
	
        li t0, 4 #estado
        sw t0, 72(a5)
        li t0, 0 #alvo
        sw t0, 76(a5)
        li t0, 0 #framehit
        sw t0, 80(a5)
        li t0, 0 #x0
        sw t0, 84(a5)
        li t0, 0 #xf
        sw t0, 88(a5)

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
	
        li t0, 0 #estado
        sw t0, 96(a5)
        li t0, 0 #alvo
        sw t0, 100(a5)
        li t0, 0 #framehit
        sw t0, 104(a5)
        li t0, 0 #x0
        sw t0, 108(a5)
        li t0, 0 #xf
        sw t0, 112(a5)
	
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
	
        li t0, 4 #estado
        sw t0, 120(a5)
        li t0, 0 #alvo
        sw t0, 124(a5)
        li t0, 0 #framehit
        sw t0, 128(a5)
        li t0, 0 #x0
        sw t0, 132(a5)
        li t0, 0 #xf
        sw t0, 136(a5)

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
	
        li t0, 1 #estado
        sw t0, 144(a5)
        li t0, 0 #alvo
        sw t0, 148(a5)
        li t0, 0 #framehit
        sw t0, 152(a5)
        li t0, 0 #x0
        sw t0, 156(a5)
        li t0, 0 #xf
        sw t0, 160(a5)

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
	
        li t0, 1 #estado
        sw t0, 168(a5)
        li t0, 0 #alvo
        sw t0, 172(a5)
        li t0, 0 #framehit
        sw t0, 176(a5)
        li t0, 0 #x0
        sw t0, 180(a5)
        li t0, 0 #xf
        sw t0, 184(a5)

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
	
	li t0, 3 #estado
        sw t0, 192(a5)
        li t0, 0 #alvo
        sw t0, 196(a5)
        li t0, 0 #framehit
        sw t0, 200(a5)
        li t0, 0 #x0
        sw t0, 204(a5)
        li t0, 0 #xf
        sw t0, 208(a5)

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
	
	li t0, 3 #estado
        sw t0, 216(a5)
        li t0, 0 #alvo
        sw t0, 220(a5)
        li t0, 0 #framehit
        sw t0, 224(a5)
        li t0, 0 #x0
        sw t0, 228(a5)
        li t0, 0 #xf
        sw t0, 232(a5)
	
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
	
	li t0, 4 #estado
        sw t0, 240(a5)
        li t0, 0 #alvo
        sw t0, 244(a5)
        li t0, 0 #framehit
        sw t0, 248(a5)
        li t0, 0 #x0
        sw t0, 252(a5)
        li t0, 0 #xf
        sw t0, 256(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 264(a5)
        li t0, 0 #alvo
        sw t0, 268(a5)
        li t0, 0 #framehit
        sw t0, 272(a5)
        li t0, 0 #x0
        sw t0, 276(a5)
        li t0, 0 #xf
        sw t0, 280(a5)
	
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
	sw a4, 96(a1) #a4 = endereco de inicio da animacao 
	
	li t0, 3 #estado
        sw t0, 288(a5)
        li t0, 0 #alvo
        sw t0, 292(a5)
        li t0, 0 #framehit
        sw t0, 296(a5)
        li t0, 0 #x0
        sw t0, 300(a5)
        li t0, 0 #xf
        sw t0, 304(a5)
        
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

	li t0, 1 #estado
        sw t0, 312(a5)
        li t0, 0 #alvo
        sw t0, 316(a5)
        li t0, 0 #framehit
        sw t0, 320(a5)
        li t0, 0 #x0
        sw t0, 324(a5)
        li t0, 0 #xf
        sw t0, 328(a5)

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
	
	li t0, 1 #estado
        sw t0, 336(a5)
        li t0, 0 #alvo
        sw t0, 340(a5)
        li t0, 0 #framehit
        sw t0, 344(a5)
        li t0, 0 #x0
        sw t0, 348(a5)
        li t0, 0 #xf
        sw t0, 352(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 360(a5)
        li t0, 0 #alvo
        sw t0, 364(a5)
        li t0, 0 #framehit
        sw t0, 368(a5)
        li t0, 0 #x0
        sw t0, 372(a5)
        li t0, 0 #xf
        sw t0, 376(a5)
        
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
	
	li t0, 3 #estado
        sw t0, 384(a5)
        li t0, 0 #alvo
        sw t0, 388(a5)
        li t0, 0 #framehit
        sw t0, 392(a5)
        li t0, 0 #x0
        sw t0, 396(a5)
        li t0, 0 #xf
        sw t0, 400(a5)
        
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
	
	li t0, 0 #estado
        sw t0, 408(a5)
        li t0, 0 #alvo
        sw t0, 412(a5)
        li t0, 0 #framehit
        sw t0, 416(a5)
        li t0, 0 #x0
        sw t0, 420(a5)
        li t0, 0 #xf
        sw t0, 424(a5)
        
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
	
	li t0, 0 #estado
        sw t0, 432(a5)
        li t0, 0 #alvo
        sw t0, 436(a5)
        li t0, 0 #framehit
        sw t0, 440(a5)
        li t0, 0 #x0
        sw t0, 444(a5)
        li t0, 0 #xf
        sw t0, 448(a5)
        
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
	la a5, DadosAnimacoesPlayer
	
	la a3, Enemy #Setar primeira imagem enemy
	la t0, P2andar7 #t0=endereï¿½o da imagem
	sw t0, 12(a3) #Img0 = t0
	
#Andar
#andar6, andar5, andar6
	lw a4, 0(a1) #a4 = endereco de inicio da primeira animacao (Saudacao)
	la t0, P2andar6 #t0=endereco da imagem
	sw t0, 8(a4) #Salvar imagem no frame da animacao
	
        li t0, 3 #estado
        sw t0, 0(a5)
        li t0, 0 #alvo
        sw t0, 4(a5)
        li t0, 0 #framehit
        sw t0, 8(a5)
        li t0, 0 #x0
        sw t0, 12(a5)
        li t0, 0 #xf
        sw t0, 16(a5)
        
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
	
	li t0, 3 #estado
        sw t0, 24(a5)
        li t0, 0 #alvo
        sw t0, 28(a5)
        li t0, 0 #framehit
        sw t0, 32(a5)
        li t0, 0 #x0
        sw t0, 36(a5)
        li t0, 0 #xf
        sw t0, 40(a5)
        
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
	
        li t0, 2 #estado
        sw t0, 48(a5)
        li t0, 0 #alvo
        sw t0, 52(a5)
        li t0, 0 #framehit
        sw t0, 56(a5)
        li t0, 0 #x0
        sw t0, 60(a5)
        li t0, 0 #xf
        sw t0, 64(a5)
        
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
	
        li t0, 4 #estado
        sw t0, 72(a5)
        li t0, 0 #alvo
        sw t0, 76(a5)
        li t0, 0 #framehit
        sw t0, 80(a5)
        li t0, 0 #x0
        sw t0, 84(a5)
        li t0, 0 #xf
        sw t0, 88(a5)
        
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
	
	li t0, 0 #estado
        sw t0, 96(a5)
        li t0, 0 #alvo
        sw t0, 100(a5)
        li t0, 0 #framehit
        sw t0, 104(a5)
        li t0, 0 #x0
        sw t0, 108(a5)
        li t0, 0 #xf
        sw t0, 112(a5)
	
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
	
        li t0, 4 #estado
        sw t0, 120(a5)
        li t0, 0 #alvo
        sw t0, 124(a5)
        li t0, 0 #framehit
        sw t0, 128(a5)
        li t0, 0 #x0
        sw t0, 132(a5)
        li t0, 0 #xf
        sw t0, 136(a5)
	
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
	
        li t0, 1 #estado
        sw t0, 144(a5)
        li t0, 0 #alvo
        sw t0, 148(a5)
        li t0, 0 #framehit
        sw t0, 152(a5)
        li t0, 0 #x0
        sw t0, 156(a5)
        li t0, 0 #xf
        sw t0, 160(a5)
	
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
	
	li t0, 1 #estado
        sw t0, 168(a5)
        li t0, 0 #alvo
        sw t0, 172(a5)
        li t0, 0 #framehit
        sw t0, 176(a5)
        li t0, 0 #x0
        sw t0, 180(a5)
        li t0, 0 #xf
        sw t0, 184(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 192(a5)
        li t0, 0 #alvo
        sw t0, 196(a5)
        li t0, 0 #framehit
        sw t0, 200(a5)
        li t0, 0 #x0
        sw t0, 204(a5)
        li t0, 0 #xf
        sw t0, 208(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 216(a5)
        li t0, 0 #alvo
        sw t0, 220(a5)
        li t0, 0 #framehit
        sw t0, 224(a5)
        li t0, 0 #x0
        sw t0, 228(a5)
        li t0, 0 #xf
        sw t0, 232(a5)
	
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
	
	li t0, 4 #estado
        sw t0, 240(a5)
        li t0, 0 #alvo
        sw t0, 244(a5)
        li t0, 0 #framehit
        sw t0, 248(a5)
        li t0, 0 #x0
        sw t0, 252(a5)
        li t0, 0 #xf
        sw t0, 256(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 264(a5)
        li t0, 0 #alvo
        sw t0, 268(a5)
        li t0, 0 #framehit
        sw t0, 272(a5)
        li t0, 0 #x0
        sw t0, 276(a5)
        li t0, 0 #xf
        sw t0, 280(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 288(a5)
        li t0, 0 #alvo
        sw t0, 292(a5)
        li t0, 0 #framehit
        sw t0, 296(a5)
        li t0, 0 #x0
        sw t0, 300(a5)
        li t0, 0 #xf
        sw t0, 304(a5)
	
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
	
	li t0, 1 #estado
        sw t0, 312(a5)
        li t0, 0 #alvo
        sw t0, 316(a5)
        li t0, 0 #framehit
        sw t0, 320(a5)
        li t0, 0 #x0
        sw t0, 324(a5)
        li t0, 0 #xf
        sw t0, 328(a5)
	
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
	
	li t0, 1 #estado
        sw t0, 336(a5)
        li t0, 0 #alvo
        sw t0, 340(a5)
        li t0, 0 #framehit
        sw t0, 344(a5)
        li t0, 0 #x0
        sw t0, 348(a5)
        li t0, 0 #xf
        sw t0, 352(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 360(a5)
        li t0, 0 #alvo
        sw t0, 364(a5)
        li t0, 0 #framehit
        sw t0, 368(a5)
        li t0, 0 #x0
        sw t0, 372(a5)
        li t0, 0 #xf
        sw t0, 376(a5)
	
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
	
	li t0, 3 #estado
        sw t0, 384(a5)
        li t0, 0 #alvo
        sw t0, 388(a5)
        li t0, 0 #framehit
        sw t0, 392(a5)
        li t0, 0 #x0
        sw t0, 396(a5)
        li t0, 0 #xf
        sw t0, 400(a5)
        
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
	
	li t0, 0 #estado
        sw t0, 408(a5)
        li t0, 0 #alvo
        sw t0, 412(a5)
        li t0, 0 #framehit
        sw t0, 416(a5)
        li t0, 0 #x0
        sw t0, 420(a5)
        li t0, 0 #xf
        sw t0, 424(a5)
        
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
	
	li t0, 0 #estado
        sw t0, 432(a5)
        li t0, 0 #alvo
        sw t0, 436(a5)
        li t0, 0 #framehit
        sw t0, 440(a5)
        li t0, 0 #x0
        sw t0, 444(a5)
        li t0, 0 #xf
        sw t0, 448(a5)
	
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
