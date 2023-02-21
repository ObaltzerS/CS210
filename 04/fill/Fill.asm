// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

//outline:

//initialize any registers which I need

//stage one: loop which constantly listens for keyboard input, if there is input, jump to blacken commands

//initialize temp registers
@R1 // this will hold our color value 
M=0
@R2 // this will hold our pixel address
M=0
// Loop to chek whether KBD is greater than 0 or equal to 0, jumping to either black of white respectively
(LOOP)
@KBD
D=M
@BLACK
D;JGT
@WHITE
D;JEQ
@LOOP
0;JMP
//assign temp register to white value, then navigate to fill
(WHITE)
@R1
M=0
@FILL
0;JMP
//assign temp register to black value, then navigate to fill
(BLACK)
@R1
M=-1
@FILL
0;JMP
//fill screen using the value stored in temp register
(FILL)


