// ------------------------------------------//
// Register File for SPU-Lite Processor
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal                           
// NETID: aahangar                             
// SBUID: 111416569                            
//
// NAME: Karthik Raj
// NETID: ?
// SBUID: ?
// ------------------------------------------//

import defines_pkg::*;

module reg_file #(parameter NUM_REGS = 128,
                  parameter RADDR_WD = $clog2(NUM_REGS))
(
    input  logic                  clk,
    input  logic                  rst,
    input  logic [6:0]            ra_addr_ep,
    input  logic [6:0]            rb_addr_ep,
    input  logic [6:0]            rc_addr_ep,
    input  logic [6:0]            rt_addr_ep,
    input  logic [6:0]            ra_addr_op,
    input  logic [6:0]            rb_addr_op,
    input  logic [6:0]            rc_addr_op,
    input  logic [6:0]            rt_addr_op,
    input  logic                  rt_wr_en_ep,
    input  logic                  rt_wr_en_op,
    input  logic [127:0]          rt_wr_ep,
    input  logic [127:0]          rt_wr_op,
    output logic [127:0]          ra_rd_ep,
    output logic [127:0]          rb_rd_ep,
    output logic [127:0]          rc_rd_ep,
    output logic [127:0]          ra_rd_op,
    output logic [127:0]          rb_rd_op,
    output logic [127:0]          rc_rd_op
);

    logic [127:0] reg_array[128];

    /*
    always_ff @(posedge clk)
    begin
        if(rst) begin
            ra_rd_ep <= 'd0;
            rb_rd_ep <= 'd0;
            rc_rd_ep <= 'd0;
            ra_rd_op <= 'd0;
            rb_rd_op <= 'd0;
            rc_rd_op <= 'd0;
        end
        else begin
            ra_rd_ep <= reg_array[ra_addr_ep];
            rb_rd_ep <= reg_array[rb_addr_ep];
            rc_rd_ep <= reg_array[rc_addr_ep];
            ra_rd_op <= reg_array[ra_addr_op];
            rb_rd_op <= reg_array[rb_addr_op];
            rc_rd_op <= reg_array[rc_addr_op];
        end
    end

    always_comb 
    begin
        if(rt_wr_en_ep) begin
            reg_array[rt_addr_ep] = rt_wr_ep;
        end

        if(rt_wr_en_op) begin
            reg_array[rt_addr_op] = rt_wr_op;
        end
    end
    */

    always_comb 
    begin
        ra_rd_ep = reg_array[ra_addr_ep];
        rb_rd_ep = reg_array[rb_addr_ep];
        rc_rd_ep = reg_array[rc_addr_ep];
        ra_rd_op = reg_array[ra_addr_op];
        rb_rd_op = reg_array[rb_addr_op];
        rc_rd_op = reg_array[rc_addr_op];
    end

    always_ff @(posedge clk) 
    begin
        if(rst) begin
            for(int i = 0; i < 128; i++) begin
                reg_array[i] <= 'd0;
            end
        end
        else begin
            if(rt_wr_en_ep) begin
                reg_array[rt_addr_ep] <= rt_wr_ep;
            end

            if(rt_wr_en_op) begin
                reg_array[rt_addr_op] <= rt_wr_op;
            end
        end
    end

endmodule
//end of file.
