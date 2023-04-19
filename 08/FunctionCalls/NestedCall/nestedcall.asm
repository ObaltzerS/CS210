    // Sys.vm for NestedCall test.
    // Sys.init()
    //
    // Calls Sys.main() and stores return value in temp 1.
    // Does not return.  (Enters infinite loop.)
    // function Sys.init 0
    // label Sys.init
(Sys.init)
    // test THIS and THAT context save
    // push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D
    // push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D
    // call Sys.main 0
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
    // goto Sys.main
@Sys.main
0;JMP
    // label label1
(label1)
    // pop temp 1
@SP
M=M-1
A=M
D=M
@6
M=D
    // label LOOP
(LOOP)
    // goto LOOP
@LOOP
0;JMP
    // Sys.main()
    //
    // Sets locals 1, 2 and 3, leaving locals 0 and 4 unchanged to test
    // default local initialization to 0.  (RAM set to -1 by test setup.)
    // Calls Sys.add12(123) and stores return value (135) in temp 0.
    // Returns local 0 + local 1 + local 2 + local 3 + local 4 (456) to confirm
    // that locals were not mangled by function call.
    // function Sys.main 5
    // label Sys.main
(Sys.main)
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
    // push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D
    // push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D
    // push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop local 1
@1
D=A
@LCL
D=D+M
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
    // push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop local 2
@2
D=A
@LCL
D=D+M
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
    // push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop local 3
@3
D=A
@LCL
D=D+M
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
    // push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1
    // call Sys.add12 1
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
@1
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
    // goto Sys.add12
@Sys.add12
0;JMP
    // label label2
(label2)
    // pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D
    // push local 0
@0
D=A
@LCL
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push local 1
@1
D=A
@LCL
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push local 2
@2
D=A
@LCL
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push local 3
@3
D=A
@LCL
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
    // push local 4
@4
D=A
@LCL
D=M+D
A=D
D=M
@SP
A=M
M=D
@SP
M=M+1
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
    // Sys.add12(int n)
    //
    // Returns n+12.
    // function Sys.add12 0
    // label Sys.add12
(Sys.add12)
    // push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D
    // push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1
    // pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D
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
    // push constant 12
@12
D=A
@SP
A=M
M=D
@SP
M=M+1
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
    // Infinite loop
(label3)
@label3
0;JMP
