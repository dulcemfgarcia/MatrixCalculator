.data
    matriz: .space 1000  # Reserva espacio para una matriz de 100x100 (cada elemento de 4 bytes)
    newline: .string "\n"
    prompt1: .string "Ingrese el número de filas: "
    prompt2: .string "Ingrese el número de columnas: "
    prompt3: .string "Ingrese el valor para la posición "
    prompt4: .string "Fila "
    prompt5: .string ", Columna "
    prompt6: .string ": "
    espacio: .string " "

.text
    la a0, prompt1   # Imprime el primer prompt
    li a7, 4
    ecall

li a7, 5          # Lee el número de filas desde la entrada estándar
ecall
mv t0, a0         # Guarda el número de filas en t0

    la a0, prompt2   # Imprime el segundo prompt
    li a7, 4
    ecall

li a7, 5          # Lee el número de columnas desde la entrada estándar
ecall
mv t1, a0         # Guarda el número de columnas en t1

    # Inicializa los índices de fila y columna
    li t2, 0          # i (fila)
    li t3, 0          # j (columna)

crear_matriz:
    bge t2, t0, imprimir_matriz   # Si i >= filas, imprime la matriz

    li t3, 0          # Reinicia j para cada nueva fila

    crear_fila:
        bge t3, t1, siguiente_fila  # Si j >= columnas, pasa a la siguiente fila

        # Imprime el prompt para ingresar el valor en la posición [i][j]
        la a0, prompt3
        li a7, 4
        ecall

        la a0, prompt4
        li a7, 4
        ecall
        mv a0, t2
        li a7, 1
        ecall

        la a0, prompt5
        li a7, 4
        ecall
        mv a0, t3
        li a7, 1
        ecall

        la a0, prompt6
        li a7, 4
        ecall

        # Lee el valor desde la entrada estándar
        li a7, 5
        ecall
        sw a0, 4(t2)           # Almacena el valor en la matriz en la posición [t2][t3]

        j siguiente_columna

    siguiente_fila:
        addi t2, t2, 1  # Incrementa el índice de fila
        j crear_matriz  # Vuelve a la creación de la matriz

    siguiente_columna:
        addi t3, t3, 1  # Incrementa el índice de columna
        j crear_fila    # Vuelve a la creación de la fila

imprimir_matriz:
    # Imprime la matriz
    li t2, 0          # Reinicia el índice de fila para la impresión

    imprimir_fila:
        bge t2, t0, fin   # Si i >= filas, termina

        li t3, 0          # Reinicia j para cada fila
        imprimir_columna:

            bge t3, t1, siguiente_fila_imprimir  # Si j >= columnas, pasa a la siguiente fila

            # Imprime el valor de la matriz
            lw a0, 4(t2)           # Carga el valor de la matriz en la posición [t2][t3] en a0
            li a7, 1
            ecall

            # Imprime un espacio para separar los valores
            la a0, espacio
            li a7, 4
            ecall

            j siguiente_columna_imprimir

        siguiente_fila_imprimir:
            # Imprime una nueva línea al final de cada fila
            la a0, newline
            li a7, 4
            ecall

            addi t2, t2, 1  # Incrementa el índice de fila
            j imprimir_fila  # Vuelve a imprimir la fila

        siguiente_columna_imprimir:
            addi t3, t3, 1  # Incrementa el índice de columna
            j imprimir_columna  # Vuelve a imprimir la columna

fin:
    # Termina el programa
    li a7, 10
    ecall
