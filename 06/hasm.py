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
    if statement[0] == "@":
        return A_INSTRUCTION
    elif statement[0] == "(":
        return L_DIRECTIVE
    else:
        return C_INSTRUCTION
    
    
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
    
    #detect and index of POI
    A = ("=" in statement)
    B = (";" in statement)
    if (A): equalsIndex = statement.find("=")
    if (B): sColonIndex = statement.index(";")

    #find parts of instruction
    if (A and B):
        dest = statement[:equalsIndex]
        op = statement[equalsIndex + 1:sColonIndex]
        jump = statement[sColonIndex + 1:]
    elif (A and not B):
        dest = statement[:equalsIndex]
        op = statement[equalsIndex + 1:]
        jump = ""
    elif (B and not A):
        dest = ""
        op = statement[:sColonIndex]
        jump = statement[sColonIndex + 1:]
    else:
        dest = ""
        op = statement
        jump = ""

    #translate
    destination = codeTranslator.dest(dest)
    computation = codeTranslator.comp(op)
    jumpCode = codeTranslator.jump(jump)

    #assemble and output instruction
    translatedInstruction = "111" + str(computation) + str(destination) + str(jumpCode) + "\n"
    output_file.write(translatedInstruction)


def emit_A_instruction(statement, symbol_table, output_file):
    """
    Given an assembly language statement corresponding to an A-instruction,
    writes the corresponding machine language instruction to the given output
    file.  The machine langauge instruction should be expressed as a string of 
    16 characters "0" and "1". Each line of the output file should consist
    of exactly one machine language instruction.
    """
    # TODO Stage A: translate A instruction to machine instruction and write to file
    address = statement[1:]

    if (address in symbol_table):
        binaryAddress = bin(int(symbol_table[address]))[2:]
    elif (address.isdigit()):
        binaryAddress = bin(int(address))[2:]
    else:
        nextAvailibleAddress = 16
        while(nextAvailibleAddress in symbol_table.values()):
                nextAvailibleAddress +=1
        binaryAddress = bin(int(nextAvailibleAddress))[2:]
    output_file.write("{0:0>17}".format(binaryAddress + "\n"))
    

def first_pass(statement_list, symbol_table):
    """
    Given a list of statements, adds labels to the given symbol table.
    """
    # TODO Stage B: Add labels to symbol table
    ROMAddress = 0 #need to keep track of ROM address bc labels are not counted as instructions
    for statement in statement_list:
        if (statement_type(statement) == L_DIRECTIVE):
            label = statement[1:-1]
            symbol_table[label] = ROMAddress
        else:
            ROMAddress += 1 # only increment if label is not detected

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
    #print(list_of_statements) #debug
    # Assemble the code!
    first_pass(list_of_statements, symbol_table)
    #print(symbol_table) #debug
    second_pass(list_of_statements, symbol_table, output_filename)

if __name__ == '__main__':
    main();
