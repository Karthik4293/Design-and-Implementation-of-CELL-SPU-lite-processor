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

module spu_pipes_top #(parameter OPCODE_LEN  = 11,
                       parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode_ep,
    input  Opcodes                   opcode_op,
    input  logic [0:6]               ra_addr_ep,
    input  logic [0:6]               rb_addr_ep,
    input  logic [0:6]               rc_addr_ep,
    input  logic [0:6]               rt_addr_ep,
    input  logic [0:6]               ra_addr_op,
    input  logic [0:6]               rb_addr_op,
    input  logic [0:6]               rc_addr_op,
    input  logic [0:6]               rt_addr_op,
    input  logic [0:6]               in_I7e,
    input  logic [0:7]               in_I8e,
    input  logic [0:9]               in_I10e,
    input  logic [0:15]              in_I16e,
    input  logic [0:17]              in_I18e,
    input  logic [0:6]               in_I7o,
    input  logic [0:7]               in_I8o,
    input  logic [0:9]               in_I10o,
    input  logic [0:15]              in_I16o,
    input  logic [0:17]              in_I18o,
    output logic [0:6]               rf_addr_s1_ep,
    output logic [0:6]               rf_addr_s2_ep,
    output logic [0:6]               rf_addr_s3_ep,
    output logic [0:6]               rf_addr_s4_ep,
    output logic [0:6]               rf_addr_s5_ep,
    output logic [0:6]               rf_addr_s6_ep,
    output logic [0:6]               rf_addr_s1_op,
    output logic [0:6]               rf_addr_s2_op,
    output logic [0:6]               rf_addr_s3_op,
    output logic [0:6]               rf_addr_s4_op,
    output logic [0:6]               rf_addr_s5_op,
    output logic [0:6]               rf_addr_s6_op,
    output logic [0:2]               rf_idx_s1_ep,
    output logic [0:2]               rf_idx_s2_ep,
    output logic [0:2]               rf_idx_s3_ep,
    output logic [0:2]               rf_idx_s4_ep,
    output logic [0:2]               rf_idx_s5_ep,
    output logic [0:2]               rf_idx_s6_ep,
    output logic [0:2]               rf_idx_s1_op,
    output logic [0:2]               rf_idx_s2_op,
    output logic [0:2]               rf_idx_s3_op,
    output logic [0:2]               rf_idx_s4_op,
    output logic [0:2]               rf_idx_s5_op,
    output logic [0:2]               rf_idx_s6_op,
    output logic                     flush,
    input  logic [0:31]              PC_in,
    input  logic [0:127]             ls_data_rd,
    output logic [0:127]             ls_data_wr,
    output logic [0:31]              ls_addr,
    output logic                     ls_wr_en,
    output logic                     cache_wr,
    output logic [0:31]              PC_out
);

    logic                  rt_wr_en_ep;
    logic                  rt_wr_en_op;
    logic [0:127]          rt_wr_ep;
    logic [0:127]          rt_wr_op;
    logic [0:127]          ra_rd_ep;
    logic [0:127]          rb_rd_ep;
    logic [0:127]          rc_rd_ep;
    logic [0:127]          ra_rd_op;
    logic [0:127]          rb_rd_op;
    logic [0:127]          rc_rd_op;
    logic [0:6]            rf_addr_s7_ep;
    logic [0:6]            rf_addr_s7_op;
    logic [0:127]          rf_data_s2_ep;
    logic [0:127]          rf_data_s3_ep;
    logic [0:127]          rf_data_s4_ep;
    logic [0:127]          rf_data_s5_ep;
    logic [0:127]          rf_data_s6_ep;
    logic [0:127]          rf_data_s7_ep;
    logic [0:127]          rf_data_s2_op;
    logic [0:127]          rf_data_s3_op;
    logic [0:127]          rf_data_s4_op;
    logic [0:127]          rf_data_s5_op;
    logic [0:127]          rf_data_s6_op;
    logic [0:127]          rf_data_s7_op;
    logic [0:127]          ra_fw_ep;
    logic [0:127]          rb_fw_ep;
    logic [0:127]          rc_fw_ep;
    logic [0:127]          ra_fw_op;
    logic [0:127]          rb_fw_op;
    logic [0:127]          rc_fw_op;
    logic [0:6]            rt_fw_addr_ep;
    logic [0:6]            rt_fw_addr_op;
    logic [0:2]            rf_idx_s7_ep;
    logic [0:2]            rf_idx_s7_op;

    reg_file u_reg_file (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .ra_addr_ep   ( ra_addr_ep  ),
        .rb_addr_ep   ( rb_addr_ep  ),
        .rc_addr_ep   ( rc_addr_ep  ),
        .rt_addr_ep   ( rt_fw_addr_ep  ),
        .ra_addr_op   ( ra_addr_op  ),
        .rb_addr_op   ( rb_addr_op  ),
        .rc_addr_op   ( rc_addr_op  ),
        .rt_addr_op   ( rt_fw_addr_op  ),
        .rt_wr_en_ep  ( rt_wr_en_ep ),
        .rt_wr_en_op  ( rt_wr_en_op ),
        .rt_wr_ep     ( rt_wr_ep    ),
        .rt_wr_op     ( rt_wr_op    ),
        .ra_rd_ep     ( ra_rd_ep    ),
        .rb_rd_ep     ( rb_rd_ep    ),
        .rc_rd_ep     ( rc_rd_ep    ),
        .ra_rd_op     ( ra_rd_op    ),
        .rb_rd_op     ( rb_rd_op    ),
        .rc_rd_op     ( rc_rd_op    )
   );

    fw_macro u_fw_macro (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .ra_addr_ep   ( ra_addr_ep  ),
        .rb_addr_ep   ( rb_addr_ep  ),
        .rc_addr_ep   ( rc_addr_ep  ),
        .rt_addr_ep   ( rt_addr_ep  ),
        .ra_addr_op   ( ra_addr_op  ),
        .rb_addr_op   ( rb_addr_op  ),
        .rc_addr_op   ( rc_addr_op  ),
        .rt_addr_op   ( rt_addr_op  ),
        .ra_data_ep   ( ra_rd_ep    ),
        .rb_data_ep   ( rb_rd_ep    ),
        .rc_data_ep   ( rc_rd_ep    ),
        .ra_data_op   ( ra_rd_op    ),
        .rb_data_op   ( rb_rd_op    ),
        .rc_data_op   ( rc_rd_op    ),
        .rf_addr_s2_ep( rf_addr_s2_ep ),
        .rf_addr_s3_ep( rf_addr_s3_ep ),
        .rf_addr_s4_ep( rf_addr_s4_ep ),
        .rf_addr_s5_ep( rf_addr_s5_ep ),
        .rf_addr_s6_ep( rf_addr_s6_ep ),
        .rf_addr_s7_ep( rf_addr_s7_ep ),
        .rf_addr_ep   ( rt_fw_addr_ep ),
        .rf_addr_s2_op( rf_addr_s2_op ),
        .rf_addr_s3_op( rf_addr_s3_op ),
        .rf_addr_s4_op( rf_addr_s4_op ),
        .rf_addr_s5_op( rf_addr_s5_op ),
        .rf_addr_s6_op( rf_addr_s6_op ),
        .rf_addr_s7_op( rf_addr_s7_op ),
        .rf_addr_op   ( rt_fw_addr_op ),
        .rf_data_s2_ep( rf_data_s2_ep ),
        .rf_data_s3_ep( rf_data_s3_ep ),
        .rf_data_s4_ep( rf_data_s4_ep ),
        .rf_data_s5_ep( rf_data_s5_ep ),
        .rf_data_s6_ep( rf_data_s6_ep ),
        .rf_data_s7_ep( rf_data_s7_ep ),
        .rf_data_ep   ( rt_wr_ep ),
        .rf_data_s2_op( rf_data_s2_op ),
        .rf_data_s3_op( rf_data_s3_op ),
        .rf_data_s4_op( rf_data_s4_op ),
        .rf_data_s5_op( rf_data_s5_op ),
        .rf_data_s6_op( rf_data_s6_op ),
        .rf_data_s7_op( rf_data_s7_op ),
        .rf_data_op   ( rt_wr_op ),
        .rf_idx_s2_op ( rf_idx_s2_op  ),
        .rf_idx_s3_op ( rf_idx_s3_op  ),
        .rf_idx_s4_op ( rf_idx_s4_op  ),
        .rf_idx_s5_op ( rf_idx_s5_op  ),
        .rf_idx_s6_op ( rf_idx_s6_op  ),
        .rf_idx_s7_op ( rf_idx_s7_op  ),
        .rf_idx_s2_ep ( rf_idx_s2_ep  ),
        .rf_idx_s3_ep ( rf_idx_s3_ep  ),
        .rf_idx_s4_ep ( rf_idx_s4_ep  ),
        .rf_idx_s5_ep ( rf_idx_s5_ep  ),
        .rf_idx_s6_ep ( rf_idx_s6_ep  ),
        .rf_idx_s7_ep ( rf_idx_s7_ep  ),
        .ra_fw_ep     ( ra_fw_ep      ),
        .rb_fw_ep     ( rb_fw_ep      ),
        .rc_fw_ep     ( rc_fw_ep      ),
        .ra_fw_op     ( ra_fw_op      ),
        .rb_fw_op     ( rb_fw_op      ),
        .rc_fw_op     ( rc_fw_op      )
    );

    even_pipe u_even_pipe (
        .clk           (clk),
        .rst           (rst),
        .opcode        (opcode_ep),
        .rt_wr_en_ep   (rt_wr_en_ep),
        .in_RA         (ra_fw_ep),
        .in_RB         (rb_fw_ep),
        .in_RC         (rc_fw_ep),
        .in_I7         (in_I7e),
        .in_I8         (in_I8e),
        .in_I10        (in_I10e),
        .in_I16        (in_I16e),
        .in_I18        (in_I18e),
        .in_RT_addr    (rt_addr_ep),
        .flush         ( flush  ),
        .rf_addr_s1_ep ( rf_addr_s1_ep ),
        .rf_addr_s2_ep ( rf_addr_s2_ep ),
        .rf_addr_s3_ep ( rf_addr_s3_ep ),
        .rf_addr_s4_ep ( rf_addr_s4_ep ),
        .rf_addr_s5_ep ( rf_addr_s5_ep ),
        .rf_addr_s6_ep ( rf_addr_s6_ep ),
        .rf_addr_s7_ep ( rf_addr_s7_ep ),
        .rf_data_s2_ep ( rf_data_s2_ep ),
        .rf_data_s3_ep ( rf_data_s3_ep ),
        .rf_data_s4_ep ( rf_data_s4_ep ),
        .rf_data_s5_ep ( rf_data_s5_ep ),
        .rf_data_s6_ep ( rf_data_s6_ep ),
        .rf_data_s7_ep ( rf_data_s7_ep ),
        .rf_idx_s1_ep  ( rf_idx_s1_ep  ),
        .rf_idx_s2_ep  ( rf_idx_s2_ep  ),
        .rf_idx_s3_ep  ( rf_idx_s3_ep  ),
        .rf_idx_s4_ep  ( rf_idx_s4_ep  ),
        .rf_idx_s5_ep  ( rf_idx_s5_ep  ),
        .rf_idx_s6_ep  ( rf_idx_s6_ep  ),
        .rf_idx_s7_ep  ( rf_idx_s7_ep  ),
        .out_RT_addr    (rt_fw_addr_ep),
        .out_RT        (rt_wr_ep)
    );

    odd_pipe u_odd_pipe (
        .clk           (clk),
        .rst           (rst),
        .opcode        (opcode_op),
        .rt_wr_en_op   (rt_wr_en_op),
        .in_RA         (ra_fw_op),
        .in_RB         (rb_fw_op),
        .in_RC         (rc_fw_op),
        .in_I7         (in_I7o),
        .in_I8         (in_I8o),
        .in_I10        (in_I10o),
        .in_I16        (in_I16o),
        .in_I18        (in_I18o),
        .flush         ( flush  ),
        .in_RT_addr    (rt_addr_op),
        .rf_addr_s1_op ( rf_addr_s1_op ),
        .rf_addr_s2_op ( rf_addr_s2_op ),
        .rf_addr_s3_op ( rf_addr_s3_op ),
        .rf_addr_s4_op ( rf_addr_s4_op ),
        .rf_addr_s5_op ( rf_addr_s5_op ),
        .rf_addr_s6_op ( rf_addr_s6_op ),
        .rf_addr_s7_op ( rf_addr_s7_op ),
        .rf_data_s2_op ( rf_data_s2_op ),
        .rf_data_s3_op ( rf_data_s3_op ),
        .rf_data_s4_op ( rf_data_s4_op ),
        .rf_data_s5_op ( rf_data_s5_op ),
        .rf_data_s6_op ( rf_data_s6_op ),
        .rf_data_s7_op ( rf_data_s7_op ),
        .rf_idx_s1_op  ( rf_idx_s1_op  ),
        .rf_idx_s2_op  ( rf_idx_s2_op  ),
        .rf_idx_s3_op  ( rf_idx_s3_op  ),
        .rf_idx_s4_op  ( rf_idx_s4_op  ),
        .rf_idx_s5_op  ( rf_idx_s5_op  ),
        .rf_idx_s6_op  ( rf_idx_s6_op  ),
        .rf_idx_s7_op  ( rf_idx_s7_op  ),
        .in_ls_data    ( ls_data_rd    ),
        .out_ls_addr   ( ls_addr       ),
        .out_ls_data   ( ls_data_wr    ),
        .out_ls_wr_en  ( ls_wr_en      ),
        .PC_in         ( PC_in         ),
        .PC_out        ( PC_out        ),
        .cache_wr      ( cache_wr      ),
        .out_RT_addr   ( rt_fw_addr_op ),
        .out_RT        ( rt_wr_op      )
    );

endmodule
//end of file.

