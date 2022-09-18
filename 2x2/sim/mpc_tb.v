module mpc_tb  ();
//
wire [13:0] IO_east_o, IO_east_oe;
reg [13:0] IO_east_i;
wire [13:0] IO_west_o, IO_west_oe; 
reg [13:0] IO_west_i;
wire [9:0] IO_north_o, IO_north_oe;
reg [9:0] IO_north_i;
reg [1:0] configuration;
//WB
reg wb_clk_i;
reg wb_rst_i;
reg wbs_stb_i;
reg wbs_cyc_i;
reg wbs_we_i;
reg [3:0] wbs_sel_i;
reg [31:0] wbs_dat_i;
reg [31:0] wbs_adr_i;
wire wbs_ack_o;
wire [31:0] wbs_dat_o;
//
mpc dut
(
    //inputs
    .configuration,
    //outputs
    .IO_east_o,
    .IO_east_oe,
    .IO_west_o,
    .IO_west_oe,
    .IO_north_o,
    .IO_north_oe,
    //inputs
    .IO_north_i,
    .IO_east_i,
    .IO_west_i,
    //WB
    .wb_clk_i,
    .wb_rst_i,
    .wbs_stb_i,
    .wbs_cyc_i,
    .wbs_we_i,
    .wbs_sel_i,
    .wbs_dat_i,
    .wbs_adr_i,
    //
    .wbs_ack_o,
    .wbs_dat_o
    //
    );
//
initial begin
    configuration = 0;
    forever begin
        #10 configuration = configuration + 1;
        $display(configuration);
    end      
end
initial begin
    wb_clk_i = 0;
    forever begin
        #5 wb_clk_i = ~wb_clk_i;
    end      
end
initial begin
    wb_rst_i = 1;
    #5 wb_rst_i = 0;
end
//
initial begin
    IO_north_i = 10'd25;
    IO_east_i = 10'd30;
    IO_west_i = 10'd35;
    wbs_stb_i = 0;
    wbs_cyc_i = 0;
    wbs_we_i = 1;
    wbs_sel_i = 4'd10;
    wbs_dat_i = 32'd20;
    wbs_adr_i = 32'd30;
end
initial
    #60 $finish;
//
initial begin
    $dumpfile("mpc_tb.vcd");
    $dumpvars();
end
endmodule