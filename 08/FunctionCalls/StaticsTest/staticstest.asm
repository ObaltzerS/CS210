    // Init
@256
D=A
@0
M=D
    // call Sys.init 0
@label1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Sys.init
@Sys.init
0;JMP
    // label label1
(label1)
    // return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
@R14
A=M
0;JMP
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/FunctionCalls/StaticsTest/Class1.vm
    // Stores two supplied arguments in static[0] and static[1].
    // function Class1.set 0
    // label Class1.set
(Class1.set)
    // push argument 0
@0
D=A
@ARG
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // pop static 0
@SP
M=M-1
A=M
D=M
@Class1.0
M=D
    // push argument 1
@1
D=A
@ARG
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // pop static 1
@SP
M=M-1
A=M
D=M
@Class1.1
M=D
    // push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
    // return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
@R14
A=M
0;JMP
    // Returns static[0] - static[1].
    // function Class1.get 0
    // label Class1.get
(Class1.get)
    // push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push static 1
@Class1.1
D=M
@SP
A=M
M=D
@SP
M=M+1
    // sub
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@SP
A=M
M=D
@SP
M=M+1
    // return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
@R14
A=M
0;JMP
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/FunctionCalls/StaticsTest/Class2.vm
    // Stores two supplied arguments in static[0] and static[1].
    // function Class2.set 0
    // label Class2.set
(Class2.set)
    // push argument 0
@0
D=A
@ARG
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // pop static 0
@SP
M=M-1
A=M
D=M
@Class2.0
M=D
    // push argument 1
@1
D=A
@ARG
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // pop static 1
@SP
M=M-1
A=M
D=M
@Class2.1
M=D
    // push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
    // return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
@R14
A=M
0;JMP
    // Returns static[0] - static[1].
    // function Class2.get 0
    // label Class2.get
(Class2.get)
    // push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push static 1
@Class2.1
D=M
@SP
A=M
M=D
@SP
M=M+1
    // sub
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
@SP
A=M
M=D
@SP
M=M+1
    // return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
A=M-1
D=M
@THAT
M=D
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
@R14
A=M
0;JMP
    // This file is part of www.nand2tetris.org
    // and the book "The Elements of Computing Systems"
    // by Nisan and Schocken, MIT Press.
    // File name: projects/08/FunctionCalls/StaticsTest/Sys.vm
    // Tests that different functions, stored in two different 
    // class files, manipulate the static segment correctly. 
    // function Sys.init 0
    // label Sys.init
(Sys.init)
    // push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
    // call Class1.set 2
@label2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@5
D=D-A
@2
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Class1.set
@Class1.set
0;JMP
    // label label2
(label2)
    // Dumps the return value
    // pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D
    // push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
    // call Class2.set 2
@label3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@5
D=D-A
@2
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Class2.set
@Class2.set
0;JMP
    // label label3
(label3)
    // Dumps the return value
    // pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D
    // call Class1.get 0
@label4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Class1.get
@Class1.get
0;JMP
    // label label4
(label4)
    // call Class2.get 0
@label5
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Class2.get
@Class2.get
0;JMP
    // label label5
(label5)
    // label WHILE
(WHILE)
    // goto WHILE
@WHILE
0;JMP
    // Infinite loop
(label6)
@label6
0;JMP
