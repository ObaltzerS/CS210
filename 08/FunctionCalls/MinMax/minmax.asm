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
@1
D=M
@SP
A=M
M=D
@SP
M=M+1
@2
D=M
@SP
A=M
M=D
@SP
M=M+1
@3
D=M
@SP
A=M
M=D
@SP
M=M+1
@4
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
    // goto label1
@$label1
0;JMP
    // label Sys.init$ret.0
(Sys.init$ret.0)
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
    // Defines two different functions, min and max, calling both with 
    // similar argments.
    // function Main.min 0
    // label Main.min
(Main.min)
    // x
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
    // y
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
    // gt
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
D;JLE
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
@Main.min$THEN
D;JNE
    // label ELSE
(ELSE)
    // return x
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
    // goto ENDIFq
@Main.min$ENDIF
0;JMP
    // label THEN
(THEN)
    // return y
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
    // label ENDIF
(ENDIF)
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
    // function Main.max 0
    // label Main.max
(Main.max)
    // x
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
    // y
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
    // gt
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
@label5
D;JLE
D=-1
@SP
A=M
M=D
@SP
M=M+1
@label4
0;JMP
    // NE
(label5)
D=0
@SP
A=M
M=D
@SP
M=M+1
    // END
(label4)
@SP
M=M-1
A=M
D=M
@Main.max$THEN
D;JNE
    // label ELSE
(ELSE)
    // return y
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
    // goto ENDIF
@Main.max$ENDIF
0;JMP
    // label THEN
(THEN)
    // return x
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
    // label ENDIF
(ENDIF)
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
    // function Main.main 0
    // label Main.main
(Main.main)
    // push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
    // call Main.min 2
@label6
D=A
@SP
A=M
M=D
@SP
M=M+1
@1
D=M
@SP
A=M
M=D
@SP
M=M+1
@2
D=M
@SP
A=M
M=D
@SP
M=M+1
@3
D=M
@SP
A=M
M=D
@SP
M=M+1
@4
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
    // goto label6
@Main.main$label6
0;JMP
    // label Main.min$ret.0
(Main.min$ret.0)
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
    // Pushes n onto the stack and calls the Main.fibonacii function,
    // which computes the n'th element of the Fibonacci series.
    // The Sys.init function is called "automatically" by the 
    // bootstrap code.
    // function Sys.init 0
    // label Sys.init
(Sys.init)
    // call Main.main 0
@label7
D=A
@SP
A=M
M=D
@SP
M=M+1
@1
D=M
@SP
A=M
M=D
@SP
M=M+1
@2
D=M
@SP
A=M
M=D
@SP
M=M+1
@3
D=M
@SP
A=M
M=D
@SP
M=M+1
@4
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
    // goto label7
@Sys.init$label7
0;JMP
    // label Main.main$ret.0
(Main.main$ret.0)
    // label WHILE
(WHILE)
    // Loop infinitely
    // goto WHILE
@Sys.init$WHILE
0;JMP
    // Infinite loop
(label8)
@label8
0;JMP
