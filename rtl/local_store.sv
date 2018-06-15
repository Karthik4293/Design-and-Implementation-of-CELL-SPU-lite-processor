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

module local_store #(parameter MEM_SIZE = LS_SIZE)
(
    input  logic                   clk,
    input  logic                   rst,
    input  logic [0:127]           ls_data_wr,
    input  logic [0:31]            ls_addr,
    input  logic                   ls_wr_en,
    input  logic                   cache_wr,
    output logic [0:1023]          cache_out,
    output logic [0:127]           ls_data_rd
);

    logic [0:7] ls_mem[MEM_SIZE];

    initial begin
        $readmemb(LSLOADFILE, ls_mem);
    end

    always_ff @(posedge clk) begin
        if(ls_wr_en) begin
            for(int i = 0; i < 16; i++) begin
                ls_mem[ls_addr + i] <= ls_data_wr[i*8 +: 8];
            end
        end

        if(cache_wr) begin
            for(int i = 0; i < 256; i++) begin
                cache_out[i*8 +: 8] = ls_mem[ls_addr + i];
            end
        end
    end

    always_comb begin
        for(int i = 0; i < 16; i++) begin
            ls_data_rd[i*8 +: 8] = (ls_wr_en) ? ls_data_wr[i*8 +: 8] : ls_mem[ls_addr + i];
        end
    end

endmodule
//end of file.
