.global start
.data
	menu:
		.string "\n------------------------MENU------------------------"
	closeline: 
		.string "----------------------------------------------------\n"
	options:
		.string "\n| 1. Set the number of matrices.                   |\n| 2. Set the number of rows and columns per matrix.|\n| 3. Set the values on the matrix.                 | \n| 4. Select the matrix.                            |\n"
	validations:
		.string "\n\nYou selected a wrong option. Please select another one."
	#Reserva de espacio
	matrices:
		.space 4096
	keyboard:
		.space 32
.text
start:
	j printMenu
	j exit

#----------------------------------------Exit program-------------------------------------------
exit:
	li a7, 10
	ecall
#---------------------------------------Print Menu strings--------------------------------------
printMenu:
	la a0, menu
	li a7, 4
	ecall
	la a0, options
	ecall
	la a0, closeline
	ecall
	j selectOptions
		
printInvalidOption:
	la a0, validations
	li a7, 4
	ecall
	j printMenu
	
#-----------------------------------User picks a Menu option-----------------------------------	
selectOptions:	
	li t1, 49 #Option 1
	li t2, 50 #Option 2
	li t3, 51 #Option 3
	li t4, 52 #Option 4
	
	li a7, 12 #gets the option selected with keyboard and sends it to a0
	ecall
	mv t5, a0
	
	li a0, '\n'
	li a7, 11
	ecall
	
	#compares
	beq t5,t1, Option1
	beq t5,t2, Option2
	beq t5,t3, Option3
	beq t5,t4, Option4
	
	#if any of valid options was selected, it shows a message
	j printInvalidOption

Option1:
	li a7, 12 #gets the input and sends it to a0
	ecall
	mv t1, a0
	
	li a0, '\n'
	li a7, 11
	ecall
	
	j printMenu
Option2:
	j exit
Option3:
	j exit
Option4:
	j exit
