#!/usr/bin/env python2

import os
import sys
import subprocess

from subprocess import call

def gen_syn_script(name, clk):
    with open('cfg/runsynth_template.tcl', 'r') as file :
        filedata = file.read()

    filedata = filedata.replace('{ARG0}', name)
    filedata = filedata.replace('{CLK}' , str(clk))

    with open('synth/runsynth.tcl', 'w') as file:
        file.write(filedata)

    return "synth/" + name + ".txt"

def gen_sim_script(name):
    with open('cfg/runsim_template', 'r') as file :
        filedata = file.read()

    filedata = filedata.replace('{ARG0}', name)

    with open('sim/runsim', 'w') as file:
        file.write(filedata)

    os.chmod('sim/runsim', 0777)

    return "sim/" + name + ".txt"

def run_syn(name, clk):
    lname = gen_syn_script(name, clk)
    os.chdir("synth")
    subprocess.call(["dc_shell", "-f", "runsynth.tcl"])
    os.chdir("..")

def run_sim(mode, ins_file):
    lname = gen_sim_script(name)
    os.chdir("cfg")
    if(mode == "1"):
        subprocess.call(["./sasm.py", "even_ins.sasm", "even_ins_file.txt", mode])
        subprocess.call(["./sasm.py", "odd_ins.sasm", "odd_ins_file.txt", mode])
    else:
        subprocess.call(["./sasm.py", ins_file, "spu_mcode.bin", mode])
    os.chdir("..")
    os.chdir("sim")
    if(mode == "1"):
        subprocess.call(["cp", "-rf", "../cfg/even_ins_file.txt", "."])
        subprocess.call(["cp", "-rf", "../cfg/odd_ins_file.txt", "."])
    subprocess.call(["cp", "-rf", "../cfg/ls_load_file.txt", "."])
    subprocess.call(["./runsim"])
    os.chdir("..")

def print_usage():
    print sys.argv[0] + " flow [Top Module] [Clock]"
    print "flow:  sim, syn"
    print "<sim> target expects top module name only"
    print "<syn> target requires both top module and clock"

print "\n!!Welcome to SPU Mini Simulation Script!!"

if(len(sys.argv) == 1):
    print "Invalid number of arguments"
    print_usage()
    sys.exit(0)
else:
    flow = sys.argv[1]

if flow == "syn":
    if(len(sys.argv) < 4):
        print "Invalid number of arguments"
        print_usage()
        sys.exit(0)
    name = sys.argv[2]
    clk  = float(sys.argv[3])
    print "Running Synthesis on module " + name + "with clock period: " + str(clk)
    run_syn(name, clk)
elif flow == "sim":
    if(len(sys.argv) < 4):
        print "Invalid number of arguments"
        print_usage()
        sys.exit(0)
    name = sys.argv[2]
    ins_file = sys.argv[3]
    if(name == "sp_pipes_tb"):
        mode = "1"
    else:
        mode = "0"
    print "Running Simulation on module " + name
    run_sim(mode, ins_file)
elif flow == "clean":
    print "Cleaning Temp Files!"
    subprocess.call(["rm", "-rf", "synth/*", "sim/*"])
else:
    print "Invalid Argument: " + flow

print "!!SPU Mini Simulation Script finished sucessfully!!"


