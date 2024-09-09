.data
prompt_num: .asciiz "Ingrese un numero: "
mayor_msg:  .asciiz "El numero mayor es: "

.text
.globl main
main:
    # Inicializar registros para los números
    li $t0, -2147483648  # Inicializa el mayor con el valor más bajo posible
    
    # Bucle para ingresar 3-5 números
    li $t1, 3            # Minimo 3 numeros
input_loop:
    li $v0, 4            # Imprime el mensaje
    la $a0, prompt_num
    syscall

    li $v0, 5            # Lee un numero entero
    syscall
    move $t2, $v0        # Guarda el número leído en $t2
    
    # Compara con el número mayor actual
    blt $t0, $t2, update_max
    j check_done
    
update_max:
    move $t0, $t2        # Actualiza el número mayor si es más grande

check_done:
    subi $t1, $t1, 1     # Decrementa el contador
    bgtz $t1, input_loop # Repite hasta 0

    # Imprimir el número mayor
    li $v0, 4
    la $a0, mayor_msg
    syscall

    li $v0, 1            # Imprime el mayor
    move $a0, $t0
    syscall

    # Termina el programa
    li $v0, 10
    syscall
