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

module dependency 
(
    input  logic             clk,
    input  logic             rst,
    input  Opcodes           dec_opcode_ep,
    input  Opcodes           dec_opcode_op,
    input  logic [0:6]       dec_ra_addr_ep,
    input  logic [0:6]       dec_rb_addr_ep,
    input  logic [0:6]       dec_rc_addr_ep,
    input  logic [0:6]       dec_rt_addr_ep,
    input  logic [0:6]       dec_ra_addr_op,
    input  logic [0:6]       dec_rb_addr_op,
    input  logic [0:6]       dec_rc_addr_op,
    input  logic [0:6]       dec_rt_addr_op,
    input  logic [0:6]       dec_I7_ep,
    input  logic [0:7]       dec_I8_ep,
    input  logic [0:9]       dec_I10_ep,
    input  logic [0:15]      dec_I16_ep,
    input  logic [0:17]      dec_I18_ep,
    input  logic [0:6]       dec_I7_op,
    input  logic [0:7]       dec_I8_op,
    input  logic [0:9]       dec_I10_op,
    input  logic [0:15]      dec_I16_op,
    input  logic [0:17]      dec_I18_op,
    input  logic [0:6]       rf_addr_s1_ep,
    input  logic [0:6]       rf_addr_s2_ep,
    input  logic [0:6]       rf_addr_s3_ep,
    input  logic [0:6]       rf_addr_s4_ep,
    input  logic [0:6]       rf_addr_s5_ep,
    input  logic [0:6]       rf_addr_s6_ep,
    input  logic [0:6]       rf_addr_s1_op,
    input  logic [0:6]       rf_addr_s2_op,
    input  logic [0:6]       rf_addr_s3_op,
    input  logic [0:6]       rf_addr_s4_op,
    input  logic [0:6]       rf_addr_s5_op,
    input  logic [0:6]       rf_addr_s6_op,
    input  logic [0:2]       rf_idx_s1_ep,
    input  logic [0:2]       rf_idx_s2_ep,
    input  logic [0:2]       rf_idx_s3_ep,
    input  logic [0:2]       rf_idx_s4_ep,
    input  logic [0:2]       rf_idx_s5_ep,
    input  logic [0:2]       rf_idx_s6_ep,
    input  logic [0:2]       rf_idx_s1_op,
    input  logic [0:2]       rf_idx_s2_op,
    input  logic [0:2]       rf_idx_s3_op,
    input  logic [0:2]       rf_idx_s4_op,
    input  logic [0:2]       rf_idx_s5_op,
    input  logic [0:2]       rf_idx_s6_op,
    input  logic             flush,
    input  logic [0:31]      pc_in,
    output logic [0:31]      pc_out,
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
    output logic [0:6]       I7_ep,
    output logic [0:7]       I8_ep,
    output logic [0:9]       I10_ep,
    output logic [0:15]      I16_ep,
    output logic [0:17]      I18_ep,
    output logic [0:6]       I7_op,
    output logic [0:7]       I8_op,
    output logic [0:9]       I10_op,
    output logic [0:15]      I16_op,
    output logic [0:17]      I18_op,
    output logic             dep_stall
);

    logic is_lat1;
    logic is_lat2;
    logic is_lat3;
    logic is_lat4;
    logic is_lat5;
    logic is_lat6;

    assign is_lat1 = rf_idx_s1_ep == 3'd1 || rf_idx_s1_ep == 3'd2 || rf_idx_s1_ep == 3'd3 || 
                     rf_idx_s1_ep == 3'd4 || rf_idx_s1_op == 3'd5 || rf_idx_s1_op == 3'd6 || 
                     rf_idx_s1_ep == 3'd7;

    assign is_lat2 = rf_idx_s2_ep == 3'd2 || rf_idx_s2_ep == 3'd3 || rf_idx_s2_ep == 3'd4 ||
                     rf_idx_s2_op == 3'd5 || rf_idx_s2_op == 3'd6 || rf_idx_s2_ep == 3'd7;

    assign is_lat3 = rf_idx_s3_ep == 3'd3 || rf_idx_s3_op == 3'd5 || rf_idx_s3_op == 3'd6 || 
                     rf_idx_s3_ep == 3'd7;

    assign is_lat4 = rf_idx_s4_ep == 3'd3 || rf_idx_s4_op == 3'd6 || rf_idx_s4_ep == 3'd7;

    assign is_lat5 = rf_idx_s5_ep == 3'd3 || rf_idx_s5_op == 3'd6 || rf_idx_s5_ep == 3'd7;

    assign is_lat6 = rf_idx_s6_ep == 3'd7; 

    always_ff @(posedge clk) begin
        if(rst) begin
            opcode_ep  <= LNOP;
            ra_addr_ep <= 'dx;
            rb_addr_ep <= 'dx;
            rc_addr_ep <= 'dx;
            rt_addr_ep <= 'dx;
            I7_ep      <= 'dx;
            I8_ep      <= 'dx;
            I10_ep     <= 'dx;
            I16_ep     <= 'dx;
            I18_ep     <= 'dx;
            opcode_op  <= NOP;
            ra_addr_op <= 'dx;
            rb_addr_op <= 'dx;
            rc_addr_op <= 'dx;
            rt_addr_op <= 'dx;
            I7_op      <= 'dx;
            I8_op      <= 'dx;
            I10_op     <= 'dx;
            I16_op     <= 'dx;
            I18_op     <= 'dx;
            pc_out     <= 'dx;
        end
        else begin
            if(flush || dep_stall) begin
                opcode_ep  <= LNOP;
                ra_addr_ep <= 'dx;
                rb_addr_ep <= 'dx;
                rc_addr_ep <= 'dx;
                rt_addr_ep <= 'dx;
                I7_ep      <= 'dx;
                I8_ep      <= 'dx;
                I10_ep     <= 'dx;
                I16_ep     <= 'dx;
                I18_ep     <= 'dx;
                opcode_op  <= NOP;
                ra_addr_op <= 'dx;
                rb_addr_op <= 'dx;
                rc_addr_op <= 'dx;
                rt_addr_op <= 'dx;
                I7_op      <= 'dx;
                I8_op      <= 'dx;
                I10_op     <= 'dx;
                I16_op     <= 'dx;
                I18_op     <= 'dx;
            end
            else begin
                opcode_ep  <= dec_opcode_ep;
                ra_addr_ep <= dec_ra_addr_ep;
                rb_addr_ep <= dec_rb_addr_ep;
                rc_addr_ep <= dec_rc_addr_ep;
                rt_addr_ep <= dec_rt_addr_ep;
                I7_ep      <= dec_I7_ep;
                I8_ep      <= dec_I8_ep;
                I10_ep     <= dec_I10_ep;
                I16_ep     <= dec_I16_ep;
                I18_ep     <= dec_I18_ep;
                opcode_op  <= dec_opcode_op;
                ra_addr_op <= dec_ra_addr_op;
                rb_addr_op <= dec_rb_addr_op;
                rc_addr_op <= dec_rc_addr_op;
                rt_addr_op <= dec_rt_addr_op;
                I7_op      <= dec_I7_op;
                I8_op      <= dec_I8_op;
                I10_op     <= dec_I10_op;
                I16_op     <= dec_I16_op;
                I18_op     <= dec_I18_op;
            end
            pc_out     <= pc_in;
        end
    end

    always_comb begin
        dep_stall = 1'b0;

        if(
           (rt_addr_ep == dec_ra_addr_ep || rt_addr_ep == dec_ra_addr_op) ||
           (rt_addr_ep == dec_rb_addr_ep || rt_addr_ep == dec_rb_addr_op) ||
           (rt_addr_ep == dec_rc_addr_ep || rt_addr_ep == dec_rc_addr_op) ||
           (rt_addr_op == dec_ra_addr_ep || rt_addr_op == dec_ra_addr_op) ||
           (rt_addr_op == dec_rb_addr_ep || rt_addr_op == dec_rb_addr_op) ||
           (rt_addr_op == dec_rc_addr_ep || rt_addr_op == dec_rc_addr_op) ||
           ((rf_addr_s1_ep == dec_ra_addr_ep || rf_addr_s1_ep == dec_ra_addr_op) && is_lat1) ||
           ((rf_addr_s2_ep == dec_ra_addr_ep || rf_addr_s2_ep == dec_ra_addr_op) && is_lat2) ||
           ((rf_addr_s3_ep == dec_ra_addr_ep || rf_addr_s3_ep == dec_ra_addr_op) && is_lat3) ||
           ((rf_addr_s4_ep == dec_ra_addr_ep || rf_addr_s4_ep == dec_ra_addr_op) && is_lat4) ||
           ((rf_addr_s5_ep == dec_ra_addr_ep || rf_addr_s5_ep == dec_ra_addr_op) && is_lat5) ||
           ((rf_addr_s6_ep == dec_ra_addr_ep || rf_addr_s6_ep == dec_ra_addr_op) && is_lat6) ||
           ((rf_addr_s1_ep == dec_rb_addr_ep || rf_addr_s1_ep == dec_rb_addr_op) && is_lat1) ||
           ((rf_addr_s2_ep == dec_rb_addr_ep || rf_addr_s2_ep == dec_rb_addr_op) && is_lat2) ||
           ((rf_addr_s3_ep == dec_rb_addr_ep || rf_addr_s3_ep == dec_rb_addr_op) && is_lat3) ||
           ((rf_addr_s4_ep == dec_rb_addr_ep || rf_addr_s4_ep == dec_rb_addr_op) && is_lat4) ||
           ((rf_addr_s5_ep == dec_rb_addr_ep || rf_addr_s5_ep == dec_rb_addr_op) && is_lat5) ||
           ((rf_addr_s6_ep == dec_rb_addr_ep || rf_addr_s6_ep == dec_rb_addr_op) && is_lat6) ||
           ((rf_addr_s1_ep == dec_rc_addr_ep || rf_addr_s1_ep == dec_rc_addr_op) && is_lat1) ||
           ((rf_addr_s2_ep == dec_rc_addr_ep || rf_addr_s2_ep == dec_rc_addr_op) && is_lat2) ||
           ((rf_addr_s3_ep == dec_rc_addr_ep || rf_addr_s3_ep == dec_rc_addr_op) && is_lat3) ||
           ((rf_addr_s4_ep == dec_rc_addr_ep || rf_addr_s4_ep == dec_rc_addr_op) && is_lat4) ||
           ((rf_addr_s5_ep == dec_rc_addr_ep || rf_addr_s5_ep == dec_rc_addr_op) && is_lat5) ||
           ((rf_addr_s6_ep == dec_rc_addr_ep || rf_addr_s6_ep == dec_rc_addr_op) && is_lat6) ||
           ((rf_addr_s1_op == dec_ra_addr_op || rf_addr_s1_op == dec_ra_addr_ep) && is_lat1) ||
           ((rf_addr_s2_op == dec_ra_addr_op || rf_addr_s2_op == dec_ra_addr_ep) && is_lat2) ||
           ((rf_addr_s3_op == dec_ra_addr_op || rf_addr_s3_op == dec_ra_addr_ep) && is_lat3) ||
           ((rf_addr_s4_op == dec_ra_addr_op || rf_addr_s4_op == dec_ra_addr_ep) && is_lat4) ||
           ((rf_addr_s5_op == dec_ra_addr_op || rf_addr_s5_op == dec_ra_addr_ep) && is_lat5) ||
           ((rf_addr_s6_op == dec_ra_addr_op || rf_addr_s6_op == dec_ra_addr_ep) && is_lat6) ||
           ((rf_addr_s1_op == dec_rb_addr_op || rf_addr_s1_op == dec_rb_addr_ep) && is_lat1) ||
           ((rf_addr_s2_op == dec_rb_addr_op || rf_addr_s2_op == dec_rb_addr_ep) && is_lat2) ||
           ((rf_addr_s3_op == dec_rb_addr_op || rf_addr_s3_op == dec_rb_addr_ep) && is_lat3) ||
           ((rf_addr_s4_op == dec_rb_addr_op || rf_addr_s4_op == dec_rb_addr_ep) && is_lat4) ||
           ((rf_addr_s5_op == dec_rb_addr_op || rf_addr_s5_op == dec_rb_addr_ep) && is_lat5) ||
           ((rf_addr_s6_op == dec_rb_addr_op || rf_addr_s6_op == dec_rb_addr_ep) && is_lat6) ||
           ((rf_addr_s1_op == dec_rc_addr_ep || rf_addr_s1_op == dec_rc_addr_op) && is_lat1) ||
           ((rf_addr_s2_op == dec_rc_addr_ep || rf_addr_s2_op == dec_rc_addr_op) && is_lat2) ||
           ((rf_addr_s3_op == dec_rc_addr_ep || rf_addr_s3_op == dec_rc_addr_op) && is_lat3) ||
           ((rf_addr_s4_op == dec_rc_addr_ep || rf_addr_s4_op == dec_rc_addr_op) && is_lat4) ||
           ((rf_addr_s5_op == dec_rc_addr_ep || rf_addr_s5_op == dec_rc_addr_op) && is_lat5) ||
           ((rf_addr_s6_op == dec_rc_addr_ep || rf_addr_s6_op == dec_rc_addr_op) && is_lat6)
          ) 
        begin
            dep_stall = 1'b1;
        end
    end

endmodule
//end of file.

