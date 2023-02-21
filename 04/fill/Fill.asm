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

@KEYBOARD
D=M
@BLACK
D;JGT
@WHITE
D;JEQ

//black loop which assigns all pixels on screen to -1 and then checks if KBD > 0
//on KBD > 0, this loop should end and go back to the previous KBD check loop
(BLACK)


//white loop which assigns all pixels on the screen to 1, then checks if KBD > 0
//on KBD > 0 loop is ended and the og kbd check loop is activated
(WHITE)


