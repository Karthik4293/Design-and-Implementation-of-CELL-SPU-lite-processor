// ------------------------------------------//
// Matrix Vector Multiplier Defines Part-1
// ------------------------------------------//
// NAME:  Atif Iqbal
// NETID: aahangar
// SBUID: 111416569
//
// NAME: Karthik Raj
// NETID: ?
// SBUID: ?
// ------------------------------------------//

package defines_pkg;

    parameter NUM_INS = 100;
    parameter EVENINSFILE = "even_ins_file.txt";
    parameter ODDINSFILE  = "odd_ins_file.txt";
    parameter LSLOADFILE  = "ls_load_file.txt";

    parameter BYTE       =   8;
    parameter HALFWORD   =  16;
    parameter WORD       =  32;
    parameter DOUBLEWORD =  64;
    parameter QUADWORD   = 128;

    parameter LS_SIZE    = 32000;

    shortreal S_MAX = $bitstoshortreal(32'h7fffffff);
    shortreal S_MIN = $bitstoshortreal(32'h00800000);

    typedef enum logic [10:0] {  //Simple Fixed Instructions
                                 IMMEDIATE_LOAD_HALFWORD                   = 11'b00010000011,
                                 IMMEDIATE_LOAD_WORD                       = 11'b00010000001,
                                 IMMEDIATE_LOAD_ADDRESS                    = 11'b00000100001,
                                 ADD_HALF_WORD                             = 11'b00011001000,
                                 ADD_HALF_WORD_IMMEDIATE                   = 11'b00000011101,
                                 ADD_WORD                                  = 11'b00011000000,
                                 ADD_WORD_IMMEDIATE                        = 11'b00000011100,
                                 SUBTRACT_FROM_HALFWORD                    = 11'b00001001000,
                                 SUBTRACT_FROM_HALFWORD_IMMEDIATE          = 11'b00000001101,
                                 SUBTRACT_FROM_WORD                        = 11'b00001000000,
                                 SUBTRACT_FROM_WORD_IMMEDIATE              = 11'b00000001100,
                                 ADD_EXTENDED                              = 11'b01101000000,
                                 SUBTRACT_FROM_EXTENDED                    = 11'b01101000001,
                                 CARRY_GENERATE                            = 11'b00011000010,
                                 BORROW_GENERATE                           = 11'b00001000010,
                                 COUNT_LEADING_ZEROS                       = 11'b01010100101,
                                 AND                                       = 11'b00011000001,
                                 AND_WORD_IMMEDIATE                        = 11'b00000010100,
                                 AND_HALFWORD_IMMEDIATE                    = 11'b00000010101,
                                 AND_BYTE_IMMEDIATE                        = 11'b00000010110,
                                 OR                                        = 11'b00001000001,
                                 OR_WORD_IMMEDIATE                         = 11'b00000000100,
                                 OR_HALFWORD_IMMEDIATE                     = 11'b00000000101,
                                 OR_BYTE_IMMEDIATE                         = 11'b00000000110,
                                 EXCLUSIVE_OR                              = 11'b01001000001,
                                 EXCLUSIVE_OR_WORD_IMMEDIATE               = 11'b00001000100,
                                 EXCLUSIVE_OR_HALFWORD_IMMEDIATE           = 11'b00001000101,
                                 EXCLUSIVE_OR_BYTE_IMMEDIATE               = 11'b00001000110,
                                 NAND                                      = 11'b00011001001,
                                 NOR                                       = 11'b00001001001,
                                 EQUIVALENT                                = 11'b01001001001,
                                 COMPARE_EQUAL_WORD                        = 11'b01111000000,
                                 COMPARE_EQUAL_WORD_IMMEDIATE              = 11'b00001111100,
                                 COMPARE_EQUAL_HALFWORD                    = 11'b01111001000,
                                 COMPARE_EQUAL_HALFWORD_IMMEDIATE          = 11'b00001111101,
                                 COMPARE_GREATER_THAN_WORD                 = 11'b01001000000,
                                 COMPARE_GREATER_THAN_WORD_IMMEDIATE       = 11'b00001001100,
                                 COMPARE_GREATER_THAN_HALFWORD             = 11'b01001001000,
                                 COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE   = 11'b00001001101,
                                 //Single Precision Unit
                                 MULTIPLY                                  = 11'b01111000100,
                                 MULTIPLY_IMMEDIATE                        = 11'b00001110100,
                                 MULTIPLY_AND_ADD                          = 11'b10000001100, //TODO: added one in MSB.
                                 FLOATING_ADD                              = 11'b01011000100,
                                 FLOATING_SUBTRACT                         = 11'b01011000101,
                                 FLOATING_MULTIPLY                         = 11'b01011000110,
                                 FLOATING_MULTIPLY_AND_ADD                 = 11'b00000001110,
                                 FLOATING_MULTIPLY_AND_SUBTRACT            = 11'b00000001111,
                                 FLOATING_COMPARE_EQUAL                    = 11'b01111000010,
                                 FLOATING_COMPARE_MAGNITUDE_EQUAL          = 11'b01111001010,
                                 FLOATING_COMPARE_GREATER_THAN             = 11'b01011000010,
                                 FLOATING_COMPARE_MAGNITUDE_GREATER_THAN   = 11'b01011001010,
                                 //Byte Unit
                                 COUNT_ONES_IN_BYTES                       = 11'b01010110100,
                                 AVERAGE_BYTES                             = 11'b00011010011,
                                 ABSOLUTE_DIFFERENCE_OF_BYTES              = 11'b00001010011,
                                 SUM_BYTES_INTO_HALFWORDS                  = 11'b01001010011,
                                 //Shift and Rotate
                                 SHIFT_LEFT_HALFWORD                       = 11'b00001011111,
                                 SHIFT_LEFT_HALFWORD_IMMEDIATE             = 11'b00001111111,
                                 SHIFT_LEFT_WORD                           = 11'b00001011011,
                                 SHIFT_LEFT_WORD_IMMEDIATE                 = 11'b00001111011,
                                 SHIFT_LEFT_QUADWORD_BY_BITS               = 11'b00111011011,
                                 SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE     = 11'b00111111011,
                                 SHIFT_LEFT_QUADWORD_BY_BYTES              = 11'b00111011111,
                                 SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE    = 11'b00111111111,
                                 ROTATE_WORD                               = 11'b00001011000,
                                 ROTATE_WORD_IMMEDIATE                     = 11'b00001111000,
                                 ROTATE_QUADWORD_BY_BITS                   = 11'b00111011000,
                                 ROTATE_QUADWORD_BY_BITS_IMMEDIATE         = 11'b00111111000,
                                 ROTATE_QUADWORD_BY_BYTES                  = 11'b00111011100,
                                 ROTATE_QUADWORD_BY_BYTES_IMMEDIATE        = 11'b00111111100,
                                 //Load Store Instructions
                                 LOAD_QUADWORD_DFORM                       = 11'b00000110100,
                                 LOAD_QUADWORD_AFORM                       = 11'b00001100001,
                                 STORE_QUADWORD_DFORM                      = 11'b00000100100,
                                 STORE_QUADWORD_AFORM                      = 11'b10001000001, //TODO: Added 1 in msb
                                 BRANCH_RELATIVE_AND_SET_LINK              = 11'b00001100110,
                                 BRANCH_ABSOLUTE_AND_SET_LINK              = 11'b00001100010,
                                 BRANCH_INDIRECT                           = 11'b00110101000,
                                 BRANCH_RELATIVE                           = 11'b00001100100,
                                 BRANCH_ABSOLUTE                           = 11'b00001100000,
                                 BRANCH_IF_NOT_ZERO_WORD                   = 11'b10001000010, //TODO: Added 1 in msb
                                 BRANCH_IF_ZERO_WORD                       = 11'b10001000000, //TODO: Added 1 in msb
                                 BRANCH_IF_NOT_ZERO_HALFWORD               = 11'b10001000110, //TODO: Added 1 in msb
                                 BRANCH_IF_ZERO_HALFWORD                   = 11'b10001000100, //TODO: Added 1 in msb
                                 //Control
                                 CMISS                                     = 11'b11111111111,
                                 LNOP                                      = 11'b00000000001,
                                 NOP                                       = 11'b01000000001,
                                 STOP                                      = 11'b00000000000
                              } Opcodes;

endpackage
