module vertical_selector #(
    parameter integer n = 2, //2 or 3
    parameter integer position = 0 //0, 1, 2 or 3
) (
    //configuration
    input [3:0] configuration,

    //north outputs on macros
    input [9:0] north_o [0 : n-1],
    input [9:0] north_oe [0 : n-1],
    //west outputs on macros
    input [13:0] west_o [0 : n],
    input [13:0] west_oe [0 : n],
    //east
    input [13:0] east_o [0 : n],
    input [13:0] east_oe [0 : n],

    //selected output signals 
    output [9:0] north_o_selected,
    output [9:0] north_oe_selected,
    output [13:0] west_o_selected,
    output [13:0] west_oe_selected,
    output [13:0] east_o_selected,
    output [13:0] east_oe_selected

    //north inputs from pads
    // input [9:0] north_i [n-1 : 0] [n-1 : 0],
    // //buffered inputs to the macros
    // output [9:0] north_i_buf [n-1 : 0] [n-1 : 0]
);
//
logic [n-1 : 0] select; 
//
generate
    if(n == 2)
        case(position)
        0:
            always_comb
                case(configuration)
                    0: select = 0;
                    1: select = 2;
                    2: select = 1;
                    3: select = 2;
                    default: select = 0;
                endcase
        1:
            always_comb
            case(configuration)
                0: select = 0;
                1: select = 0;
                2: select = 1;
                3: select = 1;
                default: select = 0;
            endcase 
        2: 
            always_comb
            case(configuration)
                0: select = 2;
                1: select = 0;
                2: select = 2;
                3: select = 1;
                default: select = 0;
            endcase
        endcase
    // else if (n == 3)
    //     always_comb
    //         case(configuration)
    //             0: select = 0;
    //             1: select = 0;
    //             2: select = 0;
    //             3: select = 1;
    //             4: select = 1;
    //             5: select = 1;
    //             6: select = 2;
    //             7: select = 2;
    //             8: select = 2;
    //             default: assign select = 0;
    //         endcase
endgenerate
//
assign west_o_selected = west_o[select];
assign west_oe_selected = west_oe[select];
assign east_o_selected = east_o[select];
assign east_oe_selected = east_oe[select];
//
assign north_o_selected = north_o[select[0]];
assign north_oe_selected = north_oe[select[0]];
//
endmodule
