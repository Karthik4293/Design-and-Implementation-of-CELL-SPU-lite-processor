// ------------------------------------------//
//  
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal
// NETID: aahangar
// SBUID: 111416569
//
// NAME: Karthik Raj
// NETID: karamachandr
// SBUID: 111675685
// ------------------------------------------//

import defines_pkg::*;

module decode 
(
    input  logic             clk,
    input  logic             rst,
    input  logic [0:31]      eins1,
    input  logic [0:31]      eins2,
    input  logic             dep_stall,
    input  logic             flush,
    input  logic [0:31]      pc_in,
    output logic [0:31]      pc_out,
    output logic             dec_stall,
    output Opcodes           opcode_ep,
    output Opcodes           opcode_op,
    output logic [0:6]       ra_addr_ep,
    output logic [0:6]       rb_addr_ep,
    output logic [0:6]       rc_addr_ep,
    output logic [0:6]       rt_addr_ep,
    output logic [0:6]       ra_addr_op,
    output logic [0:6]       rb_addr_op,
    output logic [0:6]       rc_addr_op,
    output logic [0:6]       rt_addr_op,
    output logic [0:6]       in_I7e,
    output logic [0:7]       in_I8e,
    output logic [0:9]       in_I10e,
    output logic [0:15]      in_I16e,
    output logic [0:17]      in_I18e,
    output logic [0:6]       in_I7o,
    output logic [0:7]       in_I8o,
    output logic [0:9]       in_I10o,
    output logic [0:15]      in_I16o,
    output logic [0:17]      in_I18o
);

    localparam EVEN = 0;
    localparam ODD  = 1;

    Opcodes      opcode_i1;
    Opcodes      opcode_i2;
    logic [0:6]  ra_addr_i1;
    logic [0:6]  rb_addr_i1;
    logic [0:6]  rc_addr_i1;
    logic [0:6]  rt_addr_i1;
    logic [0:6]  ra_addr_i2;
    logic [0:6]  rb_addr_i2;
    logic [0:6]  rc_addr_i2;
    logic [0:6]  rt_addr_i2;
    logic [0:6]  in_I7_i1;
    logic [0:7]  in_I8_i1;
    logic [0:9]  in_I10_i1;
    logic [0:15] in_I16_i1;
    logic [0:17] in_I18_i1;
    logic [0:6]  in_I7_i2;
    logic [0:7]  in_I8_i2;
    logic [0:9]  in_I10_i2;
    logic [0:15] in_I16_i2;
    logic [0:17] in_I18_i2;

    logic        stall_done;
    logic [0:3]  eoc1_4b;
    logic [0:3]  eoc2_4b;
    logic [0:6]  eoc1_7b;
    logic [0:6]  eoc2_7b;
    logic [0:7]  eoc1_8b;
    logic [0:7]  eoc2_8b;
    logic [0:8]  eoc1_9b;
    logic [0:8]  eoc2_9b;
    logic [0:10] eoc1_11b;
    logic [0:10] eoc2_11b;

    logic        ins1_type;
    logic        ins2_type;

    assign eoc1_4b  = eins1[0:3];
    assign eoc2_4b  = eins2[0:3];
    assign eoc1_7b  = eins1[0:6];
    assign eoc2_7b  = eins2[0:6];
    assign eoc1_8b  = eins1[0:7];
    assign eoc2_8b  = eins2[0:7];
    assign eoc1_9b  = eins1[0:8];
    assign eoc2_9b  = eins2[0:8];
    assign eoc1_11b = eins1[0:10];
    assign eoc2_11b = eins2[0:10];

    always_ff @(posedge clk) begin
        if(rst) begin
            stall_done <= 'd0;
            opcode_ep <= LNOP;
            opcode_op <= NOP;
            ra_addr_ep <= 'dx;
            rb_addr_ep <= 'dx;
            rc_addr_ep <= 'dx;
            rt_addr_ep <= 'dx;
            ra_addr_op <= 'dx;
            rb_addr_op <= 'dx;
            rc_addr_op <= 'dx;
            rt_addr_op <= 'dx;
            in_I7e <= 'dx;
            in_I8e <= 'dx;
            in_I10e <= 'dx;
            in_I16e <= 'dx;
            in_I18e <= 'dx;
            in_I7o <= 'dx;
            in_I8o <= 'dx;
            in_I10o <= 'dx;
            in_I16o <= 'dx;
            in_I18o <= 'dx;
            pc_out <= 'dx;
        end
        else begin
            if(flush) begin
                stall_done <= 'd0;
                opcode_ep <= LNOP;
                opcode_op <= NOP;
                ra_addr_ep <= 'dx;
                rb_addr_ep <= 'dx;
                rc_addr_ep <= 'dx;
                rt_addr_ep <= 'dx;
                ra_addr_op <= 'dx;
                rb_addr_op <= 'dx;
                rc_addr_op <= 'dx;
                rt_addr_op <= 'dx;
                in_I7e <= 'dx;
                in_I8e <= 'dx;
                in_I10e <= 'dx;
                in_I16e <= 'dx;
                in_I18e <= 'dx;
                in_I7o <= 'dx;
                in_I8o <= 'dx;
                in_I10o <= 'dx;
                in_I16o <= 'dx;
                in_I18o <= 'dx;
                pc_out <= pc_in;
            end
            else if(dep_stall) begin
                stall_done <= stall_done;
                opcode_ep <= opcode_ep;
                opcode_op <= opcode_op;
                ra_addr_ep <= ra_addr_ep;
                rb_addr_ep <= rb_addr_ep;
                rc_addr_ep <= rc_addr_ep;
                rt_addr_ep <= rt_addr_ep;
                ra_addr_op <= ra_addr_op;
                rb_addr_op <= rb_addr_op;
                rc_addr_op <= rc_addr_op;
                rt_addr_op <= rt_addr_op;
                in_I7e <= in_I7e;
                in_I8e <= in_I8e;
                in_I10e <= in_I10e;
                in_I16e <= in_I16e;
                in_I18e <= in_I18e;
                in_I7o <= in_I7o;
                in_I8o <= in_I8o;
                in_I10o <= in_I10o;
                in_I16o <= in_I16o;
                in_I18o <= in_I18o;
                pc_out <= pc_in;
            end
            else if(dec_stall || stall_done) begin
                if(stall_done) begin
                    if(ins2_type == EVEN) begin
                        opcode_ep  <= opcode_i2;
                        ra_addr_ep <= ra_addr_i2;
                        rb_addr_ep <= rb_addr_i2;
                        rc_addr_ep <= rc_addr_i2;
                        rt_addr_ep <= rt_addr_i2;
                        in_I7e     <= in_I7_i2;
                        in_I8e     <= in_I8_i2;
                        in_I10e    <= in_I10_i2;
                        in_I16e    <= in_I16_i2;
                        in_I18e    <= in_I18_i2;
                        opcode_op  <= NOP;
                        ra_addr_op <= 'dx;
                        rb_addr_op <= 'dx;
                        rc_addr_op <= 'dx;
                        rt_addr_op <= 'dx;
                        in_I7o     <= 'dx;
                        in_I8o     <= 'dx;
                        in_I10o    <= 'dx;
                        in_I16o    <= 'dx;
                        in_I18o    <= 'dx;
                        pc_out <= pc_in;
                    end
                    else begin
                        opcode_op  <= opcode_i2;
                        ra_addr_op <= ra_addr_i2;
                        rb_addr_op <= rb_addr_i2;
                        rc_addr_op <= rc_addr_i2;
                        rt_addr_op <= rt_addr_i2;
                        in_I7o     <= in_I7_i2;
                        in_I8o     <= in_I8_i2;
                        in_I10o    <= in_I10_i2;
                        in_I16o    <= in_I16_i2;
                        in_I18o    <= in_I18_i2;
                        opcode_ep  <= LNOP;
                        ra_addr_ep <= 'dx;
                        rb_addr_ep <= 'dx;
                        rc_addr_ep <= 'dx;
                        rt_addr_ep <= 'dx;
                        in_I7e     <= 'dx;
                        in_I8e     <= 'dx;
                        in_I10e    <= 'dx;
                        in_I16e    <= 'dx;
                        in_I18e    <= 'dx;
                        pc_out     <= pc_in + 32'd4;
                    end
                    stall_done <= (dep_stall == 1) ? 1'b1 : 1'b0;
                end
                else begin
                    if(ins1_type == EVEN) begin
                        opcode_ep  <= opcode_i1;
                        ra_addr_ep <= ra_addr_i1;
                        rb_addr_ep <= rb_addr_i1;
                        rc_addr_ep <= rc_addr_i1;
                        rt_addr_ep <= rt_addr_i1;
                        in_I7e     <= in_I7_i1;
                        in_I8e     <= in_I8_i1;
                        in_I10e    <= in_I10_i1;
                        in_I16e    <= in_I16_i1;
                        in_I18e    <= in_I18_i1;
                        opcode_op  <= NOP;
                        ra_addr_op <= 'dx;
                        rb_addr_op <= 'dx;
                        rc_addr_op <= 'dx;
                        rt_addr_op <= 'dx;
                        in_I7o     <= 'dx;
                        in_I8o     <= 'dx;
                        in_I10o    <= 'dx;
                        in_I16o    <= 'dx;
                        in_I18o    <= 'dx;
                        pc_out <= pc_in;
                    end
                    else begin
                        opcode_op  <= opcode_i1;
                        ra_addr_op <= ra_addr_i1;
                        rb_addr_op <= rb_addr_i1;
                        rc_addr_op <= rc_addr_i1;
                        rt_addr_op <= rt_addr_i1;
                        in_I7o     <= in_I7_i1;
                        in_I8o     <= in_I8_i1;
                        in_I10o    <= in_I10_i1;
                        in_I16o    <= in_I16_i1;
                        in_I18o    <= in_I18_i1;
                        opcode_ep  <= LNOP;
                        ra_addr_ep <= 'dx;
                        rb_addr_ep <= 'dx;
                        rc_addr_ep <= 'dx;
                        rt_addr_ep <= 'dx;
                        in_I7e     <= 'dx;
                        in_I8e     <= 'dx;
                        in_I10e    <= 'dx;
                        in_I16e    <= 'dx;
                        in_I18e    <= 'dx;
                        pc_out     <= pc_in;
                    end
                    stall_done <= (dep_stall == 1) ? 1'b0 : 1'b1;
                end
            end
            else begin
                if(ins1_type == EVEN) begin
                    opcode_ep  <= opcode_i1;
                    ra_addr_ep <= ra_addr_i1;
                    rb_addr_ep <= rb_addr_i1;
                    rc_addr_ep <= rc_addr_i1;
                    rt_addr_ep <= rt_addr_i1;
                    in_I7e     <= in_I7_i1;
                    in_I8e     <= in_I8_i1;
                    in_I10e    <= in_I10_i1;
                    in_I16e    <= in_I16_i1;
                    in_I18e    <= in_I18_i1;
                    opcode_op  <= opcode_i2;
                    ra_addr_op <= ra_addr_i2;
                    rb_addr_op <= rb_addr_i2;
                    rc_addr_op <= rc_addr_i2;
                    rt_addr_op <= rt_addr_i2;
                    in_I7o     <= in_I7_i2;
                    in_I8o     <= in_I8_i2;
                    in_I10o    <= in_I10_i2;
                    in_I16o    <= in_I16_i2;
                    in_I18o    <= in_I18_i2;
                    pc_out     <= pc_in + 32'd4;
                end
                else begin
                    opcode_ep  <= opcode_i2;
                    ra_addr_ep <= ra_addr_i2;
                    rb_addr_ep <= rb_addr_i2;
                    rc_addr_ep <= rc_addr_i2;
                    rt_addr_ep <= rt_addr_i2;
                    in_I7e     <= in_I7_i2;
                    in_I8e     <= in_I8_i2;
                    in_I10e    <= in_I10_i2;
                    in_I16e    <= in_I16_i2;
                    in_I18e    <= in_I18_i2;
                    opcode_op  <= opcode_i1;
                    ra_addr_op <= ra_addr_i1;
                    rb_addr_op <= rb_addr_i1;
                    rc_addr_op <= rc_addr_i1;
                    rt_addr_op <= rt_addr_i1;
                    in_I7o     <= in_I7_i1;
                    in_I8o     <= in_I8_i1;
                    in_I10o    <= in_I10_i1;
                    in_I16o    <= in_I16_i1;
                    in_I18o    <= in_I18_i1;
                    pc_out     <= pc_in;
                end
            end
        end
    end

    always_comb begin
        opcode_i1  = LNOP;
        opcode_i2  = NOP;
        ins1_type  = EVEN;
        ins2_type  = ODD;
        ra_addr_i1 = 'dx;
        rb_addr_i1 = 'dx;
        rc_addr_i1 = 'dx;
        rt_addr_i1 = 'dx;
        ra_addr_i2 = 'dx;
        rb_addr_i2 = 'dx;
        rc_addr_i2 = 'dx;
        rt_addr_i2 = 'dx;
        in_I7_i1   = 'dx;  
        in_I8_i1   = 'dx; 
        in_I10_i1  = 'dx;
        in_I16_i1  = 'dx;
        in_I18_i1  = 'dx;
        in_I7_i2   = 'dx;
        in_I8_i2   = 'dx;
        in_I10_i2  = 'dx;
        in_I16_i2  = 'dx;
        in_I18_i2  = 'dx;

        if(eins1 == 32'hffffffff) begin
            opcode_i1 = CMISS;
            ins1_type = ODD;
        end
        else if(eoc1_4b == 4'b1100 || eoc1_4b == 4'b1110 || eoc1_4b == 4'b1111) begin
            ins1_type  = EVEN;
            rt_addr_i1 = eins1[4:10];
            ra_addr_i1 = eins1[11:17];
            rb_addr_i1 = eins1[18:24];
            rc_addr_i1 = eins1[25:31];
            case(eoc1_4b)
                4'b1100:
                    begin
                        opcode_i1 = MULTIPLY_AND_ADD;
                    end
                4'b1110:
                    begin
                        opcode_i1 = FLOATING_MULTIPLY_AND_ADD;
                    end
                4'b1111:
                    begin
                        opcode_i1 = FLOATING_MULTIPLY_AND_SUBTRACT;
                    end
            endcase
        end
        else if(eoc1_7b == 7'b0100001) begin
            ins1_type = EVEN;
            rt_addr_i1 = eins1[25:31];
            in_I18_i1  = eins1[7:24];
            opcode_i1  = IMMEDIATE_LOAD_ADDRESS;
        end
        else if(eoc1_8b == 8'b00011101 || eoc1_8b == 8'b00011100 || eoc1_8b == 8'b00001101 || eoc1_8b == 8'b00001100 ||
                eoc1_8b == 8'b00010100 || eoc1_8b == 8'b00010101 || eoc1_8b == 8'b00010110 || eoc1_8b == 8'b00000100 ||
                eoc1_8b == 8'b00000101 || eoc1_8b == 8'b00000110 || eoc1_8b == 8'b01000100 || eoc1_8b == 8'b01000110 ||
                eoc1_8b == 8'b01111100 || eoc1_8b == 8'b01111110 || eoc1_8b == 8'b01001100 || eoc1_8b == 8'b01001101 ||
                eoc1_8b == 8'b00110100 || eoc1_8b == 8'b00100100 || eoc1_8b == 8'b01110100 || eoc1_8b == 8'b01000101) begin
            rt_addr_i1 = eins1[25:31];
            ra_addr_i1 = eins1[18:24];
            in_I10_i1  = eins1[8:17];
            case(eoc1_8b)
                8'b00011101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = ADD_HALF_WORD_IMMEDIATE;
                    end
                8'b00011100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = ADD_WORD_IMMEDIATE;
                    end
                8'b00001101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = SUBTRACT_FROM_HALFWORD_IMMEDIATE;
                    end
                8'b00001100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = SUBTRACT_FROM_WORD_IMMEDIATE;
                    end
                8'b00010100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_WORD_IMMEDIATE;
                    end
                8'b00010101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_HALFWORD_IMMEDIATE;
                    end
                8'b00010110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_BYTE_IMMEDIATE;
                    end
                8'b00000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_WORD_IMMEDIATE;
                    end
                8'b00000101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_HALFWORD_IMMEDIATE;
                    end
                8'b00000110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_BYTE_IMMEDIATE;
                    end
                8'b01000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_WORD_IMMEDIATE;
                    end
                8'b01000101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_HALFWORD_IMMEDIATE;
                    end
                8'b01000110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_BYTE_IMMEDIATE;
                    end
                8'b01111100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_EQUAL_WORD_IMMEDIATE;
                    end
                8'b01111110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_EQUAL_HALFWORD_IMMEDIATE;
                    end
                8'b01001100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_GREATER_THAN_WORD_IMMEDIATE;
                    end
                8'b01001101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE;
                    end
                8'b00110100:
                    begin
                        ins1_type = ODD;
                        opcode_i1  = LOAD_QUADWORD_DFORM;
                    end
                8'b00100100:
                    begin
                        ins1_type  = ODD;
                        opcode_i1  = STORE_QUADWORD_DFORM;
                        rc_addr_i1 = eins1[25:31];
                    end
                8'b01110100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = MULTIPLY_IMMEDIATE;
                    end
            endcase
        end
        else if(eoc1_9b == 9'b010000011 || eoc1_9b == 9'b010000001 || eoc1_9b == 9'b001100001 ||
                eoc1_9b == 9'b001000001 || eoc1_9b == 9'b001100110 || eoc1_9b == 9'b001100010 ||
                eoc1_9b == 9'b001100100 || eoc1_9b == 9'b001100000 || eoc1_9b == 9'b001000010 ||
                eoc1_9b == 9'b001000000 || eoc1_9b == 9'b001000110 || eoc1_9b == 9'b001000100) begin
            in_I16_i1  = eins1[9:24];
            rt_addr_i1 = eins1[25:31];
            case(eoc1_9b)
                9'b010000011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = IMMEDIATE_LOAD_HALFWORD;
                    end
                9'b010000001:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = IMMEDIATE_LOAD_WORD;
                    end
                9'b001100001:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = LOAD_QUADWORD_AFORM;
                    end
                9'b001000001:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = STORE_QUADWORD_AFORM;
                    end
                9'b001100110:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_RELATIVE_AND_SET_LINK;
                    end
                9'b001100010:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_ABSOLUTE_AND_SET_LINK;
                    end
                9'b001100100:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_RELATIVE;
                    end
                9'b001100000:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_ABSOLUTE;
                    end
                9'b001000010:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_IF_NOT_ZERO_WORD;
                    end
                9'b001000000:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_IF_ZERO_WORD;
                    end
                9'b001000110:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_IF_NOT_ZERO_HALFWORD;
                    end
                9'b001000100:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_IF_ZERO_HALFWORD;
                    end
            endcase
        end
        else begin
            rt_addr_i1 = eins1[25:31];
            ra_addr_i1 = eins1[18:24];
            rb_addr_i1 = eins1[11:17];
            case(eoc1_11b) 
                11'b00011001000: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ADD_HALF_WORD;
                    end
                11'b00011000000: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ADD_WORD;
                    end
                11'b00001001000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SUBTRACT_FROM_HALFWORD;
                    end
                11'b00001000000: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SUBTRACT_FROM_WORD;
                    end
                11'b01101000000: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ADD_EXTENDED;
                    end
                11'b01101000001:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SUBTRACT_FROM_EXTENDED;
                    end
                11'b00011000010: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = CARRY_GENERATE;
                    end
                11'b00001000010: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = BORROW_GENERATE;
                    end
                11'b01010100101:
                    begin
                        ins1_type  = EVEN;
                        opcode_i1  = COUNT_LEADING_ZEROS;
                        rb_addr_i1 = 'dx;
                    end
                11'b00011000001: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = AND;
                    end
                11'b00001000001: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = OR;
                    end
                11'b01001000001:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = EXCLUSIVE_OR;
                    end
                11'b00011001001: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = NAND;
                    end
                11'b00001001001: 
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = NOR;
                    end
                11'b01001001001:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = EQUIVALENT;
                    end
                11'b01111000000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = COMPARE_EQUAL_WORD;
                    end
                11'b01111001000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = COMPARE_EQUAL_HALFWORD;
                    end
                11'b01001000000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = COMPARE_GREATER_THAN_WORD;
                    end
                11'b01001001000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = COMPARE_GREATER_THAN_HALFWORD;
                    end
                11'b00001011111:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SHIFT_LEFT_HALFWORD;
                    end
                11'b00001111111:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SHIFT_LEFT_HALFWORD_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00001011011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SHIFT_LEFT_WORD;
                    end
                11'b00001111011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SHIFT_LEFT_WORD_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00111011011:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = SHIFT_LEFT_QUADWORD_BY_BITS;
                    end
                11'b00111111011:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00111011111:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = SHIFT_LEFT_QUADWORD_BY_BYTES;
                    end
                11'b00111111111:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00001011000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ROTATE_WORD;
                    end
                11'b00001111100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ROTATE_WORD_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00111011000:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = ROTATE_QUADWORD_BY_BITS;
                    end
                11'b00111111000:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = ROTATE_QUADWORD_BY_BITS_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00111011100:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = ROTATE_QUADWORD_BY_BYTES;
                    end
                11'b00111111100:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = ROTATE_QUADWORD_BY_BYTES_IMMEDIATE;
                        in_I7_i1  = eins1[11:17];
                        rb_addr_i1 = 'dx;
                    end
                11'b00110101000:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = BRANCH_INDIRECT;
                        ra_addr_i1 = eins1[18:24];
                        rb_addr_i1 = 'dx;
                        rt_addr_i1 = 'dx;
                    end
                11'b01011000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_ADD;
                    end
                11'b01011000101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_SUBTRACT;
                    end
                11'b01011000110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_MULTIPLY;
                    end
                11'b01111000010:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_COMPARE_EQUAL;
                    end
                11'b01111001010:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_COMPARE_MAGNITUDE_EQUAL;
                    end
                11'b01011000010:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_COMPARE_GREATER_THAN;
                    end
                11'b01011001010:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = FLOATING_COMPARE_MAGNITUDE_GREATER_THAN;
                    end
                11'b01111000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = MULTIPLY;
                    end
                11'b00000000000:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = STOP;
                        ra_addr_i1 = 'dx;
                        rb_addr_i1 = 'dx;
                        rt_addr_i1 = 'dx;
                    end
                11'b01010110100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = COUNT_ONES_IN_BYTES;
                    end
                11'b00011010011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = AVERAGE_BYTES;
                    end
                11'b00001010011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = ABSOLUTE_DIFFERENCE_OF_BYTES;
                    end
                11'b01001010011:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = SUM_BYTES_INTO_HALFWORDS;
                    end
                11'b00000000001:
                    begin
                        ins1_type = EVEN;
                        opcode_i1 = LNOP;
                        ra_addr_i1 = 'dx;
                        rb_addr_i1 = 'dx;
                        rc_addr_i1 = 'dx;
                        rt_addr_i1 = 'dx;
                    end
                11'b01000000001:
                    begin
                        ins1_type = ODD;
                        opcode_i1 = NOP;
                        ra_addr_i1 = 'dx;
                        rb_addr_i1 = 'dx;
                        rc_addr_i1 = 'dx;
                        rt_addr_i1 = 'dx;
                    end
            endcase
        end

        if(eins2 == 32'hffffffff) begin
            opcode_i2 = LNOP;
            ins2_type = EVEN;
        end
        else if(eoc2_4b == 4'b1100 || eoc2_4b == 4'b1110 || eoc2_4b == 4'b1111) begin
            ins2_type  = EVEN;
            rt_addr_i2 = eins2[4:10];
            ra_addr_i2 = eins2[11:17];
            rb_addr_i2 = eins2[18:24];
            rc_addr_i2 = eins2[25:31];
            case(eoc2_4b)
                4'b1100:
                    begin
                        opcode_i2 = MULTIPLY_AND_ADD;
                    end
                4'b1110:
                    begin
                        opcode_i2 = FLOATING_MULTIPLY_AND_ADD;
                    end
                4'b1111:
                    begin
                        opcode_i2 = FLOATING_MULTIPLY_AND_SUBTRACT;
                    end
            endcase
        end
        else if(eoc2_7b == 7'b0100001) begin
            ins2_type = EVEN;
            rt_addr_i2 = eins2[25:31];
            in_I18_i2  = eins2[7:24];
            opcode_i2  = IMMEDIATE_LOAD_ADDRESS;
        end
        else if(eoc2_8b == 8'b00011101 || eoc2_8b == 8'b00011100 || eoc2_8b == 8'b00001101 || eoc2_8b == 8'b00001100 ||
                eoc2_8b == 8'b00010100 || eoc2_8b == 8'b00010101 || eoc2_8b == 8'b00010110 || eoc2_8b == 8'b00000100 ||
                eoc2_8b == 8'b00000101 || eoc2_8b == 8'b00000110 || eoc2_8b == 8'b01000100 || eoc2_8b == 8'b01000110 ||
                eoc2_8b == 8'b01111100 || eoc2_8b == 8'b01111110 || eoc2_8b == 8'b01001100 || eoc2_8b == 8'b01001101 ||
                eoc2_8b == 8'b00110100 || eoc2_8b == 8'b00100100 || eoc2_8b == 8'b01110100 || eoc2_8b == 8'b01000101) begin
            rt_addr_i2 = eins2[25:31];
            ra_addr_i2 = eins2[18:24];
            in_I10_i2  = eins2[8:17];
            case(eoc2_8b)
                8'b00011101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = ADD_HALF_WORD_IMMEDIATE;
                    end
                8'b00011100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = ADD_WORD_IMMEDIATE;
                    end
                8'b00001101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = SUBTRACT_FROM_HALFWORD_IMMEDIATE;
                    end
                8'b00001100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = SUBTRACT_FROM_WORD_IMMEDIATE;
                    end
                8'b00010100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_WORD_IMMEDIATE;
                    end
                8'b00010101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_HALFWORD_IMMEDIATE;
                    end
                8'b00010110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_BYTE_IMMEDIATE;
                    end
                8'b00000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_WORD_IMMEDIATE;
                    end
                8'b00000101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_HALFWORD_IMMEDIATE;
                    end
                8'b00000110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_BYTE_IMMEDIATE;
                    end
                8'b01000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_WORD_IMMEDIATE;
                    end
                8'b01000101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_HALFWORD_IMMEDIATE;
                    end
                8'b01000110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_BYTE_IMMEDIATE;
                    end
                8'b01111100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_EQUAL_WORD_IMMEDIATE;
                    end
                8'b01111110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_EQUAL_HALFWORD_IMMEDIATE;
                    end
                8'b01001100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_GREATER_THAN_WORD_IMMEDIATE;
                    end
                8'b01001101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE;
                    end
                8'b00110100:
                    begin
                        ins2_type = ODD;
                        opcode_i2  = LOAD_QUADWORD_DFORM;
                    end
                8'b00100100:
                    begin
                        ins2_type = ODD;
                        opcode_i2  = STORE_QUADWORD_DFORM;
                        rc_addr_i2 = eins2[25:31];
                    end
                8'b01110100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = MULTIPLY_IMMEDIATE;
                    end
            endcase
        end
        else if(eoc2_9b == 9'b010000011 || eoc2_9b == 9'b010000001 || eoc2_9b == 9'b001100001 ||
                eoc2_9b == 9'b001000001 || eoc2_9b == 9'b001100110 || eoc2_9b == 9'b001100010 ||
                eoc2_9b == 9'b001100100 || eoc2_9b == 9'b001100000 || eoc2_9b == 9'b001000010 ||
                eoc2_9b == 9'b001000000 || eoc2_9b == 9'b001000110 || eoc2_9b == 9'b001000100) begin
            in_I16_i2  = eins2[9:24];
            rt_addr_i2 = eins2[25:31];
            case(eoc2_9b)
                9'b010000011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = IMMEDIATE_LOAD_HALFWORD;
                    end
                9'b010000001:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = IMMEDIATE_LOAD_WORD;
                    end
                9'b001100001:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = LOAD_QUADWORD_AFORM;
                    end
                9'b001000001:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = STORE_QUADWORD_AFORM;
                    end
                9'b001100110:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_RELATIVE_AND_SET_LINK;
                    end
                9'b001100010:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_ABSOLUTE_AND_SET_LINK;
                    end
                9'b001100100:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_RELATIVE;
                    end
                9'b001100000:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_ABSOLUTE;
                    end
                9'b001000010:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_IF_NOT_ZERO_WORD;
                    end
                9'b001000000:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_IF_ZERO_WORD;
                    end
                9'b001000110:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_IF_NOT_ZERO_HALFWORD;
                    end
                9'b001000100:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_IF_ZERO_HALFWORD;
                    end
            endcase
        end
        else begin
            rt_addr_i2 = eins2[25:31];
            ra_addr_i2 = eins2[18:24];
            rb_addr_i2 = eins2[11:17];
            case(eoc2_11b) 
                11'b00011001000: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ADD_HALF_WORD;
                    end
                11'b00011000000: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ADD_WORD;
                    end
                11'b00001001000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SUBTRACT_FROM_HALFWORD;
                    end
                11'b00001000000: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SUBTRACT_FROM_WORD;
                    end
                11'b01101000000: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ADD_EXTENDED;
                    end
                11'b01101000001:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SUBTRACT_FROM_EXTENDED;
                    end
                11'b00011000010: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = CARRY_GENERATE;
                    end
                11'b00001000010: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = BORROW_GENERATE;
                    end
                11'b01010100101:
                    begin
                        ins2_type  = EVEN;
                        opcode_i2  = COUNT_LEADING_ZEROS;
                        rb_addr_i2 = 'dx;
                    end
                11'b00011000001: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = AND;
                    end
                11'b00001000001: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = OR;
                    end
                11'b01001000001:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = EXCLUSIVE_OR;
                    end
                11'b00011001001: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = NAND;
                    end
                11'b00001001001: 
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = NOR;
                    end
                11'b01001001001:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = EQUIVALENT;
                    end
                11'b01111000000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = COMPARE_EQUAL_WORD;
                    end
                11'b01111001000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = COMPARE_EQUAL_HALFWORD;
                    end
                11'b01001000000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = COMPARE_GREATER_THAN_WORD;
                    end
                11'b01001001000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = COMPARE_GREATER_THAN_HALFWORD;
                    end
                11'b00001011111:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SHIFT_LEFT_HALFWORD;
                    end
                11'b00001111111:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SHIFT_LEFT_HALFWORD_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00001011011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SHIFT_LEFT_WORD;
                    end
                11'b00001111011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SHIFT_LEFT_WORD_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00111011011:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = SHIFT_LEFT_QUADWORD_BY_BITS;
                    end
                11'b00111111011:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00111011111:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = SHIFT_LEFT_QUADWORD_BY_BYTES;
                    end
                11'b00111111111:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00001011000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ROTATE_WORD;
                    end
                11'b00001111100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ROTATE_WORD_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00111011000:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = ROTATE_QUADWORD_BY_BITS;
                    end
                11'b00111111000:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = ROTATE_QUADWORD_BY_BITS_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00111011100:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = ROTATE_QUADWORD_BY_BYTES;
                    end
                11'b00111111100:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = ROTATE_QUADWORD_BY_BYTES_IMMEDIATE;
                        in_I7_i2  = eins2[11:17];
                        rb_addr_i2 = 'dx;
                    end
                11'b00110101000:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = BRANCH_INDIRECT;
                        ra_addr_i2 = eins2[18:24];
                        rb_addr_i2 = 'dx;
                        rt_addr_i2 = 'dx;
                    end
                11'b01011000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_ADD;
                    end
                11'b01011000101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_SUBTRACT;
                    end
                11'b01011000110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_MULTIPLY;
                    end
                11'b01111000010:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_COMPARE_EQUAL;
                    end
                11'b01111001010:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_COMPARE_MAGNITUDE_EQUAL;
                    end
                11'b01011000010:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_COMPARE_GREATER_THAN;
                    end
                11'b01011001010:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = FLOATING_COMPARE_MAGNITUDE_GREATER_THAN;
                    end
                11'b01111000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = MULTIPLY;
                    end
                11'b00000000000:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = STOP;
                    end
                11'b01010110100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = COUNT_ONES_IN_BYTES;
                    end
                11'b00011010011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = AVERAGE_BYTES;
                    end
                11'b00001010011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = ABSOLUTE_DIFFERENCE_OF_BYTES;
                    end
                11'b01001010011:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = SUM_BYTES_INTO_HALFWORDS;
                    end
                11'b00000000001:
                    begin
                        ins2_type = EVEN;
                        opcode_i2 = LNOP;
                        ra_addr_i2 = 'dx;
                        rb_addr_i2 = 'dx;
                        rc_addr_i2 = 'dx;
                        rt_addr_i2 = 'dx;
                    end
                11'b01000000001:
                    begin
                        ins2_type = ODD;
                        opcode_i2 = NOP;
                        ra_addr_i2 = 'dx;
                        rb_addr_i2 = 'dx;
                        rc_addr_i2 = 'dx;
                        rt_addr_i2 = 'dx;
                    end
            endcase
        end

        if(stall_done || flush) begin
            dec_stall = 0;
        end
        else if((ins1_type == EVEN && ins2_type == EVEN) || 
                (ins1_type == ODD  && ins2_type == ODD))
        begin
            dec_stall = 1;
        end
        else if(((rt_addr_i1 == rt_addr_i2) && rt_addr_i1 !== 7'dx && rt_addr_i2 !== 7'dx) ||
                (rt_addr_i1 == ra_addr_i2 || rt_addr_i2 == ra_addr_i1) ||
                (rt_addr_i1 == rb_addr_i2 || rt_addr_i2 == rb_addr_i1) ||
                (rt_addr_i1 == rc_addr_i2 || rt_addr_i2 == rc_addr_i1)) begin
            dec_stall = 1;
        end
        else begin
            dec_stall = 0;
        end
    end

endmodule
//end of file.
