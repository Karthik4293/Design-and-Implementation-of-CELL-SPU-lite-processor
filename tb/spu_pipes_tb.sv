// ------------------------------------------//
// 
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal                           
// NETID: aahangar                             
// SBUID: 111416569                            
//
// ------------------------------------------//

import defines_pkg::*;

module spu_pipes_tb();

    logic                  clk; 
    logic                  rst;
    Opcodes                opcode_ep;
    Opcodes                opcode_op;
    logic [6:0]            ra_addr_ep;
    logic [6:0]            rb_addr_ep;
    logic [6:0]            rc_addr_ep;
    logic [6:0]            rt_addr_ep;
    logic [6:0]            ra_addr_op;
    logic [6:0]            rb_addr_op;
    logic [6:0]            rc_addr_op;
    logic [6:0]            rt_addr_op;
    logic [6:0]            in_I7e;
    logic [7:0]            in_I8e;
    logic [9:0]            in_I10e;
    logic [15:0]           in_I16e;
    logic [17:0]           in_I18e;
    logic [6:0]            in_I7o;
    logic [7:0]            in_I8o;
    logic [9:0]            in_I10o;
    logic [15:0]           in_I16o;
    logic [17:0]           in_I18o;
    logic [0:31]           PC_wr;
    logic [0:31]           PC_rd;

    logic [56:0]           ins_ep[NUM_INS];
    logic [56:0]           ins_op[NUM_INS];

    always #5 clk = ~clk;

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
        .PC_in(PC_rd),
        .PC_out(PC_wr),
        .in_I7e(in_I7e),
        .in_I8e(in_I8e),
        .in_I10e(in_I10e),
        .in_I16e(in_I16e),
        .in_I18e(in_I18e),
        .in_I7o(in_I7o),
        .in_I8o(in_I8o),
        .in_I10o(in_I10o),
        .in_I16o(in_I16o),
        .in_I18o(in_I18o)
    );
    
    initial begin
        clk = 0;
        rst = 0;
        ra_addr_ep = 0;
        rb_addr_ep = 0;
        rc_addr_ep = 0;
        rt_addr_ep = 0;
        ra_addr_op = 0;
        rb_addr_op = 0;
        rc_addr_op = 0;
        rt_addr_op = 0;
        in_I7e = 0;
        in_I8e = 0;
        in_I10e = 0;
        in_I16e = 0;
        in_I18e = 0;
        in_I7o = 0;
        in_I8o = 0;
        in_I10o = 0;
        in_I16o = 0;
        in_I18o = 0;
        PC_rd = 0;
        $readmemb(EVENINSFILE, ins_ep);
        $readmemb(ODDINSFILE, ins_op);

        @(posedge clk) rst = 1;
        @(posedge clk) rst = 0;

        for(int i = 0; i < NUM_INS; i++)  begin
            @(posedge clk);
            opcode_ep  = Opcodes'(ins_ep[i][56:46]);
            rt_addr_ep = ins_ep[i][6:0];
            rc_addr_ep = ins_ep[i][13:7];
            rb_addr_ep = ins_ep[i][20:14];
            ra_addr_ep = ins_ep[i][27:21];
            in_I18e    = ins_ep[i][45:28];
            in_I16e    = in_I18e[15:0];
            in_I10e    = in_I18e[9:0];
            in_I8e     = in_I18e[7:0];
            in_I7e     = in_I18e[6:0];
            opcode_op  = Opcodes'(ins_op[i][56:46]);
            rt_addr_op = ins_op[i][6:0];
            rc_addr_op = ins_op[i][13:7];
            rb_addr_op = ins_op[i][20:14];
            ra_addr_op = ins_op[i][27:21];
            in_I18o    = ins_op[i][45:28];
            in_I16o    = in_I18o[15:0];
            in_I10o    = in_I18o[9:0];
            in_I8o     = in_I18o[7:0];
            in_I7o     = in_I18o[6:0];
        end

        repeat(100) @(posedge clk);
        $finish;
    end


endmodule
//end of file.
