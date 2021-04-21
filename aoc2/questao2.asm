addi   $t1, $zero, 10
          addi    $s0, $zero, 1
W1:    beq    $s0, $t1, SAI
          addi   $s0, $s0, 1
          j         W1
SAI: