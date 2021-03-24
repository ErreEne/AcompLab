#i! + 3^i
.data

num: .zero 40
a: .word 1
i: .word 1


.text
li x11,1
lw x12,i
li x14,1
mv x16,x12
lw x18,num
li x20, 2
sw x20, 0(x18)
li x10, 3
li x19,10
li x13,1

fatorial:
mul x14,x16,x14
sub x16,x16,x13
mul x11,x11,x10
add x20, x11,x14
addi x12,x12,1
sw x20, 4(x18)
addi x18,x18,4
mv x16,x12

bgt x12,x19,end
blt x12, x19, fatorial

end:
li x17,10
ecall
