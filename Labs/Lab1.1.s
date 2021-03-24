.data

x: .word 1
y: .word 1
z: .word 0
i: .word 1
num: .zero 40
		
.text

lw x11, x
lw x12, y
lw x13, z
lw x15, i
la x14,num
sw x12, 0(x14)
li x16, 10

for:
addi x14,x14,4
sw x12, 0(x14)
mv x13,x12
add x12,x11,x12
mv x11,x13
addi x15,x15,1
blt x15,x16,for

li x17,10
ecall