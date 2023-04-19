    // Init
@256
D=A
@0
M=D
@300
D=A
@1
M=D
@400
D=A
@2
M=D
@3000
D=A
@3
M=D
@3010
D=A
@4
M=D
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/ProgramFlow/BasicGoto/BasicGoto.vm
    // Illustrates an unconditional goto.
    // push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
    // goto SKIPPED
@SKIPPED
0;JMP
    // push constant 18
@18
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 19
@19
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 20
@20
D=A
@SP
A=M
M=D
@SP
M=M+1
    // label SKIPPED
(SKIPPED)
    // push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
    // Infinite loop
(label1)
@label1
0;JMP
