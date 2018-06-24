.data

.text
	main:
		#Creando la pila
		addi $s0, $zero, 1 #2 elementos
		addi $t0, $zero, 5 #elemento 1
		addi $t1, $zero, 3 #elemento 2
		sw $t0, 0($sp)
		#sw $t1, 4($sp)	
		
		add $a0, $s0, $zero
		#lw $t2, 0($sp)
		add $a1, $zero, $sp
		addi $a2, $zero, 3
		jal push
	
		lw $t2, ($sp)
		add $a1, $zero, $t2
		lw $t3, 4($sp)
		add $a2, $zero, $t3
	
		jal suma
		
		li $v0, 1
		add $a0, $v1, 0	
		syscall
		
		
		li $v0, 10	
		syscall
		
	suma:		
		add $v1, $a1, $a2
		jr $ra  #return
	
	push:	 
		add $s0, $a1, $zero
		addi $t0, $zero, 0
		loop:
			bge $t0, $a0, exit
			addi $s0, $s0, 4
			addi $t0, $t0, 1
			j loop
		exit:
			sw $a2, ($s0)
			addi $a0, $a0, 1			
			
    	
		jr $ra
