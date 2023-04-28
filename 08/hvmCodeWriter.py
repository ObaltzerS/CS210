"""
hvmCodeWriter.py -- Emits assembly language code for the Hack VM translator.
Skeletonized by Janet Davis March 2016
Refactored by John Stratton April 2017
Refactored by Janet Davis March 2019
Updated by Cary Gray March 2021
"""

import os
from hvmCommands import *

# If debug is True, 
# then the VM commands will be written as comments into the output ASM file.
debug = True

class CodeWriter(object):
    
    def __init__(self, outputName):
        """
        Opens 'outputName' and gets ready to write it.
        """
        self.file = open(outputName, 'w')
        self.fileName = self.setFileName(outputName)

        # used to generate unique labels
        self.labelNumber = 0
        self.functionName = ""


    def close(self):
        """
        Writes the terminal loop and closes the output file.
        """
        label = self._uniqueLabel()
        self._writeComment("Infinite loop")
        self._writeCode('({0}), @{0}, 0;JMP'.format(label))
        self.file.close()


    def setFileName(self, fileName):
        """
        Sets the current file name to 'fileName'.
        Restarts the local label counter.

        Strips the path and extension.  The resulting name must be a
        legal Hack Assembler identifier.
        """
        self.fileName = os.path.basename(fileName)
        self.fileName = os.path.splitext(self.fileName)[0]

    def _uniqueLabel(self):
        self.labelNumber += 1
        return "label" + str(self.labelNumber)

    def write(self, text):
        """ 
        Write directly to the file.
        """
        self.file.write(text)

    def _writeCode(self, code):
        """
        Writes Hack assembly code to the output file.
        code should be a string containing ASM commands separated by commas,
        e.g., "@10, D=D+A, @0, M=D"
        """
        code = code.replace(',', '\n').replace(' ', '')
        self.file.write(code + '\n')

    def _writeComment(self, comment):
        """
        Writes a comment to the output ASM file.
        """
        if (debug):
            self.file.write('    // {0}\n'.format(comment))

    def _pushToSegment(self, index, segment):
        """
        A generalized method to push a value from a given segment to the stack
        """
        self._writeCode("@%s"%(index)) 
        self._writeCode("D=A") #get segment offset
        self._writeCode("@%s"%(self._translateSegment(segment)))
        self._writeCode("D=M+D") #calculate address of segment to be written in 
        self._writeCode("A=D")
        self._writeCode("D=M") 
        self._pushD() #push value of segment

    def _popToSegment(self,index,segment):
        """
        A generalized method to pop a value from the stack into a given segment
        """
        self._writeCode("@%s"%(index))
        self._writeCode("D=A")
        self._writeCode("@%s"%(self._translateSegment(segment)))
        self._writeCode("D=D+M") # calcualte (base + i)
        self._writeCode("@R13") # store temporarily
        self._writeCode("M=D")
        self._popD() # grab value 
        self._writeCode("@R13")
        self._writeCode("A=M") # navigate to (base + i) address
        self._writeCode("M=D") # write in segment

    def _jumpIf(self, endLabel, jumpLabel, jump):
        """
        Write true or false if the given logical operation is satisfied
        """
        self.writeArithmetic(T_SUB)
        self._popD()
        self._writeCode("@%s"%(jumpLabel))
        self._writeCode(jump)
        self._writeCode("D=-1") # if true
        self._pushD()
        self._writeCode("@%s"%(endLabel))
        self._writeCode("0;JMP")
        self._writeComment("NE")
        self._writeCode("(%s)"%(jumpLabel))
        self._writeCode("D=0") # if false
        self._pushD()
        self._writeComment("END")
        self._writeCode("(%s)"%(endLabel))

    def _pushD(self):
        """
        Writes Hack assembly code to push the value from the D register 
        onto the stack.
        TODO - Stage I - see Figure 7.2
        """
        self._writeCode("@SP,A=M,M=D,@SP,M=M+1")



    def _popD(self):
        """"
        Writes Hack assembly code to pop a value from the stack 
        into the D register.
        TODO - Stage I - see Figure 7.2
        """
        self._writeCode("@SP,M=M-1,A=M,D=M")


    def writeArithmetic(self, command):
        """
        Writes Hack assembly code for the given command.
        TODO - Stage I - see Figure 7.5
        """
        self._writeComment(command)

        if command == T_ADD:
            self._popD()
            self._writeCode("@SP,M=M-1,A=M,D=D+M")
            self._pushD()
        elif command == T_SUB:
            self._popD()
            self._writeCode("@SP,M=M-1,A=M,D=M-D")
            self._pushD()
        elif command == T_NEG:
            self._popD()
            self._writeCode("@0,D=A-D")
            self._pushD()
        elif command == T_EQ:
            NE = self._uniqueLabel()
            END = self._uniqueLabel()
            self._jumpIf(NE,END,"D;JNE")
        elif command == T_GT:
            NGT = self._uniqueLabel()
            END = self._uniqueLabel()
            self._jumpIf(NGT,END,"D;JLE")
        elif command == T_LT:
            NLT = self._uniqueLabel()
            END = self._uniqueLabel()
            self._jumpIf(NLT,END,"D;JGE")
        elif command == T_AND:
            self._popD()
            self._writeCode("@SP,M=M-1,A=M,D=D&M")
            self._pushD()
        elif command == T_OR:
            self._popD()
            self._writeCode("@SP,M=M-1,A=M,D=D|M")
            self._pushD()
        elif command == T_NOT:
            self._popD()
            self._writeCode("D=!D")
            self._pushD()
        else:
            raise(ValueError, 'Bad arithmetic command')

    def _translateSegment(self, segment):
        """
        Translate constants T_ARGUMENT, T_LOCAL, T_THIS, T_THAT 
        to Hack assembly symbols "ARG", "LCL", "THIS", "THAT"
        """
        return { T_ARGUMENT: "ARG",
                 T_LOCAL: "LCL",
                 T_THIS: "THIS",
                 T_THAT: "THAT" }[segment]

        
    def writePushPop(self, commandType, segment, index):
        """
        Write Hack code for 'commandType' (C_PUSH or C_POP).
        'segment' (string) is the segment name.
        'index' (int) is the offset in the segment.
        e.g., for the VM instruction "push constant 5",
        segment has the value "constant" and index has the value 5.
        TODO - Stage I - push constant only
        TODO - Stage II - See Figure 7.4 and pp. 137-8
        """
        if commandType == C_PUSH:
            self._writeComment("push {0} {1:d}".format(segment, index))

            if segment == T_CONSTANT: 
                self._writeCode("@%s"%(index))
                self._writeCode("D=A")
                self._pushD()
            elif segment == T_STATIC:
                self._writeCode("@%s.%s"%(self.fileName,index)) #handled as a variable
                self._writeCode("D=M")
                self._pushD()
            elif segment == T_POINTER:
                self._writeCode("@%s"%(index + 3))
                self._writeCode("D=M")
                self._pushD()
            elif segment == T_TEMP:
                self._writeCode("@%s"%(index + 5))
                self._writeCode("D=M")
                self._pushD()
            elif segment == T_ARGUMENT:
                self._pushToSegment(index, segment) 
            elif segment == T_LOCAL:
                self._pushToSegment(index, segment)
            elif segment == T_THIS:
                self._pushToSegment(index, segment)
            elif segment == T_THAT:
                self._pushToSegment(index, segment)
            else: # argument, local, this, that
                pass

        elif commandType == C_POP:
            self._writeComment("pop {0} {1:d}".format(segment, index))

            if segment == T_STATIC:
                self._popD()
                self._writeCode("@%s.%s"%(self.fileName,index))
                self._writeCode("M=D")
            elif segment == T_POINTER:
                self._popD()
                self._writeCode("@%s"%(index + 3))
                self._writeCode("M=D")
            elif segment == T_TEMP:
                self._popD()
                self._writeCode("@%s"%(5 + index))
                self._writeCode("M=D")
            elif segment == T_ARGUMENT:
                self._popToSegment(index,segment)
            elif segment == T_LOCAL:
                self._popToSegment(index,segment)
            elif segment == T_THIS:
                self._popToSegment(index,segment)
            elif segment == T_THAT:
                self._popToSegment(index,segment)
                
            else: # argument, local, this, that
                pass

        else:
            raise(ValueError, 'Bad push/pop command')


# Functions below this comment are for Project 08. Ignore for Project 07.

    """
    This works up to the final test case, MinMax, which I was not able to impliment a solution for,
    although I do feel like I understand what is required conceptually.
    """

    def writeLabel(self, label):
        """ 
        Writes assembly code that effects the label command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._writeComment("label {0}".format(label))
        self._writeCode("(%s)"%(label))

    def writeGoto(self, label):
        """
        Writes assembly code that effects the goto command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._writeComment("goto {0}".format(label))
        self._writeCode("@%s"%(label))
        self._writeCode("0;JMP")

    def writeIf(self,label):
        """
        Writes assembly code that effects the if-goto command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._popD()
        self._writeCode("@%s"%(label))
        self._writeCode("D;JNE")
        

    def writeFunction(self, functionName, numLocals):
        """
        Writes assembly code that effects the function command.
        See Figures 8.5 and 8.6.
        """
        self._writeComment("function {0} {1:d}".format(functionName, numLocals))
        self.functionName = functionName # For local labels
        self.writeLabel(functionName) # create the function label
        for i in range(numLocals):
            self._writeCode("@0,D=A") # create open space on the stack for the function
            self._pushD() # push to stack to create the function frame
        

    def writeReturn(self):
        """
        Writes assembly code that effects the return command.
        See Figure 8.5.
        """
        # could I do this with the temp variabels
        self._writeComment("return")
        #frame = LCL
        self._writeCode("@LCL,D=M")
        self._writeCode("@R13,M=D")
        #return address = *("frame"-5)
        self._writeCode("@5,A=D-A,D=M")
        self._writeCode("@R14,M=D")
        #*ARG = pop()
        self._popD()
        self._writeCode("@ARG,A=M,M=D")
        #SP = ARG+1
        self._writeCode("@ARG,D=M")
        self._writeCode("@SP,M=D+1")
        #THAT = *("frame"-1)
        self._writeCode("@R13,A=M-1,D=M")
        self._writeCode("@THAT,M=D")
        #THIS = *("R13"-2)
        self._writeCode("@2,D=A,@R13,A=M-D,D=M")
        self._writeCode("@THIS,M=D")
        #ARG = *("R13"-3)
        self._writeCode("@3,D=A,@R13,A=M-D,D=M")
        self._writeCode("@ARG,M=D")
        #LCL = *("R13"-4)
        self._writeCode("@4,D=A,@R13,A=M-D,D=M")
        self._writeCode("@LCL,M=D")
        #goto return address
        self._writeCode("@R14,A=M,0;JMP")
        

    def writeCall(self, functionName, numArgs):
        """
        Writes assembly code that effects the call command.
        See Figures 8.5 and 8.6.
        """
        self._writeComment("call {0} {1:d}".format(functionName, numArgs))
        #push return address
        label = self._uniqueLabel()
        self._writeCode("@%s,D=A"%(label))
        self._pushD()
        #push LCL
        self._writeCode("@LCL,D=M") #looks good
        self._pushD()
        #push ARG
        self._writeCode("@ARG,D=M") #looks good
        self._pushD()
        #push THIS
        self._writeCode("@THIS,D=M") #looks good
        self._pushD()
        #push THAT
        self._writeCode("@THAT,D=M") #looks good
        self._pushD()
        #ARG = SP-5-nArgs
        self._writeCode("@SP,D=M")
        self._writeCode("@5,D=D-A")
        self._writeCode("@%s,D=D-A"%(numArgs))
        self._writeCode("@ARG,M=D")
        #LCL = SP
        self._writeCode("@SP,D=M")
        self._writeCode("@LCL,M=D")
        #goto f
        self.writeGoto(functionName)
        #(returnAddress)
        self.writeLabel(label)

    def writeInit(self):
        """
        Writes assembly code that effects the VM initialization,
        also called bootstrap code. This code must be placed
        at the beginning of the output file.
        See p. 162, "Bootstrap Code"
        """
        self._writeComment("Init")
        self._writeCode("@256,D=A,@0,M=D")
        self.writeCall("Sys.init",0)
        self.writeReturn()