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



@i
M=

       @i     // i refers to some mem. location.
       M=1    // i=1
       @sum   // sum refers to some mem. location.
       M=0    // sum=0
(LOOP) @i
       D=M    // D=i
       @100
       D=D-A  // D=i-100
       @END
       D;JGT  // If (i-100)>0 goto END
       @i
       D=M    // D=i
       @sum
       M=D+M  // sum=sum+i
       @i
       M=M+1  // i=i+1
       @LOOP
       0;JMP  // Goto LOOP
  (END)
       @END
       0;JMP  // Infinite loop
