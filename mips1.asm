.data
	enter: .byte '\n'
.text
	main:
		#Creando la pila
		addi $s0, $zero, 1 #tamaño = 1
		add $s1, $zero, $sp 	#mi pila estara en s1
		addi $t0, $zero, 5 #elemento 1
		sw $t0, 0($s1)	#guardo el 5 en la pila		
		
		#añadiendo el 3 a la pila
		add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
		add $a1, $zero, $s1  #argumento a1 la pila
		addi $a2, $zero, 3   #argumento a2 el numero a agregar
		jal push			 #llamando push
		
		#altura		
		add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
		jal altura
		
		#sumando
		lw $t2, ($s1)
		add $a1, $zero, $t2		
		lw $t3, 4($s1)
		add $a2, $zero, $t3	
		jal suma
		
		#pop
		add $a0, $zero, $s0		
		add $a1, $zero, $s1	
		jal pop
		
		
		li $v0, 10	
		syscall
		
	suma:		
		add $v1, $a1, $a2
		li $v0, 1
		add $a0, $v1, 0	
		syscall
		#Imprimir un salto de linea
		li $v0, 4	
		la $a0, enter
		syscall
		
		jr $ra
	
	push:	 
		add $t1, $a1, $zero  #copiando la pila a t1
		addi $t0, $zero, 0   #la i=0 para el for
		loop:
			bge $t0, $a0, exit  #for de 0 al tamaño de la pila
			addi $t1, $t1, 4    #sumo 4 al puntero de la pila
			addi $t0, $t0, 1 	# i++
			j loop
		exit:			
			sw $a2, ($t1)		#agrego el numero al final de la pila
			addi $s0, $a0, 1	#tamaño++	
			
		jr $ra
		
	pop:	 
		add $t1, $a1, $zero  #copiando la pila a t1
		addi $t0, $zero, 0   #la i=0 para el for
		addi $s0, $a0, -1	#tamaño--		
		loop2:
			bge $t0, $s0, exit2  #for de 0 al tamaño de la pila -1
			addi $t1, $t1, 4    #sumo 4 al puntero de la pila
			addi $t0, $t0, 1 	# i++
			j loop2
		exit2:		
			lw $v1, ($t1)		#retorno el elemento que sacare
			sw $zero, ($t1)		#convierto en 0 el ultimo elemento		
			#Imprimir el elemento que saque
			li $v0, 1
			add $a0, $zero, $v1	
			syscall			
			#Imprimir un salto de linea
			li $v0, 4	
			la $a0, enter
			syscall
    	
		jr $ra
		
	altura:
		#Imprimir $a0 que es eargumento del tamaño
		li $v0, 1	
		add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
		syscall
		#Imprimir un salto de linea
		li $v0, 4	
		la $a0, enter
		syscall
		
		jr $ra
