.data
a: .word 1
b: .word 1
c: .word 0 
d: .word 0
y: .word 0


.text

rede_neuronal_xor:
la a1,c
la a2,d
la a3,y
lw x19,a
lw x20,b
li a4,2
li a5,-2
jal x1,neuronio
li a4,-2
li a5,2
sw x10,0(a1)
jal x1,neuronio
sw x10,0(a2)
lw x19,0(a1)
lw x20,0(a2)
li a4,2
li a5,2
jal x1,neuronio
sw x10,0(a3)

li x17, 1
ecall

li x17, 10
ecall

neuronio:
addi sp,sp,-12
sw x1,8(sp)
sw x19,4(sp)
sw a4,0(sp)
jal x1,multiplica
lw x19,4(sp) #armazenar o valor da primeira soma em a
sw x20,4(sp) #store do valor de b onde estava o a
sw a5,0(sp) #store do valor de -2 onde estava 2
jal x1,multiplica
lw x23, 4(sp)
lw x0,0(sp)
lw x1,8(sp)
add x10,x19,x23
addi x10,x10,-1

addi x2, x2, 12
bgez x10,queromorrer
li x10,0
jalr x0,x1,0
queromorrer:
li x10,1
jalr x0,x1,0

multiplica:
lw t0,4(sp)
lw t1,0(sp)
li x16,0
bgtz t1,soma
neg t1,t1
neg t0,t0

soma:
add x16,t0,x16
addi t1,t1,-1
bgtz t1,soma
sw x16,4(sp)
jalr x0,x1,0
