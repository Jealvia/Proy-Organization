.data

.text
	main:
		#Creando la pila
		addi $s0, $zero, 1 #tamaño = 1
		addi $t0, $zero, 5 #elemento 1
		sw $t0, 0($sp)	#guardo el 5 en la pila
		
		#añadiendo el 3 a la pila
		add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
		add $a1, $zero, $sp  #argumento a1 la pila
		addi $a2, $zero, 3   #argumento a2 el numero a agregar
		jal push			 #llamando push
		
		
		#sumando
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
		jr $ra
	
	push:	 
		add $s0, $a1, $zero  #copiando la pila a s0
		addi $t0, $zero, 0   #la i=0 para el for
		loop:
			bge $t0, $a0, exit  #for de 0 al tamaño de la pila
			addi $s0, $s0, 4    #sumo 4 al puntero de la pila
			addi $t0, $t0, 1 	# i++
			j loop
		exit:
			sw $a2, ($s0)		#agrego el numero al final de la pila
			addi $a0, $a0, 1	#tamaño++		
			
    	
		jr $ra
		
	pop:	 
		add $s0, $a1, $zero  #copiando la pila a s0
		addi $t0, $zero, 0   #la i=0 para el for
		addi $a0, $a0, -1	#tamaño--
		loop2:
			bge $t0, $a0, exit2  #for de 0 al tamaño de la pila -1
			addi $s0, $s0, 4    #sumo 4 al puntero de la pila
			addi $t0, $t0, 1 	# i++
			j loop
		exit2:
			lw $v1, ($s0)		#retorno el elemento que sacare
			sw $zero, ($s0)		#convierto en 0 el ultimo elemento					
    	
		jr $ra
