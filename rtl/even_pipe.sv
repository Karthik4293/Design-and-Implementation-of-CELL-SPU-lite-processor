// ------------------------------------------//
// Even Pipe
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

module even_pipe #(parameter OPCODE_LEN  = 11,
                   parameter REG_ADDR_WD = 7,
                   parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode,
    output logic                     rt_wr_en_ep,
    input  logic [0:127]             in_RA,
    input  logic [0:127]             in_RB,
    input  logic [0:127]             in_RC,
    input  logic [0:6]               in_I7,
    input  logic [0:7]               in_I8,
    input  logic [0:9]               in_I10,
    input  logic [0:15]              in_I16,
    input  logic [0:17]              in_I18,
    input  logic                     flush,
    input  logic [0:6]               in_RT_addr,
    output logic [0:6]               rf_addr_s1_ep,
    output logic [0:6]               rf_addr_s2_ep,
    output logic [0:6]               rf_addr_s3_ep,
    output logic [0:6]               rf_addr_s4_ep,
    output logic [0:6]               rf_addr_s5_ep,
    output logic [0:6]               rf_addr_s6_ep,
    output logic [0:6]               rf_addr_s7_ep,
    output logic [0:2]               rf_idx_s1_ep,
    output logic [0:2]               rf_idx_s2_ep,
    output logic [0:2]               rf_idx_s3_ep,
    output logic [0:2]               rf_idx_s4_ep,
    output logic [0:2]               rf_idx_s5_ep,
    output logic [0:2]               rf_idx_s6_ep,
    output logic [0:2]               rf_idx_s7_ep,
    output logic [0:127]             rf_data_s2_ep,
    output logic [0:127]             rf_data_s3_ep,
    output logic [0:127]             rf_data_s4_ep,
    output logic [0:127]             rf_data_s5_ep,
    output logic [0:127]             rf_data_s6_ep,
    output logic [0:127]             rf_data_s7_ep,
    output logic [0:6]               out_RT_addr,
    output logic [0:127]             out_RT
);

    logic            rt_wr_en;
    logic [0:127]    rf_data_s1_ep;
    logic            rf_s1_we;
    logic            rf_s2_we;
    logic            rf_s3_we;
    logic            rf_s4_we;
    logic            rf_s5_we;
    logic            rf_s6_we;
    logic            rf_s7_we;
    logic [0:127]    RT_reg;
    logic [0:32]     temp_reg;
    logic [0:7]      temp_byte_reg;
    logic [0:7]      cnt_reg;
    logic [0:2]      unit_idx;
    real             temp_fp;
    real             temp_op1;
    real             temp_op2;
    real             temp_op3;
    real             temp_fpe;

    logic [0:WORD-1]     rep_lb32_I16;
    logic [0:HALFWORD-1] rep_lb16_I10;
    logic [0:WORD-1]     rep_lb32_I10;

    assign rep_lb32_I16 = {{16{in_I16[0]}}, in_I16};
    assign rep_lb16_I10 = {{6{in_I10[0]}}, in_I10};
    assign rep_lb32_I10 = {{22{in_I10[0]}}, in_I10};

    //Rotate Variables
    logic [0:31]   result;
    logic [0:31]   operand;
    logic [0:4]    rotate;
    logic [0:4]    rotate_temp;

    always_ff @(posedge clk) begin
        if(rst) begin
            rf_addr_s1_ep <= 'd0;
            rf_addr_s2_ep <= 'd0;
            rf_addr_s3_ep <= 'd0;
            rf_addr_s4_ep <= 'd0;
            rf_addr_s5_ep <= 'd0;
            rf_addr_s6_ep <= 'd0;
            rf_addr_s7_ep <= 'd0;
            out_RT_addr   <= 'd0;
            rf_data_s1_ep <= 'd0;
            rf_data_s2_ep <= 'd0;
            rf_data_s3_ep <= 'd0;
            rf_data_s4_ep <= 'd0;
            rf_data_s5_ep <= 'd0;
            rf_data_s6_ep <= 'd0;
            rf_data_s7_ep <= 'd0;
            rf_idx_s1_ep  <= 'd0;
            rf_idx_s2_ep  <= 'd0;
            rf_idx_s3_ep  <= 'd0;
            rf_idx_s4_ep  <= 'd0;
            rf_idx_s5_ep  <= 'd0;
            rf_idx_s6_ep  <= 'd0;
            rf_idx_s7_ep  <= 'd0;
            out_RT        <= 'd0;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= 'd0;
            rf_s6_we      <= 'd0;
            rf_s7_we      <= 'd0;
            rt_wr_en_ep   <= 'd0;
        end
        else if(flush) begin
            rf_addr_s1_ep <= 'd0;
            rf_addr_s2_ep <= 'd0;
            rf_addr_s3_ep <= 'd0;
            rf_addr_s4_ep <= 'd0;
            rf_addr_s5_ep <= rf_addr_s4_ep;
            rf_addr_s6_ep <= rf_addr_s5_ep;
            rf_addr_s7_ep <= rf_addr_s6_ep;
            rf_idx_s1_ep  <= 'd0;
            rf_idx_s2_ep  <= 'd0;
            rf_idx_s3_ep  <= 'd0;
            rf_idx_s4_ep  <= 'd0;
            rf_idx_s5_ep  <= rf_idx_s4_ep;
            rf_idx_s6_ep  <= rf_idx_s5_ep;
            rf_idx_s7_ep  <= rf_idx_s6_ep;
            out_RT_addr   <= rf_addr_s7_ep;
            rf_data_s1_ep <= 'd0;
            rf_data_s2_ep <= 'd0;
            rf_data_s3_ep <= 'd0;
            rf_data_s4_ep <= 'd0;
            rf_data_s5_ep <= rf_data_s4_ep;
            rf_data_s6_ep <= rf_data_s5_ep;
            rf_data_s7_ep <= rf_data_s6_ep;
            out_RT        <= rf_data_s7_ep;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_ep   <= rf_s7_we;
        end
        else begin
            rf_addr_s1_ep <= in_RT_addr;
            rf_addr_s2_ep <= rf_addr_s1_ep;
            rf_addr_s3_ep <= rf_addr_s2_ep;
            rf_addr_s4_ep <= rf_addr_s3_ep;
            rf_addr_s5_ep <= rf_addr_s4_ep;
            rf_addr_s6_ep <= rf_addr_s5_ep;
            rf_addr_s7_ep <= rf_addr_s6_ep;
            rf_idx_s1_ep  <= unit_idx;
            rf_idx_s2_ep  <= rf_idx_s1_ep;
            rf_idx_s3_ep  <= rf_idx_s2_ep;
            rf_idx_s4_ep  <= rf_idx_s3_ep;
            rf_idx_s5_ep  <= rf_idx_s4_ep;
            rf_idx_s6_ep  <= rf_idx_s5_ep;
            rf_idx_s7_ep  <= rf_idx_s6_ep;
            out_RT_addr   <= rf_addr_s7_ep;
            rf_data_s1_ep <= RT_reg;
            rf_data_s2_ep <= rf_data_s1_ep;
            rf_data_s3_ep <= rf_data_s2_ep;
            rf_data_s4_ep <= rf_data_s3_ep;
            rf_data_s5_ep <= rf_data_s4_ep;
            rf_data_s6_ep <= rf_data_s5_ep;
            rf_data_s7_ep <= rf_data_s6_ep;
            out_RT        <= rf_data_s7_ep;
            rf_s1_we      <= rt_wr_en;
            rf_s2_we      <= rf_s1_we;
            rf_s3_we      <= rf_s2_we;
            rf_s4_we      <= rf_s3_we;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_ep   <= rf_s7_we;
        end
    end

    always_comb
    begin
        rt_wr_en = 'd0;
        RT_reg = 'd0;
        unit_idx = 'd0;
        cnt_reg = 'd0;

        operand = 'd0;
        result = 'd0;
        rotate = 'd0;
        rotate_temp = 'd0;

        case(opcode)

            //Simple Fixed Unit
            IMMEDIATE_LOAD_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_I16;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            IMMEDIATE_LOAD_WORD:
                 begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = rep_lb32_I16;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                 end

            IMMEDIATE_LOAD_ADDRESS:
                 begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_I18 & 18'h3ffff;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                 end

            ADD_HALF_WORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] + in_RB[i*HALFWORD +: HALFWORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            ADD_HALF_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] + rep_lb16_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            ADD_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] + in_RB[i*WORD +: WORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            ADD_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] + rep_lb32_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] - in_RB[i*HALFWORD +: HALFWORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] - rep_lb16_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] - in_RB[i*WORD +: WORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] - rep_lb32_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            ADD_EXTENDED:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] + in_RB[i*WORD +: WORD] + in_RC[i*WORD]; //TODO:Using RC instead of RT for now. Recheck
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_EXTENDED:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RB[i*WORD +: WORD] - in_RA[i*WORD +: WORD] + in_RC[i*WORD]; //TODO:Using RC instead of RT for now. Recheck
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            CARRY_GENERATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_reg = in_RA[i*WORD +: WORD] + in_RB[i*WORD +: WORD];
                        RT_reg[i*WORD +: WORD] = {31'd0, temp_reg[0]};
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            BORROW_GENERATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RB[i*WORD +: WORD] >= in_RA[i*WORD +: WORD]) ? 32'd1 : 32'd0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COUNT_LEADING_ZEROS:
                begin
                    for(int i=0; i < 4; i++) begin
                        cnt_reg = 'd0;
                        temp_reg = in_RA[i*WORD +: WORD];
                        for(int j=0; j < WORD; j++) begin
                            if(temp_reg[j] && cnt_reg == 'd0) begin 
                                cnt_reg = 'd1;
                                RT_reg[i*WORD +: WORD] = j;
                            end
                        end
                        if(cnt_reg == 'd0) RT_reg[i*WORD +: WORD] = 32;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            AND:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] & in_RB[i*WORD +: WORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            AND_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] & rep_lb32_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            AND_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] & rep_lb16_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            AND_BYTE_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_reg[0:7] = in_I10 & 32'h00ff;
                        temp_reg[0:31] = {4{temp_reg[0:7]}};
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] & temp_reg[0:31];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            OR:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] | in_RB[i*WORD +: WORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            OR_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] | rep_lb32_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            OR_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] | rep_lb16_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            OR_BYTE_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_reg[0:7] = in_I10 & 32'h00ff;
                        temp_reg[0:31] = {4{temp_reg[0:7]}};
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] | temp_reg[0:31];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            EXCLUSIVE_OR:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] ^ in_RB[i*WORD +: WORD];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            EXCLUSIVE_OR_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] ^ rep_lb32_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            EXCLUSIVE_OR_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] ^ rep_lb16_I10;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            EXCLUSIVE_OR_BYTE_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_reg[0:7] = in_I10 & 32'h00ff;
                        temp_reg[0:31] = {4{temp_reg[0:7]}};
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] ^ temp_reg[0:31];
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            NAND:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = ~(in_RA[i*WORD +: WORD] & in_RB[i*WORD +: WORD]);
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            NOR:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = ~(in_RA[i*WORD +: WORD] | in_RB[i*WORD +: WORD]);
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            EQUIVALENT:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] ^ (~in_RB[i*WORD +: WORD]);
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_EQUAL_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RA[i*WORD +: WORD] == in_RB[i*WORD +: WORD])? 32'hffffffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_EQUAL_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RA[i*WORD +: WORD] == rep_lb32_I10)? 32'hffffffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_EQUAL_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = (in_RA[i*HALFWORD +: HALFWORD] == in_RB[i*HALFWORD +: HALFWORD])? 32'hffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_EQUAL_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = (in_RA[i*HALFWORD +: HALFWORD] == rep_lb16_I10)? 32'hffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_GREATER_THAN_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RA[i*WORD +: WORD] > in_RB[i*WORD +: WORD])? 32'hffffffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_GREATER_THAN_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RA[i*WORD +: WORD] > rep_lb32_I10)? 32'hffffffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_GREATER_THAN_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = (in_RA[i*HALFWORD +: HALFWORD] > in_RB[i*HALFWORD +: HALFWORD])? 32'hffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = (in_RA[i*HALFWORD +: HALFWORD] > rep_lb16_I10)? 32'hffff : 32'h0;
                    end
                    unit_idx = 3'd1;
                    rt_wr_en = 1;
                end

            //Single Precision Unit
            MULTIPLY:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[((i*WORD)+HALFWORD) +: HALFWORD] * in_RB[((i*WORD)+HALFWORD) +: HALFWORD];
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            MULTIPLY_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[((i*WORD)+HALFWORD) +: HALFWORD] * rep_lb16_I10;
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            MULTIPLY_AND_ADD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = (in_RA[((i*WORD)+HALFWORD) +: HALFWORD] * in_RB[((i*WORD)+HALFWORD) +: HALFWORD]) + in_RC[i*WORD +: WORD];
                    end
                    unit_idx = 3'd7;
                    rt_wr_en = 1;
                end

            FLOATING_ADD:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_op1 = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_op2 = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_fp = temp_op1 + temp_op2;
                        if (temp_fp < -S_MAX)                         RT_reg[i*WORD +: WORD] = -$shortrealtobits(S_MAX);
                        else if (temp_fp > S_MAX)                     RT_reg[i*WORD +: WORD] =  $shortrealtobits(S_MAX);
                        else if (temp_fp > -S_MIN && temp_fp < S_MIN) RT_reg[i*WORD +: WORD] =  0;
                        else                                          RT_reg[i*WORD +: WORD] =  $shortrealtobits(temp_fp);
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_SUBTRACT:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_op1 = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_op2 = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_fp = temp_op1 - temp_op2;
                        if (temp_fp < -S_MAX)                         RT_reg[i*WORD +: WORD] = -$shortrealtobits(S_MAX);
                        else if (temp_fp > S_MAX)                     RT_reg[i*WORD +: WORD] =  $shortrealtobits(S_MAX);
                        else if (temp_fp > -S_MIN && temp_fp < S_MIN) RT_reg[i*WORD +: WORD] =  0;
                        else                                          RT_reg[i*WORD +: WORD] =  $shortrealtobits(temp_fp);
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_MULTIPLY:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_op1 = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_op2 = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_fp = temp_op1 * temp_op2;
                        if (temp_fp < -S_MAX)                         RT_reg[i*WORD +: WORD] = -$shortrealtobits(S_MAX);
                        else if (temp_fp > S_MAX)                     RT_reg[i*WORD +: WORD] =  $shortrealtobits(S_MAX);
                        else if (temp_fp > -S_MIN && temp_fp < S_MIN) RT_reg[i*WORD +: WORD] =  0;
                        else                                          RT_reg[i*WORD +: WORD] =  $shortrealtobits(temp_fp);
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_MULTIPLY_AND_ADD:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_op1 = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_op2 = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_op3 = $bitstoshortreal(in_RC[i*WORD +: WORD]);
                        temp_fp = temp_op1 * temp_op2 + temp_op3;
                        if (temp_fp < -S_MAX)                         RT_reg[i*WORD +: WORD] = -$shortrealtobits(S_MAX);
                        else if (temp_fp > S_MAX)                     RT_reg[i*WORD +: WORD] =  $shortrealtobits(S_MAX);
                        else if (temp_fp > -S_MIN && temp_fp < S_MIN) RT_reg[i*WORD +: WORD] =  0;
                        else                                          RT_reg[i*WORD +: WORD] =  $shortrealtobits(temp_fp);
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_MULTIPLY_AND_SUBTRACT:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_op1 = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_op2 = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_op3 = $bitstoshortreal(in_RC[i*WORD +: WORD]);
                        temp_fp = temp_op1 * temp_op2 - temp_op3;
                        if (temp_fp < -S_MAX)                         RT_reg[i*WORD +: WORD] = -$shortrealtobits(S_MAX);
                        else if (temp_fp > S_MAX)                     RT_reg[i*WORD +: WORD] =  $shortrealtobits(S_MAX);
                        else if (temp_fp > -S_MIN && temp_fp < S_MIN) RT_reg[i*WORD +: WORD] =  0;
                        else                                          RT_reg[i*WORD +: WORD] =  $shortrealtobits(temp_fp);
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_COMPARE_EQUAL:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_fp  = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_fpe = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        if (temp_fp == temp_fpe || (temp_fp < 1 && temp_fpe < 1)) begin
                            RT_reg[i*WORD +: WORD] = 32'hffffffff;
                        end
                        else begin
                            RT_reg[i*WORD +: WORD] = 32'h00000000;
                        end
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_COMPARE_MAGNITUDE_EQUAL:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_fp  = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_fpe = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_fp  = (temp_fp  >= 0) ? temp_fp  : -temp_fp; 
                        temp_fpe = (temp_fpe >= 0) ? temp_fpe : -temp_fpe; 
                        if (temp_fp == temp_fpe || (temp_fp < 1 && temp_fpe < 1)) begin
                            RT_reg[i*WORD +: WORD] = 32'hffffffff;
                        end
                        else begin
                            RT_reg[i*WORD +: WORD] = 32'h00000000;
                        end
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_COMPARE_GREATER_THAN:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_fp  = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_fpe = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        if (temp_fp > temp_fpe && !(temp_fp < 1 && temp_fpe < 1)) begin
                            RT_reg[i*WORD +: WORD] = 32'hffffffff;
                        end
                        else begin
                            RT_reg[i*WORD +: WORD] = 32'h00000000;
                        end
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            FLOATING_COMPARE_MAGNITUDE_GREATER_THAN:
                begin
                    for(int i=0; i < 4; i++) begin
                        temp_fp  = $bitstoshortreal(in_RA[i*WORD +: WORD]);
                        temp_fpe = $bitstoshortreal(in_RB[i*WORD +: WORD]);
                        temp_fp  = (temp_fp  >= 0) ? temp_fp  : -temp_fp; 
                        temp_fpe = (temp_fpe >= 0) ? temp_fpe : -temp_fpe; 
                        if (temp_fp > temp_fpe && !(temp_fp < 1 && temp_fpe < 1)) begin
                            RT_reg[i*WORD +: WORD] = 32'hffffffff;
                        end
                        else begin
                            RT_reg[i*WORD +: WORD] = 32'h00000000;
                        end
                    end
                    unit_idx = 3'd3;
                    rt_wr_en = 1;
                end

            //Byte Unit
            COUNT_ONES_IN_BYTES:
                begin
                    for(int i=0; i < 16; i++) begin
                        cnt_reg = 0;
                        temp_byte_reg = in_RA[i*BYTE +: BYTE];
                        for(int i=0; i < 7; i++) begin
                            if(temp_byte_reg[i]) cnt_reg = cnt_reg + 1;
                        end
                        RT_reg[i*BYTE +: BYTE] = cnt_reg;
                    end
                    unit_idx = 3'd4;
                    rt_wr_en = 1;
                end

            AVERAGE_BYTES:
                begin
                    for(int i=0; i < 16; i++) begin
                        RT_reg[i*BYTE +: BYTE] = ({8'd0, in_RA[i*BYTE +: BYTE]} + {8'd0, in_RB[i*BYTE +: BYTE]} + 1) >> 1;
                    end
                    unit_idx = 3'd4;
                    rt_wr_en = 1;
                end

            ABSOLUTE_DIFFERENCE_OF_BYTES:
                begin
                    for(int i=0; i < 16; i++) begin
                        if(in_RB[i*BYTE +: BYTE] > in_RA[i*BYTE +: BYTE]) begin
                            RT_reg[i*BYTE +: BYTE] = in_RB[i*BYTE +: BYTE] - in_RA[i*BYTE +: BYTE];
                        end
                        else begin
                            RT_reg[i*BYTE +: BYTE] = in_RA[i*BYTE +: BYTE] - in_RB[i*BYTE +: BYTE];
                        end
                    end
                    unit_idx = 3'd4;
                    rt_wr_en = 1;
                end

            SUM_BYTES_INTO_HALFWORDS:
                begin
                    for(int i=0; i < 4; i++) begin
                            RT_reg[(2*i+0)*HALFWORD +: HALFWORD] = in_RB[(4*i+0)*BYTE +: BYTE] + in_RB[(4*i+1)*BYTE +: BYTE] + in_RB[(4*i+2)*BYTE +: BYTE] + in_RB[(4*i+3)*BYTE +: BYTE];
                            RT_reg[(2*i+1)*HALFWORD +: HALFWORD] = in_RB[(4*i+0)*BYTE +: BYTE] + in_RB[(4*i+1)*BYTE +: BYTE] + in_RB[(4*i+2)*BYTE +: BYTE] + in_RB[(4*i+3)*BYTE +: BYTE];
                    end
                    unit_idx = 3'd4;
                    rt_wr_en = 1;
                end

            //Shift Unit
            SHIFT_LEFT_HALFWORD: 
                begin
                        for(int i=0; i < 8; i++) begin
                          if(in_RB[i*HALFWORD+26 +: 6] < 16) begin
                            RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_RB[i*HALFWORD+26 +: 6];
                          end
                          else begin
                            RT_reg[i*HALFWORD +: HALFWORD] = 'd0;
                          end
                    end
               
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

            SHIFT_LEFT_HALFWORD_IMMEDIATE:
                begin
                    if(in_I7[0:4] < 16) begin
                        for(int i=0; i < 8; i++) begin
                            RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_I7[0:4];
                        end
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

            SHIFT_LEFT_WORD:
                begin
                    for (int i=0; i < 4; i++) begin
                        if (in_RB[i*WORD+26 +: 6] < 32) begin
                            RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] << in_RB[i*WORD+26 +: 6];
                        end
                        else begin
                            RT_reg[i*WORD +: WORD] = 'd0;
                        end
                    end
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

             SHIFT_LEFT_WORD_IMMEDIATE:
                begin
                    if(in_I7[0:4] < 32) begin
                        for(int i=0; i < 4; i++) begin
                            RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] << in_I7[0:4];
                        end
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

             ROTATE_WORD:
                begin
                    for (int i=0; i < 4; i++) begin
                        operand = in_RA[i*WORD +: WORD];
                        rotate = in_RB[i*WORD +: 4];
                        while(rotate > 32) begin
                            rotate_temp = rotate - 32;
                            rotate = rotate_temp;
                        end
                        for ( int j=0; j < rotate ; j++) begin
                            result =  {operand[0:30],operand[0]};
                            operand = result;
                        end
                        RT_reg[i*WORD +: WORD] = operand;
                    end
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

             ROTATE_WORD_IMMEDIATE:
                begin
                    for (int i=0; i < 4; i++) begin
                        operand = in_RA[i*WORD +: WORD];
                        rotate = in_I7[0:4];
                        while(rotate > 32) begin
                            rotate_temp = rotate - 32;
                            rotate = rotate_temp;
                        end
                        for ( int j=0; j < rotate ; j++) begin
                            result =  {operand[0:30],operand[0]};
                            operand = result;
                        end
                        RT_reg[i*WORD +: WORD] = operand;
                    end
                    unit_idx = 3'd2;
                    rt_wr_en = 1;
                end

            LNOP:
                begin
                    //No Operation
                    rt_wr_en = 0;
                end

            STOP:
                begin
                    $finish;
                end

        endcase
    end

endmodule
//end of file.
