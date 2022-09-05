module chip_divider #(
    parameter integer n = 4 //2 or 3
) (
    //inputs
    input [9:0] north_o [3 : 0],
    input [9:0] north_oe [3 : 0],
    //west outputs on macros
    input [13:0] west_o [3 : 0],
    input [13:0] west_oe [3 : 0],
    //east
    input [13:0] east_o [3 : 0],
    input [13:0] east_oe [3 : 0],
    //
    input [3:0] configuration,
    //outputs
    output [13:0] IO_east_o,
    output [13:0] IO_east_oe,
    output [13:0] IO_west_o,
    output [13:0] IO_west_oe,
    output [9:0] IO_north_o,
    output [9:0] IO_north_oe 
);
//
logic [13:0] west_o_4, west_oe_4, east_o_4, east_oe_4;
logic [9:0] north_o_4, north_oe_4, north_o_5, north_oe_5;
//
logic [13:0] NC_1, NC_2, NC_5, NC_6;
logic [9:0] NC_3, NC_4;
//vertical selectors
vertical_selector #(.n(2), .position(0)) v_selector_0 (
    //inputs
    .configuration, 

    .north_o('{north_o[0], north_o[2]}),
    .north_oe('{north_oe[0], north_oe[2]}),

    .west_o('{west_o[0], west_o[2], west_o_4}),
    .west_oe('{west_oe[0], west_oe[2], west_oe_4}),

    .east_o('{14'd0, 14'd0, 14'd0}),
    .east_oe('{14'd0, 14'd0, 14'd0}),

    //outputs
    //North
    .north_o_selected(north_o_4),
    .north_oe_selected(north_oe_4),
    //West
    .west_o_selected(IO_west_o),
    .west_oe_selected(IO_west_oe),
    //East
    .east_o_selected(NC_1),
    .east_oe_selected(NC_2)

    );
vertical_selector #(.n(2), .position(1)) v_selector_1 (
    //inputs
    .configuration, 

    .north_o('{north_o[1], north_o[3]}),
    .north_oe('{north_oe[1], north_oe[3]}),

    .west_o('{west_o[1], west_o[3], 14'd0}),
    .west_oe('{west_oe[1], west_oe[3], 14'd0}),

    .east_o('{east_o[0], east_o[2], 14'd0}),
    .east_oe('{east_oe[0], east_oe[2], 14'd0}),

    //outputs
    //North
    .north_o_selected(north_o_5),
    .north_oe_selected(north_oe_5),
    //West
    .west_o_selected(west_o_4),
    .west_oe_selected(west_oe_4),
    //East
    .east_o_selected(east_o_4),
    .east_oe_selected(east_oe_4)

    );

vertical_selector #(.n(2), .position(2)) v_selector_2 (
    //inputs
    .configuration, 

    .north_o('{14'd0, 14'd0}),
    .north_oe('{14'd0, 14'd0}),

    .west_o('{14'd0, 14'd0, 14'd0}),
    .west_oe('{14'd0, 14'd0, 14'd0}),

    .east_o('{east_o[1], east_o[3], east_o_4}),
    .east_oe('{east_oe[1], east_oe[3], east_oe_4}),

    //outputs
    //North
    .north_o_selected(NC_3),
    .north_oe_selected(NC_4),
    //West
    .west_o_selected(NC_5),
    .west_oe_selected(NC_6),
    //East
    .east_o_selected(IO_east_o),
    .east_oe_selected(IO_east_oe)

    );

//upper selector
upper_selector #(.n(2)) u_selector
(
    .configuration,
    //north output signals from macros
    .north_o('{north_o_4, north_o_5}),
    .north_oe('{north_oe_4, north_oe_5}),
    //selected output signal 
    .north_o_selected(IO_north_o),
    .north_oe_selected(IO_north_oe)
);
endmodule
