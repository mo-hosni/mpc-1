module mpc #(
    parameter integer user_macros       = 4,
    parameter integer rows              = 2, //not used
    parameter integer columns           = 2, //not used
    //
    parameter integer cfg_bits          = $ceil($clog2(user_macros)),
    parameter integer chip_IOs_north    = 10,
    parameter integer chip_IOs_east     = 14,
    parameter integer chip_IOs_west     = 14,
    parameter integer WB_data_bits      = 32,
    parameter integer WB_addr_bits      = 32,
    parameter integer WB_select_bits    = 4
) (
    input  [cfg_bits - 1 : 0]       configuration, 
    ////////// IOs ///////////
    input  [chip_IOs_north - 1 : 0] IO_north_i,
    output [chip_IOs_north - 1 : 0] IO_north_o,
    output [chip_IOs_north - 1 : 0] IO_north_oe,
    //
    input  [chip_IOs_east - 1 : 0]  IO_east_i,
    output [chip_IOs_east - 1 : 0]  IO_east_o,
    output [chip_IOs_east - 1 : 0]  IO_east_oe,
    //
    input  [chip_IOs_west - 1 : 0]  IO_west_i,
    output [chip_IOs_west - 1 : 0]  IO_west_o,
    output [chip_IOs_west - 1 : 0]  IO_west_oe,    
    ////////// WB ///////////
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [WB_select_bits - 1 : 0]  wbs_sel_i,
    input [WB_data_bits   - 1 : 0]  wbs_dat_i,
    input [WB_addr_bits   - 1 : 0]  wbs_adr_i,
    output wbs_ack_o,
    output [WB_data_bits - 1 : 0]   wbs_dat_o
);
// IOs OUTPUTS FROM MACROS
wire [chip_IOs_north - 1 : 0]   macros_north_o  [user_macros - 1 : 0];
wire [chip_IOs_north - 1 : 0]   macros_north_oe [user_macros - 1 : 0];
//
wire [chip_IOs_east - 1 : 0]    macros_east_o   [user_macros - 1 : 0];
wire [chip_IOs_east - 1 : 0]    macros_east_oe  [user_macros - 1 : 0];
//
wire [chip_IOs_west - 1 : 0]    macros_west_o   [user_macros - 1 : 0];
wire [chip_IOs_west - 1 : 0]    macros_west_oe  [user_macros - 1 : 0];
//
// WB OUTPUTS FROM MACROS
wire                        macros_wbs_ack_o    [user_macros - 1 : 0];
wire [WB_data_bits - 1 : 0] macros_wbs_dat_o    [user_macros - 1 : 0];
//
// User macros instances should be here
genvar i;
generate 
        for(i = 0; i < user_macros; i = i + 1)
        begin
            macro #(i) macro (
                //WB
                .wb_clk_i   (wb_clk_i), 
                .wb_rst_i   (wb_rst_i), 
                .wbs_stb_i  (wbs_stb_i), 
                .wbs_cyc_i  (wbs_cyc_i), 
                .wbs_we_i   (wbs_we_i), 
                .wbs_sel_i  (wbs_sel_i), 
                .wbs_dat_i  (wbs_dat_i), 
                .wbs_adr_i  (wbs_adr_i), 
                .wbs_ack_o  (macros_wbs_ack_o[i]), 
                .wbs_dat_o  (macros_wbs_dat_o[i]),
                //IOs
                .IO_north_i, 
                .IO_east_i, 
                .IO_west_i, 
                .IO_east_o  (macros_east_o[i]), 
                .IO_east_oe (macros_east_oe[i]), 
                .IO_west_o  (macros_west_o[i]), 
                .IO_west_oe (macros_west_oe[i]), 
                .IO_north_o (macros_north_o[i]), 
                .IO_north_oe(macros_north_oe[i])
            );
        end
endgenerate 
//IOs selection
assign IO_north_o   = macros_north_o    [configuration];
assign IO_north_oe  = macros_north_oe   [configuration];
assign IO_east_o    = macros_east_o     [configuration];
assign IO_east_oe   = macros_east_oe    [configuration];
assign IO_west_o    = macros_west_o     [configuration];
assign IO_west_oe   = macros_west_oe    [configuration];
//WB outputs selection
assign wbs_ack_o    = macros_wbs_ack_o  [configuration];
assign wbs_dat_o    = macros_wbs_dat_o  [configuration];
//
endmodule