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

module odd_pipe #(parameter OPCODE_LEN  = 11,
                  parameter REG_ADDR_WD = 7,
                  parameter REG_DATA_WD = 128)
(

    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode,
    output logic                     rt_wr_en_op,
    input  logic [0:127]             in_RA,
    input  logic [0:127]             in_RB,
    input  logic [0:127]             in_RC,
    input  logic [0:6]               in_I7,
    input  logic [0:7]               in_I8,
    input  logic [0:9]               in_I10,
    input  logic [0:15]              in_I16,
    input  logic [0:17]              in_I18,
    input  logic [0:6]               in_RT_addr,
    output logic [0:6]               rf_addr_s1_op,
    output logic [0:6]               rf_addr_s2_op,
    output logic [0:6]               rf_addr_s3_op,
    output logic [0:6]               rf_addr_s4_op,
    output logic [0:6]               rf_addr_s5_op,
    output logic [0:6]               rf_addr_s6_op,
    output logic [0:6]               rf_addr_s7_op,
    output logic [0:2]               rf_idx_s1_op,
    output logic [0:2]               rf_idx_s2_op,
    output logic [0:2]               rf_idx_s3_op,
    output logic [0:2]               rf_idx_s4_op,
    output logic [0:2]               rf_idx_s5_op,
    output logic [0:2]               rf_idx_s6_op,
    output logic [0:2]               rf_idx_s7_op,
    output logic [0:127]             rf_data_s2_op,
    output logic [0:127]             rf_data_s3_op,
    output logic [0:127]             rf_data_s4_op,
    output logic [0:127]             rf_data_s5_op,
    output logic [0:127]             rf_data_s6_op,
    output logic [0:127]             rf_data_s7_op,
    output logic [0:6]               out_RT_addr,
    output logic [0:127]             out_RT,
    input  logic [0:127]             in_ls_data,
    input  logic [0:31]              PC_in,
    output logic [0:31]              PC_out,
    output logic                     cache_wr,
    output logic                     out_ls_wr_en,
    output logic [0:31]              out_ls_addr,
    output logic [0:127]             out_ls_data,
    output logic                     flush
);

    localparam MASK1 = 128'hFFFFFFF0;
    localparam MASK2 = 128'hFFFFFFFC;

    logic            rt_wr_en;
    logic [0:127]    rf_data_s1_op;
    logic [0:31]     pc_s1;
    logic [0:31]     pc_s2;
    logic [0:31]     pc_s3;
    logic [0:31]     pc_s4;
    logic [0:31]     pc_s5;
    logic            flush_s1;
    logic            flush_s2;
    logic            flush_s3;
    logic            flush_s4;
    logic            flush_s5;
    logic            rf_s1_we;
    logic            rf_s2_we;
    logic            rf_s3_we;
    logic            rf_s4_we;
    logic            rf_s5_we;
    logic            rf_s6_we;
    logic            rf_s7_we;
    logic            flush_reg;
    logic [0:31]     PC_reg;
    logic [0:127]    RT_reg;
    logic [0:2]      unit_idx;

    logic [0:WORD-1] repc_lb32_I10;
    logic [0:WORD-1] repc_lb32_I16;

// Shift Rotate variables
    logic [0:127]    result;
    logic [0:127]    result_temp;

    assign repc_lb32_I10 = {{18{in_I10[0]}}, in_I10, 4'b0000};
    assign repc_lb32_I16 = {{14{in_I16[0]}}, in_I16, 2'b00};

    always_ff @(posedge clk) begin
        if(rst) begin
            rf_addr_s1_op <= 'd0;
            rf_addr_s2_op <= 'd0;
            rf_addr_s3_op <= 'd0;
            rf_addr_s4_op <= 'd0;
            rf_addr_s5_op <= 'd0;
            rf_addr_s6_op <= 'd0;
            rf_addr_s7_op <= 'd0;
            out_RT_addr   <= 'd0;
            rf_data_s1_op <= 'd0;
            rf_data_s2_op <= 'd0;
            rf_data_s3_op <= 'd0;
            rf_data_s4_op <= 'd0;
            rf_data_s5_op <= 'd0;
            rf_data_s6_op <= 'd0;
            rf_data_s7_op <= 'd0;
            rf_idx_s1_op  <= 'd0;
            rf_idx_s2_op  <= 'd0;
            rf_idx_s3_op  <= 'd0;
            rf_idx_s4_op  <= 'd0;
            rf_idx_s5_op  <= 'd0;
            rf_idx_s6_op  <= 'd0;
            rf_idx_s7_op  <= 'd0;
            out_RT        <= 'd0;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= 'd0;
            rf_s6_we      <= 'd0;
            rf_s7_we      <= 'd0;
            rt_wr_en_op   <= 'd0;
            pc_s1         <= 'd0;
            pc_s2         <= 'd0;
            pc_s3         <= 'd0;
            pc_s4         <= 'd0;
            pc_s5         <= 'd0;
            PC_out        <= 'd0;
            flush_s1      <= 'd0;
            flush_s2      <= 'd0;
            flush_s3      <= 'd0;
            flush_s4      <= 'd0;
            flush_s5      <= 'd0;
        end
        else if(flush) begin
            rf_addr_s1_op <= 'd0;
            rf_addr_s2_op <= 'd0;
            rf_addr_s3_op <= 'd0;
            rf_addr_s4_op <= 'd0;
            rf_addr_s5_op <= rf_addr_s4_op;
            rf_addr_s6_op <= rf_addr_s5_op;
            rf_addr_s7_op <= rf_addr_s6_op;
            out_RT_addr   <= rf_addr_s7_op;
            rf_idx_s1_op  <= 'd0;
            rf_idx_s2_op  <= 'd0;
            rf_idx_s3_op  <= 'd0;
            rf_idx_s4_op  <= 'd0;
            rf_idx_s5_op  <= rf_idx_s4_op;
            rf_idx_s6_op  <= rf_idx_s5_op;
            rf_idx_s7_op  <= rf_idx_s6_op;
            rf_data_s1_op <= 'd0;
            rf_data_s2_op <= 'd0;
            rf_data_s3_op <= 'd0;
            rf_data_s4_op <= 'd0;
            rf_data_s5_op <= rf_data_s4_op;
            rf_data_s6_op <= rf_data_s5_op;
            rf_data_s7_op <= rf_data_s6_op;
            out_RT        <= rf_data_s7_op;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_op   <= rf_s7_we;
            pc_s1         <= PC_reg;
            pc_s2         <= pc_s1;
            pc_s3         <= pc_s2;
            pc_s4         <= pc_s3;
            pc_s5         <= pc_s4;
            PC_out        <= pc_s5;
            flush_s1      <= 'd0;
            flush_s2      <= 'd0;
            flush_s3      <= 'd0;
            flush_s4      <= 'd0;
            flush_s5      <= 'd0;
            flush         <= 'd0;
        end
        else begin
            rf_addr_s1_op <= in_RT_addr;
            rf_addr_s2_op <= rf_addr_s1_op;
            rf_addr_s3_op <= rf_addr_s2_op;
            rf_addr_s4_op <= rf_addr_s3_op;
            rf_addr_s5_op <= rf_addr_s4_op;
            rf_addr_s6_op <= rf_addr_s5_op;
            rf_addr_s7_op <= rf_addr_s6_op;
            out_RT_addr   <= rf_addr_s7_op;
            rf_idx_s1_op  <= unit_idx;
            rf_idx_s2_op  <= rf_idx_s1_op;
            rf_idx_s3_op  <= rf_idx_s2_op;
            rf_idx_s4_op  <= rf_idx_s3_op;
            rf_idx_s5_op  <= rf_idx_s4_op;
            rf_idx_s6_op  <= rf_idx_s5_op;
            rf_idx_s7_op  <= rf_idx_s6_op;
            rf_data_s1_op <= RT_reg;
            rf_data_s2_op <= rf_data_s1_op;
            rf_data_s3_op <= rf_data_s2_op;
            rf_data_s4_op <= rf_data_s3_op;
            rf_data_s5_op <= rf_data_s4_op;
            rf_data_s6_op <= rf_data_s5_op;
            rf_data_s7_op <= rf_data_s6_op;
            out_RT        <= rf_data_s7_op;
            rf_s1_we      <= rt_wr_en;
            rf_s2_we      <= rf_s1_we;
            rf_s3_we      <= rf_s2_we;
            rf_s4_we      <= rf_s3_we;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_op   <= rf_s7_we;
            pc_s1         <= PC_reg;
            pc_s2         <= pc_s1;
            pc_s3         <= pc_s2;
            pc_s4         <= pc_s3;
            pc_s5         <= pc_s4;
            PC_out        <= pc_s5;
            flush_s1      <= flush_reg;
            flush_s2      <= flush_s1;
            flush_s3      <= flush_s2;
            flush_s4      <= flush_s3;
            flush_s5      <= flush_s4;
            flush         <= flush_s5;
        end
    end

   always_comb
    begin
        rt_wr_en = 'd0;
        RT_reg = 'd0;
        PC_reg = 'd0;
        unit_idx = 'd0;
        flush_reg = 'd0;
        out_ls_wr_en = 'd0;
        cache_wr = 'd0;

        case(opcode)

            LOAD_QUADWORD_DFORM:
                begin
                    out_ls_addr = $signed($signed(repc_lb32_I10) + $signed(in_RA[0:31])) & MASK1;
                    RT_reg = in_ls_data;
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd6;
                end

            LOAD_QUADWORD_AFORM:
                begin
                    out_ls_addr = repc_lb32_I16 & MASK1;
                    RT_reg = in_ls_data;
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd6;
                end

            STORE_QUADWORD_DFORM:
                begin
                    out_ls_addr = $signed($signed(repc_lb32_I10) + $signed(in_RA[0:31])) & MASK1;
                    out_ls_data = in_RC;
                    out_ls_wr_en = 1'b1;
                    rt_wr_en = 1'b0;
                    unit_idx = 3'd6;
                end

            STORE_QUADWORD_AFORM:
                begin
                    out_ls_addr = repc_lb32_I16 & MASK1;
                    out_ls_data = in_RC;
                    out_ls_wr_en = 1'b1;
                    rt_wr_en = 1'b0;
                    unit_idx = 3'd6;
                end

            BRANCH_RELATIVE_AND_SET_LINK:
                begin
                    RT_reg[0:31] = (PC_in + 32'd4);
                    RT_reg[32:127] = 'd0;
                    PC_reg = ($signed(PC_in) + $signed(repc_lb32_I16));
                    rt_wr_en = 1'b1;
                    flush_reg = 1;
                    unit_idx = 3'd7;
                end

            BRANCH_ABSOLUTE_AND_SET_LINK:
                begin
                    RT_reg[0:31] = (PC_in + 32'd4);
                    RT_reg[32:127] = 'd0;
                    PC_reg = repc_lb32_I16;
                    rt_wr_en = 1'b1;
                    flush_reg = 1;
                    unit_idx = 3'd7;
                end

            BRANCH_INDIRECT:
                begin
                    PC_reg = in_RA[0:31] & MASK2;
                    rt_wr_en = 1'b0;
                    flush_reg = 1;
                    unit_idx = 3'd7;
                end

            BRANCH_RELATIVE:
                begin
                    PC_reg = ($signed(PC_in) + $signed(repc_lb32_I16));
                    rt_wr_en = 1'b0;
                    flush_reg = 1;
                    unit_idx = 3'd7;
                end

            BRANCH_ABSOLUTE:
                begin
                    PC_reg = repc_lb32_I16;
                    rt_wr_en = 1'b0;
                    flush_reg = 1;
                    unit_idx = 3'd7;
                end

            BRANCH_IF_NOT_ZERO_WORD:
                begin
                    if(in_RC[0:31] != 32'd0) begin
                        PC_reg = (PC_in + repc_lb32_I16) & MASK2;
                        flush_reg = 1;
                    end
                    else begin
                        PC_reg = PC_in + 4;
                        flush_reg = 0;
                    end
                    unit_idx = 3'd7;
                    rt_wr_en = 1'b0;
                end
            
            BRANCH_IF_ZERO_WORD:
                begin
                    if(in_RC[0:31] == 32'd0) begin
                        PC_reg = (PC_in + repc_lb32_I16) & MASK2;
                        flush_reg = 1;
                    end
                    else begin
                        PC_reg = PC_in + 4;
                        flush_reg = 0;
                    end
                    unit_idx = 3'd7;
                    rt_wr_en = 1'b0;
                end

            BRANCH_IF_NOT_ZERO_HALFWORD:
                begin
                    if(in_RC[16:31] != 16'd0) begin
                        PC_reg = (PC_in + repc_lb32_I16) & MASK2;
                        flush_reg = 1;
                    end
                    else begin
                        PC_reg = PC_reg + 4;
                        flush_reg = 0;
                    end
                    unit_idx = 3'd7;
                    rt_wr_en = 1'b0;
                end

            BRANCH_IF_ZERO_HALFWORD:
                begin
                    if(in_RC[16:31] == 16'd0) begin
                        PC_reg = (PC_in + repc_lb32_I16) & MASK2;
                        flush_reg = 1;
                    end
                    else begin
                        PC_reg = PC_in + 4;
                        flush_reg = 0;
                    end
                    unit_idx = 3'd7;
                    rt_wr_en = 1'b0;
                end

            SHIFT_LEFT_QUADWORD_BY_BITS :
                begin
                    RT_reg = in_RA << in_RB[29:31];
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd5;
                end

            SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE :
                begin
                    RT_reg = in_RA << in_I7[4:6];
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd5;
                end

            SHIFT_LEFT_QUADWORD_BY_BYTES :
                begin
                    if (in_RB[27:31] < 16) begin
                        RT_reg = in_RA << in_RB[27:31] * 8;
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd5;
                end
            
            SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE:
                begin
                    if (in_I7[2:6] < 16) begin
                        RT_reg = in_RA << in_I7[2:6] * 8;
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    rt_wr_en = 1'b1;
                    unit_idx = 3'd5;
                end

            ROTATE_QUADWORD_BY_BITS:
                begin
                    if (in_RB[29:31] < 8) begin
                        result_temp = in_RA;
                        for (int i = 0; i < in_RB[29:31]; i++) begin
                            result = {result_temp[1:127],result_temp[0]};
                            result_temp = result;
                        end
                        RT_reg = result_temp;
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    unit_idx = 3'd5;
                    rt_wr_en = 1'b1;
                 end
            
             ROTATE_QUADWORD_BY_BITS_IMMEDIATE:
                begin
                   if (in_I7[4:6] < 8) begin
                      result_temp = in_RA;
                      for (int i = 0; i < in_I7[4:6]; i++) begin
                         result = {result_temp[1:127],result_temp[0]};
                         result_temp = result;
                      end
                      RT_reg = result_temp;
                   end
                   else begin
                      RT_reg = 'd0;
                   end
                   unit_idx = 3'd5;
                   rt_wr_en = 1'b1;
                end

             ROTATE_QUADWORD_BY_BYTES:
                begin
                   if (in_RB[27:31] < 16) begin
                       result_temp = in_RA;
                       for (int i = 0; i < in_RB[27:31]; i++) begin
                           result = {result_temp[8:127],result_temp[0:7]};
                           result_temp = result;
                       end
                       RT_reg = result_temp;
                   end
                   else begin
                       RT_reg = 'd0;
                   end
                   unit_idx = 3'd5;
                   rt_wr_en = 1'b1;
                end
            
             ROTATE_QUADWORD_BY_BYTES_IMMEDIATE:
                begin
                   if (in_I7[2:6] < 16) begin
                       result_temp = in_RA;
                       for (int i = 0; i < in_I7[2:6]; i++) begin
                           result = {result_temp[8:127],result_temp[0:7]};
                           result_temp = result;
                       end
                       RT_reg = result_temp;
                   end
                   else begin
                       RT_reg = 'd0;
                   end
                   unit_idx = 3'd5;
                   rt_wr_en = 1'b1;
                end
            
             CMISS:
                begin
                   cache_wr =  'd1;
                   out_ls_addr = PC_in;
                   rt_wr_en = 1'b0;
                end

             NOP:
                begin
                   rt_wr_en = 1'b0;
                end

         endcase
    end
endmodule
//end of file.
