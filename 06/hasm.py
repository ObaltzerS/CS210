#!/usr/bin/python3
# Some text copyright (C) 2011 Mark Armbrust.  
# Permission granted for educational use.
# Skeletonized March 2016 by Janet Davis
# Refactored May 2016 by Janet Davis
# Refactored February 2018 by John Stratton
# Refactored and debugged January 2019 by Janet Davis
# Edited 2021-22 by Cary Gray

"""
hasm.py -- Hack computer assembler

Translates a Hack assembly program into the corresponding Hack machine language program.
See "The Elements of Computing Systems", by Noam Nisan and Shimon Schocken

Usage: python3 hasm.py PROGRAM.asm
"""

from hasmUtils import *
from sys import argv
import string
import re

def read_asm_file(input_filename):
    """
    Reads the list of assembly statements from input, removing comments.
    Returns a list of non-empty, non-comment lines.  Each should represent 
    a single statement, either an A_INSTRUCTION, C_INSTRUCTION, or L_DIRECTIVE
    """
    try:
        inFile = open(input_filename, 'r')
    except:
        FatalError('Could not open source file "'+input_filename+'"')

    rawline = inFile.readline()
    list_of_lines = []

    while rawline != '':
        # Parse the line. Start by removing whitespace
        line = rawline.strip()

        # Then deal with comments
        comment_start = line.find("//")
        if comment_start >= 0:
            # Keep the part of the line before the comment, less whitespace
            line = line[:comment_start].strip()

        # If the entire line is a comment or empty, 
        # do nothing and skip to the next line
        # Otherwise, add the non-empty preprocessed line to the list
        if line != '':
            list_of_lines.append( line )
        rawline = inFile.readline()

    inFile.close()
    return list_of_lines

def statement_type(statement):
    """
    Returns one of the defined constants A_INSTRUCTION, C_INSTRUCTION, 
    or L_DIRECTIVE 
    to identify the type of statement represented by the parameter string.
    If the statement is none of these types, throw a FatalError exception.
    """
    
    if(statement[0] == "@"):
        return A_INSTRUCTION
    elif(statement[0] == "("):
        return L_DIRECTIVE
    else:
        return C_INSTRUCTION
    
    pass

def emit_C_instruction(statement, output_file):
    """
    Given an assembly language statement corresponding to a C-instruction,
    writes the corresponding machine language instruction to the given output
    file.  The machine langauge instruction should be expressed as a string of 
    16 characters "0" and "1". Each line of the output file should consist
    of exactly one machine language instruction.
    """

    # The CodeTranslator class, defined in hasmUtils.py, has methods 
    # dest(string), comp(string), and jump(string) 
    # to translate assembly mnemonics of each type into strings of 0 and 1.
    codeTranslator = CodeTranslator()
    #find parts

    #dest
    if ("=" in statement):
        equalsIndex = statement.find("=")
        destination = statement[:equalsIndex]
        operation = statement[equalsIndex + 1:]
    else:
        destination = ""
    #comp
    if (";" in statement):
        sColonIndex = statement.index(";")
        operation = statement[:sColonIndex]
        JMPtype = statement[sColonIndex + 1:]
    else:
        
        JMPtype = ""
    #translation
    dest = codeTranslator.dest(destination)
    comp = codeTranslator.comp(operation)
    jump = codeTranslator.jump(JMPtype)
        
    """equalsIndex = statement.find("=")
    if (equalsIndex != -1):
        destination = statement[:equalsIndex]
        operation = statement[equalsIndex + 1:]
    if (";" in statement):
        
        sColonIndex = statement.index(";")
        operation = statement[:sColonIndex]
        JMPtype = statement[sColonIndex + 1:]
    #translation
    dest = codeTranslator.dest(destination)
    comp = codeTranslator.comp(operation)
    jump = codeTranslator(JMPtype)
    if ("M" in operation):
        a = "1"
    else:
        a = "0"
    """
    
    translatedInstruction = "111" + str(comp) + str(dest) + str(jump) + "\n"
    
    output_file.write(translatedInstruction)

    # TODO Stage A: translate C instruction to machine instruction and write to file
    pass

def emit_A_instruction(statement, symbol_table, output_file):
    """
    Given an assembly language statement corresponding to an A-instruction,
    writes the corresponding machine language instruction to the given output
    file.  The machine langauge instruction should be expressed as a string of 
    16 characters "0" and "1". Each line of the output file should consist
    of exactly one machine language instruction.
    """
    # TODO Stage A: translate A instruction to machine instruction and write to file
    #step 1: assert A type
    if (statement_type(statement) != A_INSTRUCTION):
        FatalError("Statement not A type")
    address = statement[1:]
    #step 2: translate after @ to binary
    if (address.isdigit()):
        binaryAddress = bin(int(address))[2:]
        print(binaryAddress)
        output_file.write("{0:0>17}".format(binaryAddress + "\n"))
    else:
        if (address in symbol_table):
            binaryAddress = bin(int(symbol_table[address]))[2:]
            print(binaryAddress)  
            output_file.write("{0:0>17}".format(binaryAddress + "\n"))
    #step 3: write to file
    # TODO Stage B: revise to handle labels as well as integer constants
    pass

def first_pass(statement_list, symbol_table):
    """
    Given a list of statements, adds labels to the given symbol table.
    """
    # TODO Stage B: Add labels to symbol table
    # this should work
    for statement in statement_list:
        if statement_type(statement) == L_DIRECTIVE:
            address = statement_list.index(statement)
            symbol = statement[1:-1]
            symbol_table[symbol] = address
    pass

def second_pass(statement_list, symbol_table, output_filename):
    """
    Translates the given list of statements into a machine language program
    using the given symbol table. The program is written to a file 
    with the given name.
    """

    # Open output file
    output_file = open(output_filename, "w");
    if not output_file:
        FatalError("Cannot open output file " + output_filename)

    # Parse input file and emit code
    for statement in statement_list:
        if statement_type(statement) == A_INSTRUCTION:
            emit_A_instruction(statement, symbol_table, output_file)
        elif statement_type(statement) == C_INSTRUCTION:
            emit_C_instruction(statement, output_file)
        # Note that we do not emit instructions for label directives

    output_file.close()
   
def main():
    # Get input and output filenames
    input_filename = argv[1]
    match = re.match('^(.*)\.asm$', input_filename)
    if not match:
        FatalError(input_filename + " is not an asm file")
    output_filename = match.groups()[0] + ".hack"

    # Create a symbol table with predefined symbols
    symbol_table = init_symbol_table()

    # Read and preprocess the assembly source code into a list of statements
    list_of_statements = read_asm_file(input_filename)
    print(list_of_statements) #debug
    # Assemble the code!
    first_pass(list_of_statements, symbol_table)
    print(symbol_table) #debug
    second_pass(list_of_statements, symbol_table, output_filename)


if __name__ == '__main__':
    main();
