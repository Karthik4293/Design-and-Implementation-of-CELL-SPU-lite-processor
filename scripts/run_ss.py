#!/usr/bin/env python2

import sys
import subprocess

from subprocess import call

def gen_syn_script(N, M1, M2, M3, Mults, bits, clk):
    with open('runsynth_template.tcl', 'r') as file :
        filedata = file.read()

    filedata = filedata.replace('{ARG0}', str(N))
    filedata = filedata.replace('{ARG1}', str(M1))
    filedata = filedata.replace('{ARG2}', str(M2))
    filedata = filedata.replace('{ARG3}', str(M3))
    filedata = filedata.replace('{ARG4}', str(Mults))
    filedata = filedata.replace('{ARG5}', str(bits))
    filedata = filedata.replace('{CLK}' , str(clk))

    with open('runsynth_layer.tcl', 'w') as file:
        file.write(filedata)

    return "network_" + str(N)  + "_" + \
                        str(M1) + "_" + \
                        str(M2) + "_" + \
                        str(M3) + "_" + \
                        str(Mults) + "_" + str(bits) + ".txt"

def run_syn(N, M1, M2, M3, Mults, bits, clk):
    lname = gen_syn_script(N, M1, M2, M3, Mults, bits, clk)
    p1 = subprocess.Popen(["dc_shell", "-f", "runsynth_layer.tcl"], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["tee", lname], stdin=p1.stdout, stdout=subprocess.PIPE)
    p1.stdout.close()
    p2.communicate()

    with open(lname) as f:
        for line in f:
            if "Error" in line:
                print line
            elif "/CK" in line:
                print line
            elif "Warning" in line and "signed" not in line and "tran" not in line:
                print line
            elif "Total" in line and "undefined" not in line and "Dynamic" not in line:
                print line
            elif "slack" in line:
                print line

def run_sim(N, M1, M2, M3, Mults, bits):
    lname = "network_" + str(N)  + "_" + \
                         str(M1) + "_" + \
                         str(M2) + "_" + \
                         str(M3) + "_" + \
                         str(Mults) + "_" + str(bits) + ".log"

    p1 = subprocess.Popen(["./testmodetwo", str(N), str(M1), str(M2), str(M3), str(Mults), str(bits)], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["tee", lname], stdin=p1.stdout, stdout=subprocess.PIPE)
    p1.stdout.close()
    p2.communicate()

    with open(lname) as f:
        for line in f:
            if "errors" in line:
                print line
            elif "Throughput" in line:
                print line

N     = int(sys.argv[1]);
M1    = int(sys.argv[2]);
M2    = int(sys.argv[3]);
M3    = int(sys.argv[4]);
Mults = int(sys.argv[5]);
bits  = int(sys.argv[6]);
clk   = float(sys.argv[7]);

run_sim(N, M1, M2, M3, Mults, bits)
run_syn(N, M1, M2, M3, Mults, bits, clk)
