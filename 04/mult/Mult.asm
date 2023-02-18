// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.
// gonna use this as a model for the multiplication algorithm

// initialize

// counter
@R3
M=0
// result 
@R2
M=0

//My idea is to run a loop which adds R0 however many times there is a value in R1

// check counter
(LOOP)
@R3
D=M
@R1
D=D-M
@END
D;JEQ
@R0
D=M
@R2
M=M+D
@R3
M=M+1
@LOOP
(END)
0;JMP
@END