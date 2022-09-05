module upper_selector #(
    parameter integer n = 2 //2 or 3
) (
    //configuration
    input [3:0] configuration,

    //north output signals from macros
    input [9:0] north_o [0 : n-1],
    input [9:0] north_oe [0 : n-1],
    //selected output signal 
    output [9:0] north_o_selected,
    output [9:0] north_oe_selected

    //north inputs from pads
    // input [9:0] north_i [n-1 : 0] [n-1 : 0],
    // //buffered inputs to the macros
    // output [9:0] north_i_buf [n-1 : 0] [n-1 : 0]
);

logic [n-1 : 0] select; 

//mux selector logic
always_comb
    case(configuration)
        0: select = 0;
        1: select = 1;
        2: select = 0;
        3: select = 1;
        default: select = 0;
    endcase 

//mux
assign north_o_selected = north_o[select];
assign north_oe_selected = north_oe[select];

//outputs to be buffered
// genvar i, j;
// generate 
//     begin
//         for (i = 0; i < n; i = i+1)
//             for (j = 0; j < n; j = j+1)
//                 assign north_i_buf[i][j] = north_i[i][j];
//     end
// endgenerate
//
endmodule
