onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Spu Top}
add wave -noupdate /spu_tb/u_spu_top/I10_ep
add wave -noupdate /spu_tb/u_spu_top/I10_op
add wave -noupdate /spu_tb/u_spu_top/I16_ep
add wave -noupdate /spu_tb/u_spu_top/I16_op
add wave -noupdate -radix decimal /spu_tb/u_spu_top/I18_ep
add wave -noupdate /spu_tb/u_spu_top/I18_op
add wave -noupdate /spu_tb/u_spu_top/I7_ep
add wave -noupdate /spu_tb/u_spu_top/I7_op
add wave -noupdate /spu_tb/u_spu_top/I8_ep
add wave -noupdate /spu_tb/u_spu_top/I8_op
add wave -noupdate /spu_tb/u_spu_top/cache_line
add wave -noupdate /spu_tb/u_spu_top/cache_wr
add wave -noupdate /spu_tb/u_spu_top/clk
add wave -noupdate /spu_tb/u_spu_top/dec_I10_ep
add wave -noupdate /spu_tb/u_spu_top/dec_I10_op
add wave -noupdate /spu_tb/u_spu_top/dec_I16_ep
add wave -noupdate /spu_tb/u_spu_top/dec_I16_op
add wave -noupdate -radix decimal /spu_tb/u_spu_top/dec_I18_ep
add wave -noupdate /spu_tb/u_spu_top/dec_I18_op
add wave -noupdate /spu_tb/u_spu_top/dec_I7_ep
add wave -noupdate /spu_tb/u_spu_top/dec_I7_op
add wave -noupdate /spu_tb/u_spu_top/dec_I8_ep
add wave -noupdate /spu_tb/u_spu_top/dec_I8_op
add wave -noupdate /spu_tb/u_spu_top/dec_opcode_ep
add wave -noupdate /spu_tb/u_spu_top/dec_opcode_op
add wave -noupdate /spu_tb/u_spu_top/dec_ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/dec_ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/dec_rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/dec_rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/dec_rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/dec_rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/dec_rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/dec_rt_addr_op
add wave -noupdate /spu_tb/u_spu_top/dec_stall
add wave -noupdate /spu_tb/u_spu_top/dep_stall
add wave -noupdate /spu_tb/u_spu_top/eins1
add wave -noupdate /spu_tb/u_spu_top/eins2
add wave -noupdate /spu_tb/u_spu_top/flush
add wave -noupdate /spu_tb/u_spu_top/ins_wr_en
add wave -noupdate /spu_tb/u_spu_top/ls_addr
add wave -noupdate /spu_tb/u_spu_top/ls_data_rd
add wave -noupdate /spu_tb/u_spu_top/ls_data_wr
add wave -noupdate /spu_tb/u_spu_top/ls_wr_en
add wave -noupdate /spu_tb/u_spu_top/opcode_ep
add wave -noupdate /spu_tb/u_spu_top/opcode_op
add wave -noupdate /spu_tb/u_spu_top/pc_dtof
add wave -noupdate /spu_tb/u_spu_top/pc_ftod
add wave -noupdate /spu_tb/u_spu_top/ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s1_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s1_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s2_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s2_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s3_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s3_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s4_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s4_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s5_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s5_op
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s6_ep
add wave -noupdate /spu_tb/u_spu_top/rf_addr_s6_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s1_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s1_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s2_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s2_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s3_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s3_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s4_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s4_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s5_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s5_op
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s6_ep
add wave -noupdate /spu_tb/u_spu_top/rf_idx_s6_op
add wave -noupdate /spu_tb/u_spu_top/rst
add wave -noupdate /spu_tb/u_spu_top/rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/rt_addr_op
add wave -noupdate -divider {local store}
add wave -noupdate /spu_tb/u_spu_top/u_local_store/MEM_SIZE
add wave -noupdate /spu_tb/u_spu_top/u_local_store/cache_out
add wave -noupdate /spu_tb/u_spu_top/u_local_store/cache_wr
add wave -noupdate /spu_tb/u_spu_top/u_local_store/clk
add wave -noupdate /spu_tb/u_spu_top/u_local_store/rst
add wave -noupdate /spu_tb/u_spu_top/u_local_store/ls_addr
add wave -noupdate /spu_tb/u_spu_top/u_local_store/ls_data_rd
add wave -noupdate /spu_tb/u_spu_top/u_local_store/ls_data_wr
add wave -noupdate /spu_tb/u_spu_top/u_local_store/ls_mem
add wave -noupdate /spu_tb/u_spu_top/u_local_store/ls_wr_en
add wave -noupdate -divider fetch
add wave -noupdate /spu_tb/u_spu_top/u_fetch/tag
add wave -noupdate /spu_tb/u_spu_top/u_fetch/blk_tag
add wave -noupdate /spu_tb/u_spu_top/u_fetch/blk_valid
add wave -noupdate /spu_tb/u_spu_top/u_fetch/branch_taken
add wave -noupdate /spu_tb/u_spu_top/u_fetch/cache
add wave -noupdate /spu_tb/u_spu_top/u_fetch/cache_line
add wave -noupdate /spu_tb/u_spu_top/u_fetch/cache_wr
add wave -noupdate /spu_tb/u_spu_top/u_fetch/chit
add wave -noupdate /spu_tb/u_spu_top/u_fetch/chit1
add wave -noupdate /spu_tb/u_spu_top/u_fetch/chit2
add wave -noupdate /spu_tb/u_spu_top/u_fetch/clk
add wave -noupdate /spu_tb/u_spu_top/u_fetch/cmiss
add wave -noupdate /spu_tb/u_spu_top/u_fetch/eins1
add wave -noupdate /spu_tb/u_spu_top/u_fetch/eins2
add wave -noupdate /spu_tb/u_spu_top/u_fetch/last_used
add wave -noupdate -radix decimal /spu_tb/u_spu_top/u_fetch/offset
add wave -noupdate -radix decimal /spu_tb/u_spu_top/u_fetch/pc
add wave -noupdate /spu_tb/u_spu_top/u_fetch/pc_in
add wave -noupdate /spu_tb/u_spu_top/u_fetch/pc_out
add wave -noupdate /spu_tb/u_spu_top/u_fetch/rst
add wave -noupdate -divider {Odd Pipe}
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/MASK1
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/MASK2
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/OPCODE_LEN
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/PC_in
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/PC_out
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/PC_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/REG_ADDR_WD
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/REG_DATA_WD
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/RT_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/cache_wr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/clk
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/flush
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_I10
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_I16
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_I18
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_I7
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_I8
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_RA
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_RB
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_RC
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_RT_addr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/in_ls_data
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/opcode
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/out_RT
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/out_RT_addr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/out_ls_addr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/out_ls_data
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/out_ls_wr_en
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/pc_s1
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/pc_s2
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/pc_s3
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/pc_s4
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/pc_s5
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/repc_lb32_I10
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/repc_lb32_I16
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/result
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/result_temp
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s1_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_addr_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s1_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_data_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s1_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_idx_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s1_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s2_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s3_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s4_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s5_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s6_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rf_s7_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rst
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rt_wr_en
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/rt_wr_en_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_odd_pipe/unit_idx
add wave -noupdate -divider Decode
add wave -noupdate /spu_tb/u_spu_top/u_decode/EVEN
add wave -noupdate /spu_tb/u_spu_top/u_decode/ODD
add wave -noupdate /spu_tb/u_spu_top/u_decode/clk
add wave -noupdate /spu_tb/u_spu_top/u_decode/dec_stall
add wave -noupdate /spu_tb/u_spu_top/u_decode/dep_stall
add wave -noupdate -radix decimal /spu_tb/u_spu_top/u_fetch/pc
add wave -noupdate /spu_tb/u_spu_top/u_decode/stall_done
add wave -noupdate /spu_tb/u_spu_top/u_decode/eins1
add wave -noupdate /spu_tb/u_spu_top/u_decode/eins2
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc1_11b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc1_4b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc1_7b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc1_8b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc1_9b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc2_11b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc2_4b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc2_7b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc2_8b
add wave -noupdate /spu_tb/u_spu_top/u_decode/eoc2_9b
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I10_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I10_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I10e
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I10o
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I16_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I16_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I16e
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I16o
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I18_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I18_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I18e
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I18o
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I7_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I7_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I7e
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I7o
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I8_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I8_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I8e
add wave -noupdate /spu_tb/u_spu_top/u_decode/in_I8o
add wave -noupdate /spu_tb/u_spu_top/u_decode/ins1_type
add wave -noupdate /spu_tb/u_spu_top/u_decode/ins2_type
add wave -noupdate /spu_tb/u_spu_top/u_decode/opcode_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/opcode_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/opcode_ep
add wave -noupdate /spu_tb/u_spu_top/u_decode/opcode_op
add wave -noupdate /spu_tb/u_spu_top/u_decode/ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_decode/ra_addr_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/ra_addr_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_decode/rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_decode/rb_addr_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/rb_addr_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_decode/rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_decode/rc_addr_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/rc_addr_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_decode/rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_decode/rt_addr_i1
add wave -noupdate /spu_tb/u_spu_top/u_decode/rt_addr_i2
add wave -noupdate /spu_tb/u_spu_top/u_decode/rt_addr_op
add wave -noupdate -divider Dependency
add wave -noupdate /spu_tb/u_spu_top/u_dependency/clk
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I10_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I10_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I16_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I16_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I18_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I18_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I7_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I7_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I8_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/I8_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I10_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I10_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I16_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I16_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I18_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I18_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I7_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I7_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I8_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_I8_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_opcode_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_opcode_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dec_rt_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/dep_stall
add wave -noupdate /spu_tb/u_spu_top/u_dependency/flush
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat1
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat2
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat3
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat4
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat5
add wave -noupdate /spu_tb/u_spu_top/u_dependency/is_lat6
add wave -noupdate /spu_tb/u_spu_top/u_dependency/opcode_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/opcode_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s1_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s1_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_addr_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s1_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s1_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rf_idx_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_dependency/rt_addr_op
add wave -noupdate -divider {Even Pipe}
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/clk
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rst
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/opcode
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rt_wr_en_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_RA
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_RB
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_RC
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_I7
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_I8
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_I10
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_I16
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_I18
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/flush
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/in_RT_addr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s1_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_addr_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s1_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_idx_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/out_RT_addr
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/out_RT
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rt_wr_en
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_data_s1_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s1_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s2_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s3_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s4_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s5_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s6_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rf_s7_we
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/RT_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_byte_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/cnt_reg
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/unit_idx
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_fp
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_op1
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_op2
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_op3
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/temp_fpe
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rep_lb32_I16
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rep_lb16_I10
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rep_lb32_I10
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/result
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/operand
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rotate
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_even_pipe/rotate_temp
add wave -noupdate -divider {Reg File}
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/NUM_REGS
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/RADDR_WD
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/clk
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/ra_rd_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/ra_rd_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rb_rd_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rb_rd_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rc_rd_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rc_rd_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/reg_array
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rst
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_wr_en_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_wr_en_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_wr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_reg_file/rt_wr_op
add wave -noupdate -divider {FW Macro}
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/OPCODE_LEN
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/REG_DATA_WD
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/clk
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_data_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_data_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_fw_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/ra_fw_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_data_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_data_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_fw_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rb_fw_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_data_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_data_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_fw_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rc_fw_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_addr_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_data_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s2_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s2_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s3_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s3_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s4_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s4_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s5_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s5_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s6_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s6_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s7_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rf_idx_s7_op
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rst
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rt_addr_ep
add wave -noupdate /spu_tb/u_spu_top/u_spu_pipes_top/u_fw_macro/rt_addr_op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {405 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 321
configure wave -valuecolwidth 103
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {448 ns}