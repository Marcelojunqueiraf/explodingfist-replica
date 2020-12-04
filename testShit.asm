.data
OI:
.text
	li t0, 0x12345678
	la t1, OI
	sw t0, (t1)
	lb t0, (t1)
