
//sums the elements in memory starting at R8


//intitialize
@R2
M=0 //sum R0 <- 0
@R0
M=0 //counter R2 <- 0

//loop

// need to compare R0 < R7
// subtract and if result == 0 end loop
@R7
D=M
@R0
D=D-M  //R7 - R0
@ENDLOOP
D;JEQ  // jump if equal to zero
//body 
//first calculate element address
@R0 // goto counter
D=M // get the counter out of memory
@R8 // navigate to address 8
A=D+A // address calculation
D=M // memory value 
@R2 // navigate to the sum location
M=D+M // calculate new sum
//cleanup
@R0 // goto counter
M=M+1 //increment counter
@LOOP
0;JMP
@END
0;JMP
