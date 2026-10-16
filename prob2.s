.data

##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

lista_precos: .word 7, 5, 1  # Vetor com os preços iniciais dos produtos
fator_aumento: .word 3       # Fator de aumentos do preço
taxa_50: .word 2             # Taxa adicional para ajustar o preço



##### R1 END MODIFIQUE AQUI END #####

.text

add s0, zero, zero     # Inicializa s0 com 0; s0 contará o número de testes que passaram

li a0, 0               # Inicializa a0
la a1, lista_precos    # a1 aponta para o início da lista de preços
li a2, 0               # Índice inicial do vetor
li a3, 3               # Tamanho do vetor

jal ra, soma_estoque   # Chama função para somar todos os preços ajustados
addi t5, zero, 78      # Esperado: (7*3*2) + (5*3*2) + (1*3*2) = 42 + 30 + 6 = 78
bne a0, t5, teste_2    # Se o resultado for diferente, pula para teste_2
addi s0,s0,1           # Incrementa s0 (teste passou)

teste_2:

li a0, 3               # Inicializa a0
lw a1, fator_aumento   # a1 recebe o fator de aumento

jal ra, ajustar_preco  # Chama a função ajustar_preco(a0 = 3)
addi t5, zero, 18      # Valor esperado do resultado = 3 * 3 * 2 = 18
bne a0, t5, teste_3    # Se o resultado for diferente, pula para teste_3
addi s0,s0,1           # Incrementa s0 (teste passou)

teste_3:
li a0, 2               # a0 recebe 2, elemento i do vetor vetor[i]
lw a1, taxa_50   	   # a1 recebe a taxa de aumento

jal ra, aplicar_taxa   # Chama a função aplicar_taxa (a0 = 2, a3 = 2)
addi t5, zero, 4       # Esperado: 2 * 2 = 4
bne a0, t5, FIM        # Se diferente de 4, pula para FIM
addi s0,s0,1           # Incrementa s0 (teste passou)
j FIM
                  
##### R2 START MODIFIQUE AQUI START #####

soma_estoque:               #### soma_estoque begin ####
    addi sp, sp, -4
    sw ra, 0(sp)            # salva o retorno

    add t0, zero, zero      # t0 = acumulador = 0

loop_soma:
    bge a2, a3, fim_soma    # se i >= tamanho, sai

    slli t1, a2, 2          # t1 = i * 4 (offset)
    add t2, a1, t1          # endereço = base + i*4

    add t3, a1, zero        # guarda a1 em t3 antes de chamar ajustar_preco

    lw a0, 0(t2)            # a0 = vetor[i]
    lw a1, fator_aumento    # a1 = fator
    jal ra, ajustar_preco   # ajusta o preço → resultado em a0

    add a1, t3, zero        # carrega a1 de volta depois de chamar ajustar_preco

    add t0, t0, a0          # acumula o valor ajustado
    addi a2, a2, 1          # i++

    jal zero, loop_soma

fim_soma:
    add a0, t0, zero        # a0 = resultado final

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr zero, 0(ra)        #### soma_estoque end ####

ajustar_preco:              #### ajustar_preco being ####
    addi sp, sp, -4
    sw ra, 0(sp)

    mul a0, a0, a1          # a0 = valor * fator
    lw a1, taxa_50          # taxa = 2

    jal ra, aplicar_taxa

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr zero, 0(ra)        #### ajustar_preco end ####

aplicar_taxa:
    addi sp, sp, -4
    sw ra, 0(sp)            # salva o retorno

    mul a0, a0, a1          # a0 = valor * taxa

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr zero, 0(ra)

##### R2 END MODIFIQUE AQUI END #####

FIM:

