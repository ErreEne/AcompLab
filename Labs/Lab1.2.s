.data
num: .zero 44

.text

li x10,0
li x11,5
la x12, num
li x13, 3
li x14, 3
li x9,10

sw x13, 0(x12)

while:
addi x12,x12,4
addi x10,x10,1
mul x14,x14,x13
mul x15,x10,x11
add x16,x14,x15
sw x16,0(x12)
bge x9,x10,while

li x17, 10
ecall