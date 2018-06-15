// ------------------------------------------//
// Shift Rotate unit File for SPU-Lite Processor
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

module fw_macro #(parameter OPCODE_LEN  = 11,
                  parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  logic [6:0]               ra_addr_ep,
    input  logic [6:0]               rb_addr_ep,
    input  logic [6:0]               rc_addr_ep,
    input  logic [6:0]               rt_addr_ep,
    input  logic [6:0]               ra_addr_op,
    input  logic [6:0]               rb_addr_op,
    input  logic [6:0]               rc_addr_op,
    input  logic [6:0]               rt_addr_op,
    input  logic [127:0]             ra_data_ep,
    input  logic [127:0]             rb_data_ep,
    input  logic [127:0]             rc_data_ep,
    input  logic [127:0]             ra_data_op,
    input  logic [127:0]             rb_data_op,
    input  logic [127:0]             rc_data_op,
    input  logic [6:0]               rf_addr_s2_ep,
    input  logic [6:0]               rf_addr_s3_ep,
    input  logic [6:0]               rf_addr_s4_ep,
    input  logic [6:0]               rf_addr_s5_ep,
    input  logic [6:0]               rf_addr_s6_ep,
    input  logic [6:0]               rf_addr_s7_ep,
    input  logic [6:0]               rf_addr_ep,
    input  logic [6:0]               rf_addr_s2_op,
    input  logic [6:0]               rf_addr_s3_op,
    input  logic [6:0]               rf_addr_s4_op,
    input  logic [6:0]               rf_addr_s5_op,
    input  logic [6:0]               rf_addr_s6_op,
    input  logic [6:0]               rf_addr_s7_op,
    input  logic [6:0]               rf_addr_op,
    input  logic [127:0]             rf_data_s2_ep,
    input  logic [127:0]             rf_data_s3_ep,
    input  logic [127:0]             rf_data_s4_ep,
    input  logic [127:0]             rf_data_s5_ep,
    input  logic [127:0]             rf_data_s6_ep,
    input  logic [127:0]             rf_data_s7_ep,
    input  logic [127:0]             rf_data_ep,
    input  logic [127:0]             rf_data_s2_op,
    input  logic [127:0]             rf_data_s3_op,
    input  logic [127:0]             rf_data_s4_op,
    input  logic [127:0]             rf_data_s5_op,
    input  logic [127:0]             rf_data_s6_op,
    input  logic [127:0]             rf_data_s7_op,
    input  logic [127:0]             rf_data_op,
    input  logic [0:2]               rf_idx_s2_ep,
    input  logic [0:2]               rf_idx_s3_ep,
    input  logic [0:2]               rf_idx_s4_ep,
    input  logic [0:2]               rf_idx_s5_ep,
    input  logic [0:2]               rf_idx_s6_ep,
    input  logic [0:2]               rf_idx_s7_ep,
    input  logic [0:2]               rf_idx_s2_op,
    input  logic [0:2]               rf_idx_s3_op,
    input  logic [0:2]               rf_idx_s4_op,
    input  logic [0:2]               rf_idx_s5_op,
    input  logic [0:2]               rf_idx_s6_op,
    input  logic [0:2]               rf_idx_s7_op,
    output logic [127:0]             ra_fw_ep,
    output logic [127:0]             rb_fw_ep,
    output logic [127:0]             rc_fw_ep,
    output logic [127:0]             ra_fw_op,
    output logic [127:0]             rb_fw_op,
    output logic [127:0]             rc_fw_op
);

    assign ra_fw_ep = (rf_addr_s2_ep === ra_addr_ep && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === ra_addr_ep && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === ra_addr_ep && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === ra_addr_ep && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === ra_addr_ep && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === ra_addr_ep && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === ra_addr_ep && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === ra_addr_ep && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === ra_addr_ep && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === ra_addr_ep && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === ra_addr_ep) ? rf_data_ep :
                      (rf_addr_op    === ra_addr_ep) ? rf_data_op : ra_data_ep;

    assign rb_fw_ep = (rf_addr_s2_ep === rb_addr_ep && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === rb_addr_ep && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === rb_addr_ep && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === rb_addr_ep && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === rb_addr_ep && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === rb_addr_ep && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === rb_addr_ep && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === rb_addr_ep && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === rb_addr_ep && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === rb_addr_ep && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === rb_addr_ep) ? rf_data_ep :
                      (rf_addr_op    === rb_addr_ep) ? rf_data_op : rb_data_ep;

    assign rc_fw_ep = (rf_addr_s2_ep === rc_addr_ep && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === rc_addr_ep && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === rc_addr_ep && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === rc_addr_ep && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === rc_addr_ep && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === rc_addr_ep && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === rc_addr_ep && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === rc_addr_ep && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === rc_addr_ep && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === rc_addr_ep && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === rc_addr_ep) ? rf_data_ep :
                      (rf_addr_op    === rc_addr_ep) ? rf_data_op : rc_data_ep;

    assign ra_fw_op = (rf_addr_s2_ep === ra_addr_op && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === ra_addr_op && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === ra_addr_op && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === ra_addr_op && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === ra_addr_op && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === ra_addr_op && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === ra_addr_op && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === ra_addr_op && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === ra_addr_op && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === ra_addr_op && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === ra_addr_op) ? rf_data_ep :
                      (rf_addr_op    === ra_addr_op) ? rf_data_op : ra_data_op;

    assign rb_fw_op = (rf_addr_s2_ep === rb_addr_op && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === rb_addr_op && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === rb_addr_op && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === rb_addr_op && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === rb_addr_op && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === rb_addr_op && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === rb_addr_op && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === rb_addr_op && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === rb_addr_op && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === rb_addr_op && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === rb_addr_op) ? rf_data_ep :
                      (rf_addr_op    === rb_addr_op) ? rf_data_op : rb_data_op;

    assign rc_fw_op = (rf_addr_s2_ep === rc_addr_op && (rf_idx_s2_ep == 3'd1)) ? rf_data_s2_ep :
                      (rf_addr_s3_ep === rc_addr_op && (rf_idx_s3_ep == 3'd1 || rf_idx_s3_ep == 3'd2 || rf_idx_s3_ep == 3'd4)) ? rf_data_s3_ep :
                      (rf_addr_s4_ep === rc_addr_op && (rf_idx_s4_ep == 3'd1 || rf_idx_s4_ep == 3'd2 || rf_idx_s4_ep == 3'd4)) ? rf_data_s4_ep :
                      (rf_addr_s5_ep === rc_addr_op && (rf_idx_s5_ep == 3'd1 || rf_idx_s5_ep == 3'd2 || rf_idx_s5_ep == 3'd4)) ? rf_data_s5_ep :
                      (rf_addr_s6_ep === rc_addr_op && (rf_idx_s6_ep == 3'd1 || rf_idx_s6_ep == 3'd2 || rf_idx_s6_ep == 3'd4 || rf_idx_s6_ep == 3'd3)) ? rf_data_s6_ep :
                      (rf_addr_s7_ep === rc_addr_op && (rf_idx_s7_ep == 3'd1 || rf_idx_s7_ep == 3'd2 || rf_idx_s7_ep == 3'd4 || rf_idx_s7_ep == 3'd3 || rf_addr_s7_ep == 3'd7)) ? rf_data_s7_ep :
                      (rf_addr_s4_op === rc_addr_op && (rf_idx_s4_op == 3'd5)) ? rf_data_s4_op :
                      (rf_addr_s5_op === rc_addr_op && (rf_idx_s5_op == 3'd5)) ? rf_data_s5_op :
                      (rf_addr_s6_op === rc_addr_op && (rf_idx_s6_op == 3'd5 || rf_idx_s6_op == 3'd6)) ? rf_data_s6_op :
                      (rf_addr_s7_op === rc_addr_op && (rf_idx_s7_op == 3'd5 || rf_idx_s7_op == 3'd6)) ? rf_data_s7_op : 
                      (rf_addr_ep    === rc_addr_op) ? rf_data_ep :
                      (rf_addr_op    === rc_addr_op) ? rf_data_op : rc_data_op;

endmodule
//end of file.

