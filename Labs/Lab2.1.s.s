 .data
a: .word 1  #int a
b: .word 1 	#int b
c: .word 0 	#int c
d: .word 0	#int d
y: .word 0	#int y


.text

rede_neuronal_xor:
la a1,c	#load adress do C em a1
la a2,d	#load adress do D em a2
la a3,y	#load adress do Y em a3
lw x19,a #load do valor de a em x19
lw x20,b	#load do valor de b em x20
li a4,2	#load do 2
li a5,-2	 #load do -2
jal x1,neuronio #c = neuronio(a,b,2,-2,-1)
li a4,-2
li a5,2
sw x10,0(a1) #store do valor de C
jal x1,neuronio #d = neuronio(a,b,-2,2,-1)
sw x10,0(a2)#store do valor de D
lw x19,0(a1)#load do valor de C
lw x20,0(a2)#load do valor de D
li a4,2
li a5,2
jal x1,neuronio #y = neuronio(c,d,2,2,-1)
sw x10,0(a3) #store do valor de Y

end:
li x17, 1
ecall

li x17, 10
ecall

neuronio:

addi sp,sp,-12 #inicializa a pilha
sw x1,8(sp)	 #push na pilha do valor em x1
sw x19,4(sp)	#push na pilha do valor em x19 = x1
sw a4,0(sp)		#push na pilha do valor em a4 = w1
jal x1,multiplica #chama a função multiplica
lw x19,4(sp) #pop do valor da primeira multiplicação em x19
sw x20,4(sp) #push do valor de x2 em x1
sw a5,0(sp) #push do valor de w2 onde estava w1
jal x1,multiplica #chama a função multiplica
lw x23, 4(sp) #pop do valor da segunda multiplicação em x23
lw x0,0(sp) #pop do valor
lw x1,8(sp) #pop do valor para regressar à rede_neuronal_xor
add x10,x19,x23 #soma o x1*v1 com x2*v2
addi x10,x10,-1 # calcula o valor de S

addi x2, x2, 12 #terminar a pilha
bgez x10,if #se forx maior ou igual a zero dá jump para o if
li x10,0 #else
jalr x0,x1,0 #return do valor
if:
li x10,1
jalr x0,x1,0 #return do valor

multiplica:
lw t0,4(sp) #pop do valor em x1/x2
lw t1,0(sp) #pop do valor em w1/w2
li x16,0 
bgtz t1,soma #se o w1/w2 for positivo dá jump para a soma, caso contrario, nega tudo para tornar o valor em Wx positivo e o loop funcionar corretamente 
neg t1,t1
neg t0,t0

soma:
add x16,t0,x16 #soma do x1/x2 2 vezes
addi t1,t1,-1 #trivial  
bgtz t1,soma #enquanto o t1 não for 0, t0 soma-se a si mesmo e armazena o valor em x16 
sw x16,4(sp) #push do valor em x16 na pilha
jalr x0,x1,0 #return para neuronio