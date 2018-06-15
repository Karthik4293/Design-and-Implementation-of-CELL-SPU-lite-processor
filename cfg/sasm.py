#!/usr/bin/env python2

import os
import sys
import re
import subprocess

from subprocess import call

ins_opcode = {}
ins_type   = {}

def print_usage():
    print sys.argv[0] + " <input file> <output file> <mode>."
    print "<input file> : Input assembly instruction file."
    print "<output file> : Output machine coded file."
    print "<mode> : 0 - Input is in assembly language, for full SPU sim."
    print "       : 1 - Input is in intermediate assembly language, for SPU pipes sim.\n"

print "\n!!Welcome to SPU Mini Assembler!!"

if(len(sys.argv) != 4):
    print "Invalid number of arguments\n"
    print_usage();
    sys.exit(0);
else:
    fname = sys.argv[1]
    fout = sys.argv[2]
    mode = int(sys.argv[3])
    print "Input file: " + fname + ", Output file: " + fout + ", Mode: " + sys.argv[3] 

with open("ins_dict.txt", 'r') as f:
    for line in f:
        items = line.split()
        key, value1, value2, value3 = items[0], items[1], items[2], items[3]
        if(mode == 1):
            ins_opcode[key] = value2
        else:
            ins_opcode[key] = value1
        ins_type[key] = value3
    f.close()

with open(fname) as f:
    fw = open(fout, 'w')
    for line in f:
        ls = line.strip()
        if(ls[0] == '#'):
            continue

        sys.stdout.write('.')
        sys.stdout.flush()
        #TODO: may have to strip all spaces when splitting
        words = line.split()
        mcode = ""
        opcode = words[0]

        if(opcode[0] == '/' and opcode[1] == '/'):
            continue

        if(mode == 1):
            syms = words[1].split(',')
            mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
            mcode += str(bin(int(syms[0]))[2:].zfill(18))
            mcode += str(bin(int(syms[1]))[2:].zfill(7))
            mcode += str(bin(int(syms[2]))[2:].zfill(7))
            mcode += str(bin(int(syms[3]))[2:].zfill(7))
            mcode += str(bin(int(syms[4]))[2:].zfill(7))
        else:
            #TODO: Have to write special cases for some instructions...
            itype = ins_type[opcode]
            syms = ""
            if(len(words) > 1):
                syms = words[1].split(',')
            if(len(syms) > 0):
                if(syms[0] == "$lr"):
                    syms[0] = '0'
                elif(syms[0] == "$sp"):
                    syms[0] = '1'
                elif(syms[0][0] == '$'):
                    syms[0] = syms[0][1:]
            if(len(syms) > 1):
                if(syms[1] == "$lr"):
                    syms[1] = '0'
                elif(syms[1] == "$sp"):
                    syms[1] = '1'
                elif(syms[1][0] == '$'):
                    syms[1] = syms[1][1:]
            if(len(syms) > 2):
                if(syms[2] == "$lr"):
                    syms[2] = '0'
                elif(syms[2] == "$sp"):
                    syms[2] = '1'
                elif(syms[2][0] == '$'):
                    syms[2] = syms[2][1:]
            if(len(syms) > 3):
                if(syms[3] == "$lr"):
                    syms[3] = '0'
                elif(syms[3] == "$sp"):
                    syms[3] = '1'
                elif(syms[3][0] == '$'):
                    syms[3] = syms[3][1:]
                    
            if(itype == "1" or itype == "3"): #RR or RI17
                #syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
                if(opcode == "bi"): 
                    mcode += str(bin(int("0") % (1 << 7))[2:].zfill(7))
                    mcode += str(bin(int(syms[0]) % (1 << 7))[2:].zfill(7))
                    mcode += str(bin(int("0") % (1 << 7))[2:].zfill(7))
                else:
                    mcode += str(bin(int(syms[0]) % (1 << 7))[2:].zfill(7))
                    mcode += str(bin(int(syms[1]) % (1 << 7))[2:].zfill(7))
                    mcode += str(bin(int(syms[2]) % (1 << 7))[2:].zfill(7))
            elif(itype == "2"): #RRR
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(4))
                mcode += str(bin(int(syms[0]) % (1 << 7))[2:].zfill(7))
                mcode += str(bin(int(syms[1]) % (1 << 7))[2:].zfill(7))
                mcode += str(bin(int(syms[2]) % (1 << 7))[2:].zfill(7))
                mcode += str(bin(int(syms[3]) % (1 << 7))[2:].zfill(7))
            elif(itype == "4"): #RI10
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(8))
                mcode += str(bin(int(syms[0]) % (1 << 10))[2:].zfill(10))
                mcode += str(bin(int(syms[1]) % (1 << 7))[2:].zfill(7))
                mcode += str(bin(int(syms[2]) % (1 << 7))[2:].zfill(7))
            elif(itype == "5"): #RI16
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(9))
                if(opcode == "br" or opcode == "bra"):
                    mcode += str(bin(int(syms[0]) % (1 << 16))[2:].zfill(16))
                    mcode += str(bin(int("0") % (1 << 7))[2:].zfill(7))
                else:
                    mcode += str(bin(int(syms[0]) % (1 << 16))[2:].zfill(16))
                    mcode += str(bin(int(syms[1]) % (1 << 7))[2:].zfill(7))
            elif(itype == "6"): #RI18
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(7))
                mcode += str(bin(int(syms[0]) % (1 << 18))[2:].zfill(18))
                mcode += str(bin(int(syms[1]) % (1 << 7))[2:].zfill(7))
            else:
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
                mcode += str(bin(int("0") % (1 << 21))[2:].zfill(21))

        fw.write(mcode + "\n")

    print "\n"
    fw.close()
    f.close()

with open(fout) as f:
    num_ins = 0
    fw = open("ls_load_file.txt", 'w')
    for line in f:
        by = re.findall('........', line)
        for word in by:
            fw.write(word + "\n")
            num_ins+=1

    word = "00000000"
    while num_ins < 992:
        fw.write(word + "\n")
        num_ins+=1

    fd = open("data_file.txt", 'r')
    for line in fd:
        fw.write(line)

print "!!SPU Mini Assembler finished sucessfully!!\n"

