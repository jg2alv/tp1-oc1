.data

##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

vetor1: .word 2, 3, 4  
                                   
vetor2: .word 1, 5, 4, 6, 8                                                                

##### R1 END MODIFIQUE AQUI END #####

.text
  add s0, zero, zero       # s0 armazenará o número de testes que passaram
  la a0, vetor1
  addi a1, zero, 3                      
  jal e_crescente  
  addi t0, zero, 1
  bne a0, t0, teste_2     
  addi s0,s0,1

teste_2: 	    
  la a0, vetor2
  addi a1, zero, 5
  jal e_crescente     
  addi t0, zero, 0
  bne a0, t0, FIM     
  addi s0,s0,1
  j FIM

##### R2 START MODIFIQUE AQUI START #####

e_crescente:
    addi sp, sp, -4
    sw ra, 0(sp)           # salva o retorno

    addi t0, x0, 1         # t0 = 1
    blt  a1, t0, crescente # se tamanho < 1
    beq  a1, t0, crescente # se tamanho == 1

    add  t1, a0, x0        # t1 = ponteiro atual (base do vetor)
    addi t2, a1, -1        # t2 = número de comparações (tamanho - 1)
    addi t3, x0, 0         # t3 = índice = 0

loop:
    lw   t4, 0(t1)         # t4 = vetor[i]
    lw   t5, 4(t1)         # t5 = vetor[i+1]
    bge  t4, t5, nao_crescente

    addi t1, t1, 4         # avança ponteiro
    addi t3, t3, 1         # i++
    blt  t3, t2, loop      # se i < n-1, continua

crescente:
    addi a0, x0, 1         # a0 = 1

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(ra)

nao_crescente:
    addi a0, x0, 0         # a0 = 0

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(ra)

##### R2 END MODIFIQUE AQUI END #####

FIM:

