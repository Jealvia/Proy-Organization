.data

.text
	main:
		#Creando la pila
		addi $s0, $zero, 2 #2 elementos
		addi $t0, $zero, 5 #elemento 1
		addi $t1, $zero, 3 #elemento 2
		sw $t0, ($sp)
		sw $t1, 4($sp)	
	
		lw $t2, ($sp)
		add $a1, $zero, $t2
		addi $t4, $zero, 4
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
    	
		sw $a1, ($sp)
		
		jr $ra
