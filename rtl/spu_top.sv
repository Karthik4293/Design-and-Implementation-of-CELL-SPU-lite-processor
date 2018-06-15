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

module spu_top
(
    input  logic                     clk,
    input  logic                     rst
);

    Opcodes           dec_opcode_ep;
    Opcodes           dec_opcode_op;
    logic [0:6]       dec_ra_addr_ep;
    logic [0:6]       dec_rb_addr_ep;
    logic [0:6]       dec_rc_addr_ep;
    logic [0:6]       dec_rt_addr_ep;
    logic [0:6]       dec_ra_addr_op;
    logic [0:6]       dec_rb_addr_op;
    logic [0:6]       dec_rc_addr_op;
    logic [0:6]       dec_rt_addr_op;
    logic [0:6]       dec_I7_ep;
    logic [0:7]       dec_I8_ep;
    logic [0:9]       dec_I10_ep;
    logic [0:15]      dec_I16_ep;
    logic [0:17]      dec_I18_ep;
    logic [0:6]       dec_I7_op;
    logic [0:7]       dec_I8_op;
    logic [0:9]       dec_I10_op;
    logic [0:15]      dec_I16_op;
    logic [0:17]      dec_I18_op;
    logic [0:6]       rf_addr_s1_ep;
    logic [0:6]       rf_addr_s2_ep;
    logic [0:6]       rf_addr_s3_ep;
    logic [0:6]       rf_addr_s4_ep;
    logic [0:6]       rf_addr_s5_ep;
    logic [0:6]       rf_addr_s6_ep;
    logic [0:6]       rf_addr_s1_op;
    logic [0:6]       rf_addr_s2_op;
    logic [0:6]       rf_addr_s3_op;
    logic [0:6]       rf_addr_s4_op;
    logic [0:6]       rf_addr_s5_op;
    logic [0:6]       rf_addr_s6_op;
    logic [0:2]       rf_idx_s1_ep;
    logic [0:2]       rf_idx_s2_ep;
    logic [0:2]       rf_idx_s3_ep;
    logic [0:2]       rf_idx_s4_ep;
    logic [0:2]       rf_idx_s5_ep;
    logic [0:2]       rf_idx_s6_ep;
    logic [0:2]       rf_idx_s1_op;
    logic [0:2]       rf_idx_s2_op;
    logic [0:2]       rf_idx_s3_op;
    logic [0:2]       rf_idx_s4_op;
    logic [0:2]       rf_idx_s5_op;
    logic [0:2]       rf_idx_s6_op;
    logic             flush;
    Opcodes           opcode_ep;
    Opcodes           opcode_op;
    logic [0:6]       ra_addr_ep;
    logic [0:6]       rb_addr_ep;
    logic [0:6]       rc_addr_ep;
    logic [0:6]       rt_addr_ep;
    logic [0:6]       ra_addr_op;
    logic [0:6]       rb_addr_op;
    logic [0:6]       rc_addr_op;
    logic [0:6]       rt_addr_op;
    logic [0:6]       I7_ep;
    logic [0:7]       I8_ep;
    logic [0:9]       I10_ep;
    logic [0:15]      I16_ep;
    logic [0:17]      I18_ep;
    logic [0:6]       I7_op;
    logic [0:7]       I8_op;
    logic [0:9]       I10_op;
    logic [0:15]      I16_op;
    logic [0:17]      I18_op;
    logic [0:31]      eins1;
    logic [0:31]      eins2;
    logic [0:127]     ls_data_rd;
    logic [0:127]     ls_data_wr;
    logic [0:31]      ls_addr;
    logic             ls_wr_en;
    logic [0:31]      pc_dtof;
    logic [0:31]      pc_ftod;
    logic [0:1023]    cache_line;
    logic             ins_wr_en;
    logic             cache_wr;
    logic             dec_stall;
    logic             dep_stall;
    logic [0:31]      pc_dec;
    logic [0:31]      pc_dep;

    local_store u_local_store (
        .clk(clk),
        .rst(rst),
        .ls_addr(ls_addr),
        .ls_data_wr(ls_data_wr),
        .ls_data_rd(ls_data_rd),
        .cache_wr(cache_wr),
        .cache_out(cache_line),
        .ls_wr_en(ls_wr_en)
    );

    fetch u_fetch (
        .clk(clk),
        .rst(rst),
        .cache_line(cache_line),
        .cache_wr(cache_wr),
        .dec_stall(dec_stall),
        .dep_stall(dep_stall),
        .branch_taken(flush),
        .pc_in(pc_dtof),
        .pc_out(pc_ftod),
        .eins1(eins1),
        .eins2(eins2)
    );

    decode u_decode (
        .clk(clk),
        .rst(rst),
        .dec_stall(dec_stall),
        .dep_stall(dep_stall),
        .eins1(eins1),
        .eins2(eins2),
        .flush(flush),
        .pc_in(pc_ftod),
        .pc_out(pc_dec),
        .opcode_ep(dec_opcode_ep),
        .opcode_op(dec_opcode_op),
        .ra_addr_ep(dec_ra_addr_ep),
        .rb_addr_ep(dec_rb_addr_ep),
        .rc_addr_ep(dec_rc_addr_ep),
        .rt_addr_ep(dec_rt_addr_ep),
        .ra_addr_op(dec_ra_addr_op),
        .rb_addr_op(dec_rb_addr_op),
        .rc_addr_op(dec_rc_addr_op),
        .rt_addr_op(dec_rt_addr_op),
        .in_I7e(dec_I7_ep),
        .in_I8e(dec_I8_ep),
        .in_I10e(dec_I10_ep),
        .in_I16e(dec_I16_ep),
        .in_I18e(dec_I18_ep),
        .in_I7o(dec_I7_op),
        .in_I8o(dec_I8_op),
        .in_I10o(dec_I10_op),
        .in_I16o(dec_I16_op),
        .in_I18o(dec_I18_op)
    );

    dependency u_dependency ( 
        .clk(clk),
        .rst(rst),
        .pc_in(pc_dec),
        .pc_out(pc_dep),
        .dec_opcode_ep(dec_opcode_ep),
        .dec_opcode_op(dec_opcode_op),
        .dec_ra_addr_ep(dec_ra_addr_ep),
        .dec_rb_addr_ep(dec_rb_addr_ep),
        .dec_rc_addr_ep(dec_rc_addr_ep),
        .dec_rt_addr_ep(dec_rt_addr_ep),
        .dec_ra_addr_op(dec_ra_addr_op),
        .dec_rb_addr_op(dec_rb_addr_op),
        .dec_rc_addr_op(dec_rc_addr_op),
        .dec_rt_addr_op(dec_rt_addr_op),
        .dec_I7_ep(dec_I7_ep),
        .dec_I8_ep(dec_I8_ep),
        .dec_I10_ep(dec_I10_ep),
        .dec_I16_ep(dec_I16_ep),
        .dec_I18_ep(dec_I18_ep),
        .dec_I7_op(dec_I7_op),
        .dec_I8_op(dec_I8_op),
        .dec_I10_op(dec_I10_op),
        .dec_I16_op(dec_I16_op),
        .dec_I18_op(dec_I18_op),
        .rf_addr_s1_ep(rf_addr_s1_ep),
        .rf_addr_s2_ep(rf_addr_s2_ep),
        .rf_addr_s3_ep(rf_addr_s3_ep),
        .rf_addr_s4_ep(rf_addr_s4_ep),
        .rf_addr_s5_ep(rf_addr_s5_ep),
        .rf_addr_s6_ep(rf_addr_s6_ep),
        .rf_addr_s1_op(rf_addr_s1_op),
        .rf_addr_s2_op(rf_addr_s2_op),
        .rf_addr_s3_op(rf_addr_s3_op),
        .rf_addr_s4_op(rf_addr_s4_op),
        .rf_addr_s5_op(rf_addr_s5_op),
        .rf_addr_s6_op(rf_addr_s6_op),
        .rf_idx_s1_ep(rf_idx_s1_ep),
        .rf_idx_s2_ep(rf_idx_s2_ep),
        .rf_idx_s3_ep(rf_idx_s3_ep),
        .rf_idx_s4_ep(rf_idx_s4_ep),
        .rf_idx_s5_ep(rf_idx_s5_ep),
        .rf_idx_s6_ep(rf_idx_s6_ep),
        .rf_idx_s1_op(rf_idx_s1_op),
        .rf_idx_s2_op(rf_idx_s2_op),
        .rf_idx_s3_op(rf_idx_s3_op),
        .rf_idx_s4_op(rf_idx_s4_op),
        .rf_idx_s5_op(rf_idx_s5_op),
        .rf_idx_s6_op(rf_idx_s6_op),
        .flush(flush),
        .opcode_ep(opcode_ep),
        .opcode_op(opcode_op),
        .ra_addr_ep(ra_addr_ep),
        .rb_addr_ep(rb_addr_ep),
        .rc_addr_ep(rc_addr_ep),
        .rt_addr_ep(rt_addr_ep),
        .ra_addr_op(ra_addr_op),
        .rb_addr_op(rb_addr_op),
        .rc_addr_op(rc_addr_op),
        .rt_addr_op(rt_addr_op),
        .I7_ep(I7_ep),
        .I8_ep(I8_ep),
        .I10_ep(I10_ep),
        .I16_ep(I16_ep),
        .I18_ep(I18_ep),
        .I7_op(I7_op),
        .I8_op(I8_op),
        .I10_op(I10_op),
        .I16_op(I16_op),
        .I18_op(I18_op),
        .dep_stall(dep_stall)
    );
                     
    spu_pipes_top u_spu_pipes_top (
        .clk(clk),
        .rst(rst),
        .opcode_ep(opcode_ep),
        .opcode_op(opcode_op),
        .ra_addr_ep(ra_addr_ep),
        .rb_addr_ep(rb_addr_ep),
        .rc_addr_ep(rc_addr_ep),
        .rt_addr_ep(rt_addr_ep),
        .ra_addr_op(ra_addr_op),
        .rb_addr_op(rb_addr_op),
        .rc_addr_op(rc_addr_op),
        .rt_addr_op(rt_addr_op),
        .in_I7e(I7_ep),
        .in_I8e(I8_ep),
        .in_I10e(I10_ep),
        .in_I16e(I16_ep),
        .in_I18e(I18_ep),
        .in_I7o(I7_op),
        .in_I8o(I8_op),
        .in_I10o(I10_op),
        .in_I16o(I16_op),
        .in_I18o(I18_op),
        .rf_addr_s1_ep(rf_addr_s1_ep),
        .rf_addr_s2_ep(rf_addr_s2_ep),
        .rf_addr_s3_ep(rf_addr_s3_ep),
        .rf_addr_s4_ep(rf_addr_s4_ep),
        .rf_addr_s5_ep(rf_addr_s5_ep),
        .rf_addr_s6_ep(rf_addr_s6_ep),
        .rf_addr_s1_op(rf_addr_s1_op),
        .rf_addr_s2_op(rf_addr_s2_op),
        .rf_addr_s3_op(rf_addr_s3_op),
        .rf_addr_s4_op(rf_addr_s4_op),
        .rf_addr_s5_op(rf_addr_s5_op),
        .rf_addr_s6_op(rf_addr_s6_op),
        .rf_idx_s1_ep(rf_idx_s1_ep),
        .rf_idx_s2_ep(rf_idx_s2_ep),
        .rf_idx_s3_ep(rf_idx_s3_ep),
        .rf_idx_s4_ep(rf_idx_s4_ep),
        .rf_idx_s5_ep(rf_idx_s5_ep),
        .rf_idx_s6_ep(rf_idx_s6_ep),
        .rf_idx_s1_op(rf_idx_s1_op),
        .rf_idx_s2_op(rf_idx_s2_op),
        .rf_idx_s3_op(rf_idx_s3_op),
        .rf_idx_s4_op(rf_idx_s4_op),
        .rf_idx_s5_op(rf_idx_s5_op),
        .rf_idx_s6_op(rf_idx_s6_op),
        .flush(flush),
        .ls_data_rd(ls_data_rd),
        .ls_data_wr(ls_data_wr),
        .ls_addr(ls_addr),
        .ls_wr_en(ls_wr_en),
        .cache_wr(cache_wr),
        .PC_in(pc_dep),
        .PC_out(pc_dtof)
    );

endmodule
//end of file.
