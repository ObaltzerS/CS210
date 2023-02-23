// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/FillStatic.asm

// Blackens the screen, i.e. writes "black" in every pixel. 
// Key presses are ignored.
// This is an intermediate step added by Prof. Davis.

// Put your code here.

(OUTER)
@SCREEN
D=A
@R1
M=D

(FILL)
@R1 // get new address out of memory
D=M
@KBD
D=A-D
@OUTER
D;JEQ // check if address - 16384 = 0
@R1
A=M
M=-1 // set new address to -1
D=A 
@R1 
M=M+1 //inc to next address
@FILL
0;JMP