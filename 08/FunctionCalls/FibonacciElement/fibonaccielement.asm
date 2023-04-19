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
    // File name: projects/08/FunctionCalls/FibonacciElement/Main.vm
    // Computes the n'th element of the Fibonacci series, recursively.
    // n is given in argument[0].  Called by the Sys.init function 
    // (part of the Sys.vm file), which also pushes the argument[0] 
    // parameter before this code starts running.
    // function Main.fibonacci 0
    // label Main.fibonacci
(Main.fibonacci)
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
    // push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
    // checks if n<2
    // lt
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
@SP
M=M-1
A=M
D=M
@label3
D;JGE
D=-1
@SP
A=M
M=D
@SP
M=M+1
@label2
0;JMP
    // NE
(label3)
D=0
@SP
A=M
M=D
@SP
M=M+1
    // END
(label2)
@SP
M=M-1
A=M
D=M
@IF_TRUE
D;JNE
    // goto IF_FALSE
@IF_FALSE
0;JMP
    // if n<2, return n
    // label IF_TRUE
(IF_TRUE)
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
    // if n>=2, returns fib(n-2)+fib(n-1)
    // label IF_FALSE
(IF_FALSE)
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
    // push constant 2
@2
D=A
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
    // computes fib(n-2)
    // call Main.fibonacci 1
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
@1
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Main.fibonacci
@Main.fibonacci
0;JMP
    // label label4
(label4)
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
    // push constant 1
@1
D=A
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
    // computes fib(n-1)
    // call Main.fibonacci 1
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
@1
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Main.fibonacci
@Main.fibonacci
0;JMP
    // label label5
(label5)
    // returns fib(n-1) + fib(n-2)
    // add
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=D+M
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
    // File name: projects/08/FunctionCalls/FibonacciElement/Sys.vm
    // Pushes a constant, say n, onto the stack, and calls the Main.fibonacii
    // function, which computes the n'th element of the Fibonacci series.
    // Note that by convention, the Sys.init function is called "automatically" 
    // by the bootstrap code.
    // function Sys.init 0
    // label Sys.init
(Sys.init)
    // push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
    // computes the 4'th fibonacci element
    // call Main.fibonacci 1
@label6
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
@1
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Main.fibonacci
@Main.fibonacci
0;JMP
    // label label6
(label6)
    // label WHILE
(WHILE)
    // loops infinitely
    // goto WHILE
@WHILE
0;JMP
    // Infinite loop
(label7)
@label7
0;JMP
