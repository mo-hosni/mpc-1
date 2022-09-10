module v_line_0
(
    //configuration
    input [2:0] select,

    //north outputs on macros
    input [9:0] north_o_0,
    input [9:0] north_oe_0, 
    //west outputs on macros
    input [13:0] west_o_0, west_o_1, west_o_2,
    input [13:0] west_oe_0, west_oe_1, west_oe_2,
    //east
    input [13:0] east_o_0, east_o_1, east_o_2,
    input [13:0] east_oe_0, east_oe_1, east_oe_2,

    //selected output signals 
    output [9:0] north_o_buf,
    output [9:0] north_oe_buf,
    output reg [13:0] west_o_selected,
    output reg [13:0] west_oe_selected,
    output reg [13:0] east_o_selected,
    output reg [13:0] east_oe_selected,

    //inputs to buffer
    input [9:0] north_i_0,
    input [13:0] east_i_0,
    input [13:0] west_i_0,
    //buffered inputs to the macros
    output [9:0] north_i_buf,
    output [13:0] east_i_buf_0, east_i_buf_1, east_i_buf_2,
    output [13:0] west_i_buf_0, west_i_buf_1, west_i_buf_2,

    //WB
    input wb_clk_i_0,
    input wb_rst_i_0,
    input wbs_stb_i_0,
    input wbs_cyc_i_0,
    input wbs_we_i_0,
    input [3:0] wbs_sel_i_0,
    input [31:0] wbs_dat_i_0,
    input [31:0] wbs_adr_i_0,
    //
    output wb_clk_i_buf,
    output wb_rst_i_buf,
    output wbs_stb_i_buf,
    output wbs_cyc_i_buf,
    output wbs_we_i_buf,
    output [3:0] wbs_sel_i_buf,
    output [31:0] wbs_dat_i_buf,
    output [31:0] wbs_adr_i_buf,
    //
    input wbs_ack_o_0,
    input [31:0] wbs_dat_o_0,
    //
    output wbs_ack_o_buf,
    output [31:0] wbs_dat_o_buf
);
//
//mux select logic. The logic changes with the position of the vertical line
//muxes
always @(*) begin
    case(select)
        0: west_o_selected = west_o_0;
        1: west_o_selected = west_o_1;
        2: west_o_selected = west_o_2;
        default: west_o_selected = west_o_0;
    endcase
end
always @(*) begin
    case(select)
        0: west_oe_selected = west_oe_0;
        1: west_oe_selected = west_oe_1;
        2: west_oe_selected = west_oe_2;
        default: west_oe_selected = west_oe_0;
    endcase
end
always @(*) begin
    case(select)
        0: east_o_selected = east_o_0;
        1: east_o_selected = east_o_1;
        2: east_o_selected = east_o_2;
        default: east_o_selected = east_o_0;
    endcase
end
always @(*) begin
    case(select)
        0: east_oe_selected = east_oe_0;
        1: east_oe_selected = east_oe_1;
        2: east_oe_selected = east_oe_2;
        default: east_oe_selected = east_oe_0;
    endcase
end
//
assign north_o_buf = north_o_0;
assign north_oe_buf = north_oe_0;
//
assign north_i_buf = north_i_0;
//
assign east_i_buf_0 = east_i_0;
assign east_i_buf_1 = east_i_0;
assign east_i_buf_2 = east_i_0;
//
assign west_i_buf_0 = west_i_0;
assign west_i_buf_1 = west_i_0;
assign west_i_buf_2 = west_i_0;
//WB forwawrding
assign wb_clk_i_buf = wb_clk_i_0;
assign wb_rst_i_buf = wb_rst_i_0;
assign wbs_stb_i_buf = wbs_stb_i_0;
assign wbs_cyc_i_buf = wbs_cyc_i_0;
assign wbs_we_i_buf = wbs_we_i_0;
assign wbs_sel_i_buf = wbs_sel_i_0;
assign wbs_dat_i_buf = wbs_dat_i_0;
assign wbs_adr_i_buf = wbs_adr_i_0;
//
assign wbs_ack_o_buf = wbs_ack_o_0;
assign wbs_dat_o_buf = wbs_dat_o_0;
//
endmodule