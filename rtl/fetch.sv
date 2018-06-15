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

module fetch 
(
    input  logic             clk,
    input  logic             rst,
    input  logic  [0:1023]   cache_line,
    input  logic             cache_wr,
    input  logic             branch_taken,
    input  logic             dec_stall,
    input  logic             dep_stall,
    input  logic  [0:31]     pc_in,
    output logic  [0:31]     pc_out,
    output logic  [0:31]     eins1,
    output logic  [0:31]     eins2
);

    logic [0:63]         cache[32];
    logic [0:31]         pc;
    logic [0:7]          blk_tag[2];
    logic                blk_valid[2];

    logic [0:7]          tag;
    logic [0:6]          offset;
    logic                last_used;
    logic                chit1;
    logic                chit2;
    logic                chit;
    logic                cmiss;
    logic                cw_pending;
    logic                cache_wr_dly;
    logic                only1_inst;

    always_ff @(posedge clk) begin
        if(rst) begin
            cw_pending <= 'd0;
        end
        else begin
            if(cw_pending && chit) begin
                cw_pending <= 'd0;
            end
            else if(cmiss && !dep_stall) begin
                cw_pending <= 'd1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            cache_wr_dly <= 'd0;
        end
        else begin
            cache_wr_dly <= cache_wr;
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            pc <= 'd0;
        end
        else begin
            if(branch_taken) begin
                pc <= pc_in;
            end
            else if(dec_stall || dep_stall) begin
                pc <= pc;
            end
            else if(!cmiss) begin
                pc <= (only1_inst) ? pc + 4 : pc + 8;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            cache <= '{default:'0};
            blk_tag <= '{default:'dx};
            blk_valid <= '{default:'0};
            last_used <= 'd0;
        end
        else if(cache_wr_dly) begin
            if(!blk_valid[0]) begin
                blk_tag[0] <= tag;
                blk_valid[0] <= 1;
                for(int i = 0; i < 16; i++) begin
                    cache[i] <= cache_line[i*64 +: 64];
                end
            end
            else if(!blk_valid[1]) begin
                blk_tag[1] <= tag;
                blk_valid[1] <= 1;
                for(int i = 0; i < 16; i++) begin
                    cache[i+16] <= cache_line[i*64 +: 64];
                end
            end
            else if(last_used) begin
                blk_tag[0] <= tag;
                blk_valid[0] <= 1;
                last_used <= ~last_used;
                for(int i = 0; i < 16; i++) begin
                    cache[i] <= cache_line[i*64 +: 64];
                end
            end
            else begin
                blk_tag[1] <= tag;
                blk_valid[1] <= 1;
                last_used <= ~last_used;
                for(int i = 0; i < 16; i++) begin
                    cache[i+16] <= cache_line[i*64 +: 64];
                end
            end
        end
    end

    always_comb begin
        tag = pc[19:24];
        offset = pc[25:31] >> 3;
        only1_inst = pc[29];
        pc_out = pc;
        chit1 = (tag === blk_tag[0] && blk_valid[0]);
        chit2 = (tag === blk_tag[1] && blk_valid[1]); 
        chit  = chit1 || chit2;
        cmiss = ~chit;
        if(chit1) begin
            eins1 = cache[offset][0:31];
            eins2 = (only1_inst) ? {11'b01000000001, 21'dx} : cache[offset][32:63];
        end
        else if(chit2) begin
            eins1 = cache[16 + offset][0:31];
            eins2 = (only1_inst) ? {11'b01000000001, 21'dx} : cache[16 + offset][32:63];
        end
        else if(cw_pending) begin
            eins1 = {11'b00000000001, 21'dx};
            eins2 = {11'b01000000001, 21'dx};
        end
        else begin
            eins1 = 32'hffffffff;
            eins2 = 32'hffffffff;
        end
    end

endmodule
//end of file.
