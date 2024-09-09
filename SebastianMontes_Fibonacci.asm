.data
prompt_fib: .asciiz "Ingrese cuantos numeros de la serie Fibonacci desea generar: "
fib_msg:    .asciiz "Serie Fibonacci: "
sum_msg:    .asciiz "Suma de la serie: "
newline:    .asciiz "\n"

.text
.globl main
main:
    # Solicitar la cantidad de números de Fibonacci que se desean generar
    li $v0, 4               # Código para imprimir una cadena
    la $a0, prompt_fib       # Cargar el mensaje de solicitud
    syscall

    li $v0, 5               # Código para leer un entero
    syscall
    move $t0, $v0           # Guardar el número ingresado en $t0 (cantidad de números)

    # Inicializar variables
    li $t1, 0               # Fib(0)
    li $t2, 1               # Fib(1)
    li $t3, 0               # Suma total
    li $t4, 0               # Contador para la cantidad de números generados

    # Imprimir mensaje de la serie Fibonacci
    li $v0, 4
    la $a0, fib_msg
    syscall

fibonacci_loop:
    # Verificar si ya se generaron los números solicitados
    beq $t4, $t0, display_sum

    # Imprimir el número actual de la serie Fibonacci
    li $v0, 1               # Código para imprimir entero
    move $a0, $t1           # Imprimir Fib(n)
    syscall

    # Salto de línea
    li $v0, 4
    la $a0, newline
    syscall

    # Sumar el número actual a la suma total
    add $t3, $t3, $t1

    # Calcular el siguiente número de la serie Fibonacci
    add $t5, $t1, $t2       # Siguiente número en la secuencia
    move $t1, $t2           # Actualizar Fib(n-1)
    move $t2, $t5           # Actualizar Fib(n)

    # Incrementar el contador
    addi $t4, $t4, 1

    # Repetir el ciclo hasta que se generen todos los números
    j fibonacci_loop

display_sum:
    # Imprimir mensaje de la suma
    li $v0, 4
    la $a0, sum_msg
    syscall

    # Imprimir la suma total de la serie
    li $v0, 1
    move $a0, $t3
    syscall

    # Salto de línea final
    li $v0, 4
    la $a0, newline
    syscall

    # Terminar programa
    li $v0, 10
    syscall

