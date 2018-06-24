.data
	enter:	.byte '\n'
	menuGeneral: .asciiz "\n1.Agregar elemento \n2.Sacar elemento \n3.Numero de elemntos \n4.Operaciones con dos elementos de una pila (El resultado se reingresa en la pila)\n5.Mostrar pila\n6.Salir\nIngrese una opcion: "
	ingreso:  .asciiz "Ingese valor: "
	faltanElemento: .asciiz "Numero de elementos en la pila insuficiente para realizar la operacion"
	menuOperaciones:   .asciiz "\n1.Sumar\n2.Restar\n3.Multiplicar\n4.Dividir\nIngrese una opcion: "
	opcionInvalida:   .asciiz "Ingrese una opcion valida"
	pilaVacia:   .asciiz "La pila esta vacia"
	coma:   .asciiz "; "
	mas: .asciiz   "+"
	menos: .asciiz "-"
	igual: .asciiz "="
	por: .asciiz "x"
	divisio:   .asciiz "/"
.text
	main:
		#Creando la pila
		
		addi $s0, $zero, 0 	#tamaño = 0
		add $s1, $zero, $sp 	#mi pila estara en s1
		addi $s2, $zero,0  	#bandera=0	
		while: #Se inicializa el main
			bnez $s2,exit   #Se valida la condicion de salida si bandera no es igual a 0
				#Se muestra el menu general
				li $v0,4
				la $a0,menuGeneral
				syscall
				#Se recibe la entrada del usuario
				li $v0,5 
				syscall
				#Se almacena el ingreso del usuario en t0
				add $t0,$v0,$zero 
				#Comienzo del menu con los casos
				bne $t0,1,case1 #Se valida si el ingreso no es igual a 1
				   #Inicio caso 1 si el valor es igual a 1
				   #Se muestra al usuario que ingrese valor
				   li $v0,4
  				   la $a0,ingreso
				   syscall					
				   #Se recibe el valor del usario
				   li $v0,5 
				   syscall
				   #Se instancian los valores de la funcion
				   add $a0, $s0, $zero  #argumento a0 el numero de elementos de la pila
				   add $a1, $zero, $s1  #argumento a1 la pila
				   add $a2, $zero, $v0  #argumento a2 el numero a agregar
				   jal push		#llamando push
				   j while		#Se retorna al while
				case1:			#Si no es igual a 1 ingresa aqui
				   bne $t0,2,case2 	#Se valida si el ingreso no es igual a 2
				      beqz $s0,mensaje1	#Se valida si la pila no tiene al menos un elemento
				         #Se instancian los valores de la funcion
				         add $a0, $zero, $s0	#argumento a0 el numero de elementos de la pila	
					 add $a1, $zero, $s1	#argumento a1 la pila
 					 jal pop	#Llamada a funcion pop
 					 j while	#Se retorna al while
 					mensaje1:	#Si la pila no tiene al menos un elemento se muestra un mensaje
 					   li $v0,4
 					   la $a0,faltanElemento
 					   syscall
 					   j while	#Se retorna al while
 				case2:			#Si no es igual a 2 ingresa aqui
 				   bne $t0,3,case3 	#Se valida si el ingreso no es igual a 3
					#Se instancian los valores de la funcion
					add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
					jal altura	#Llamada a la funcion altura
					j while		#Se retorna al while
				case3:			#Si no es igual a 3 ingresa aqui
				   bne $t0,4,case4 	#Se valida si el ingreso no es igual a 4
				      ble $s0,1,faltElementos	#Se valida que exista por lo menos dos elementos
				         #Se muestra el menu de las operaciones
				         li $v0,4
				         la $a0,menuOperaciones
				         syscall
				         #Se recibe la entrada del usuario
				         li $v0,5 
				         syscall
				         add $t1,$v0,$zero #Se almacena el ingreso en t1
				      bne $t1,1,operacion1 #Se valida si no se ingreso 1
				        #Se instancian los valores de la funcion
				        add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t3, $zero, $a0	#Se agrega el elemento de la pila a t3
					#Se muestra el signo suma
					li $v0,4
					la $a0,mas
					syscall
					#Se instancian los valores de la funcion
					add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t4, $zero, $a0	#Se agrega el elemento de la pila a t4
					#Se muestra un igual
					li $v0,4
					la $a0,igual
					syscall
					#Se instancian los valores de la funcion
					add $a1,$zero,$t3	#argumento a1 valor a operar
					add $a2,$zero,$t4	#argumento a2 valor a operar				
					jal suma		#Llamada a la funcion suma
					#Se instancian los valores de la funcion
				   	add $a0, $s0, $zero  #argumento a0 el numero de elementos de la pila
				   	add $a1, $zero, $s1  #argumento a1 la pila
				   	add $a2, $zero, $v1  #argumento a2 el numero a agregar
				        jal push		#llamando push
					j while			#Se retorna al while
				      operacion1:
				      bne $t1,2,operacion2 #Se valida si no se ingreso 2
				        #Se instancian los valores de la funcion
				        add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t3, $zero, $a0	#Se agrega el elemento de la pila a t3
					#Se muestra un menos
					li $v0,4
					la $a0,menos
					syscall
					#Se instancian los valores de la funcion
					add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t4, $zero, $a0	#Se agrega el elemento de la pila a t4
					#Se muestra un igual
					li $v0,4
					la $a0,igual
					syscall
					#Se instancian los valores de la funcion
					add $a1,$zero,$t3	#argumento a1 valor a operar
					add $a2,$zero,$t4	#argumento a2 valor a operar
					jal resta		#Llamada a la funcion resta
					add $a0, $s0, $zero  #argumento a0 el numero de elementos de la pila
				   	add $a1, $zero, $s1  #argumento a1 la pila
				   	add $a2, $zero, $v1  #argumento a2 el numero a agregar
				        jal push		#llamando push
					j while			#Se retorna al while
				      operacion2:
				      bne $t1,3,operacion3 #Se valida si no se ingreso 3
				        #Se instancian los valores de la funcion
				        add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t3, $zero, $a0	#Se agrega el elemento de la pila a t3
					#Se muestra una x
					li $v0,4
					la $a0,por
					syscall
					#Se instancian los valores de la funcion
					add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t4, $zero, $a0	#Se agrega el elemento de la pila a t4
					#Se muestra un igual
					li $v0,4
					la $a0,igual
					syscall
					#Se instancian los valores de la funcion
					add $a1,$zero,$t3	#argumento a1 valor a operar
					add $a2,$zero,$t4	#argumento a2 valor a operar	
					jal multiplicacion	#se llama a la funcion multiplicacion
					add $a0, $s0, $zero  #argumento a0 el numero de elementos de la pila
				   	add $a1, $zero, $s1  #argumento a1 la pila
				   	add $a2, $zero, $v1  #argumento a2 el numero a agregar
				        jal push		#llamando push
					j while			#Se retorna al while
				      operacion3:
				      bne $t1,4,operacion4 #Se valida si no se ingreso 4
				        #Se instancian los valores de la funcion
				        add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t3, $zero, $a0	#Se agrega el elemento de la pila a t3
					#Se muestra una barrita de division
					li $v0,4
					la $a0,divisio
					syscall
					#Se instancian los valores de la funcion
					add $a0, $zero, $s0	#argumento a0 el num de elementos de la pila	
					add $a1, $zero, $s1	#argumento a1 la pila
 					jal pop			#Llamada a la funcion pop para extraer el 1er elemento de la pila
					add $t4, $zero, $a0	#Se agrega el elemento de la pila a t4
					#Se muestra un igual
					li $v0,4
					la $a0,igual
					syscall
					#Se instancian los valores de la funcion
					add $a1,$zero,$t3	#argumento a1 valor a operar
					add $a2,$zero,$t4	#argumento a2 valor a operar
					jal division		#Se llama a la funcion division
					add $a0, $s0, $zero  #argumento a0 el numero de elementos de la pila
				   	add $a1, $zero, $s1  #argumento a1 la pila
				   	add $a2, $zero, $v1  #argumento a2 el numero a agregar
				        jal push		#llamando push
					j while			#Se retorna al while
				      operacion4: 		#Si no se ingreso una opcion valida muestra mensaje
					#Se muestra el mensaje
					li $v0,4
					la $a0,opcionInvalida
					syscall
					j case3			#Regresa al menu de operaciones
				     faltElementos:		#Si no hay elementos suficientes muestra el respectivo mensaje
				        #Se muestra el mensaje
				        li $v0,4
				        la $a0,faltanElemento
				        syscall
				        j while			#Se retorna al while
				case4:
				   bne $t0,5,case5 		#Se valida si el ingreso no es igual a 5
				      blez $s0,elemInsuficiente	#Se valida si no hay elementos en la pila
				         #Se instancian los valores de la funcion
				         add $a0, $zero, $s0	#argumento a0 el numero de elementos de la pila		
					 add $a1, $zero, $s1	#argumento a1 la pila
			 		 jal mostrarPila	#Llamada a la funcion mostrar pila
			 		 j while		#Se retorna al while
			 	     elemInsuficiente:		#Si no hay ningun elemento se muesta el respectivo mensaje
			 	        #Se muestra el mensaje
			 	        li $v0,4
			 	        la $a0,pilaVacia
			 	        syscall
			 	        j while			#Se retorna al while
				case5:
				   bne $t0,6,case6 		#Se valida si el ingreso no es igual a 6
				      #Se inicia la salida del while
				      addi $s2,$s2,3		#Se cambia el valor de la bandera ahora igual a 3
				      j exitWhile		#Se sale del while
				case6:   			#Si no se ingresa una opcion valida muestra un mensaje
				   #Se muestra el mensaje
				   li $v0,4
			 	   la $a0,opcionInvalida
			 	   syscall
			 	   j while			#Se retorna al while													
		exitWhile:
		   #Se cierra el programa	
		   li $v0, 10	
		   syscall
		
		
	suma:		
		add $v1, $a1, $a2
		li $v0, 1
		add $a0, $v1, 0	
		syscall
		
		jr $ra
	
	resta:
		sub $v1, $a1, $a2
		li $v0, 1
		add $a0, $v1, 0	
		syscall
		
		jr $ra	
	
	multiplicacion:
		mul $v1, $a1, $a2
		li $v0, 1
		add $a0, $v1, 0	
		syscall
		
		jr $ra	
	
	division:
		div $v1, $a1, $a2
		li $v0, 1
		add $a0, $v1, 0	
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
    	
		jr $ra
		
	altura:
		#Imprimir $a0 que es eargumento del tamaño
		li $v0, 1	
		add $a0, $s0, $zero  #argumento a0 el num de elementos de la pila
		syscall
		
		jr $ra

	mostrarPila:
		add $t1, $a1, $zero  #copiando la pila a t1
		addi $t0, $zero, 0   #la i=0 para el for
		add $t2,$zero,$a0
		loop3:
			bge $t0, $t2, exit3  #for de 0 al tamaño de la pila
			   addi $t0, $t0, 1 	# i++
			   li $v0,1
			   lw $a0,($t1)
			   syscall
			   li $v0,4
			   la $a0,coma
			   syscall
			   addi $t1, $t1, 4    #sumo 4 al puntero de la pila
			   j loop3
		exit3:	
		   jr $ra
			
