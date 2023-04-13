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
        self._writeCode("@"+str(index))
        self._writeCode("D=A")
        self._writeCode("@"+self._translateSegment(segment))
        self._writeCode("D=M+D")
        self._writeCode("A=D")
        self._writeCode("D=M")
        self._pushD()

    def _popToSegment(self,index,segment):
        self._writeCode("@"+str(index))
        self._writeCode("D=A")
        self._writeCode("@"+self._translateSegment(segment))
        self._writeCode("D=D+M") # calcualte (base + i)
        self._writeCode("@R13") # store temporarily
        self._writeCode("M=D")
        self._popD() # grab value 
        self._writeCode("@R13")
        self._writeCode("A=M") # navigate to (base + i) address
        self._writeCode("M=D")



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
            self.writeArithmetic(T_SUB)
            self._popD()
            self._writeCode("@"+NE)
            self._writeCode("D;JNE")
            self._writeCode("D=-1")
            self._pushD()
            self._writeCode("@"+END)
            self._writeCode("0;JMP")
            self._writeComment("NE")
            self._writeCode("("+NE+")")
            self._writeCode("D=0")
            self._pushD()
            self._writeComment("END")
            self._writeCode("("+END+")")
        elif command == T_GT:
            NGT = self._uniqueLabel()
            END = self._uniqueLabel()
            self.writeArithmetic(T_SUB)
            self._popD()
            self._writeCode("@"+NGT)
            self._writeCode("D;JLE")
            self._writeCode("D=-1")
            self._pushD()
            self._writeCode("@"+END)
            self._writeCode("0;JMP")
            self._writeComment("NGT")
            self._writeCode("("+NGT+")")
            self._writeCode("D=0")
            self._pushD()
            self._writeComment("END")
            self._writeCode("("+END+")")
        elif command == T_LT:
            NLT = self._uniqueLabel()
            END = self._uniqueLabel()
            self.writeArithmetic(T_SUB)
            self._popD()
            self._writeCode("@"+NLT)
            self._writeCode("D;JGE")
            self._writeCode("D=-1")
            self._pushD()
            self._writeCode("@"+END)
            self._writeCode("0;JMP")
            self._writeComment("NLT")
            self._writeCode("("+NLT+")")
            self._writeCode("D=0")
            self._pushD()
            self._writeComment("END")
            self._writeCode("("+END+")")
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
                self._writeCode("@"+str(index))
                self._writeCode("D=A")
                self._pushD()
            elif segment == T_STATIC:
                self._writeCode("@"+self.fileName+"."+str(index)) #handled as a variable?
                self._writeCode("D=M")
                self._pushD()
            elif segment == T_POINTER:
                self._writeCode("@"+str(index + 3))
                self._writeCode("D=M")
                self._pushD()
            elif segment == T_TEMP:
                self._writeCode("@"+str(index + 5))
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
                self._writeCode("@"+self.fileName+"."+str(index))
                self._writeCode("M=D")
            elif segment == T_POINTER:
                self._popD()
                self._writeCode("@"+str(index + 3))
                self._writeCode("M=D")
            elif segment == T_TEMP:
                self._popD()
                self._writeCode("@"+str(5 + index))
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

    def writeLabel(self, label):
        """ 
        Writes assembly code that effects the label command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._writeComment("label {0}".format(label))
        pass

    def writeGoto(self, label):
        """
        Writes assembly code that effects the goto command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._writeComment("goto {0}".format(label))
        pass

    def writeIf(self,label):
        """
        Writes assembly code that effects the if-goto command.
        See section 8.4 (p. 158) and Figure 8.6.
        """
        self._writeComment("if-goto {0}".format(label))
        pass

    def writeFunction(self, functionName, numLocals):
        """
        Writes assembly code that effects the function command.
        See Figures 8.5 and 8.6.
        """
        self._writeComment("function {0} {1:d}".format(functionName, numLocals))
        self.functionName = functionName # For local labels
        pass

    def writeReturn(self):
        """
        Writes assembly code that effects the return command.
        See Figure 8.5.
        """
        self._writeComment("return")
        pass

    def writeCall(self, functionName, numArgs):
        """
        Writes assembly code that effects the call command.
        See Figures 8.5 and 8.6.
        """
        self._writeComment("call {0} {1:d}".format(functionName, numArgs))
        pass

    def writeInit(self):
        """
        Writes assembly code that effects the VM initialization,
        also called bootstrap code. This code must be placed
        at the beginning of the output file.
        See p. 162, "Bootstrap Code"
        """
        self._writeComment("Init")
        pass
