module chip_divider_tb #(
    parameter integer n = 4 //2 or 3
) ();
//
logic [13:0] IO_east_o;
logic [13:0] IO_east_oe;
logic [13:0] IO_west_o;
logic [13:0] IO_west_oe;
logic [9:0] IO_north_o;
logic [9:0] IO_north_oe; 
logic [3:0] configuration;
//
logic [9:0] north_o [3 : 0];
logic [9:0] north_oe [3 : 0];
//west outputs on macros
logic [13:0] west_o [3 : 0];
logic [13:0] west_oe [3 : 0];
//east
logic [13:0] east_o [3 : 0];
logic [13:0] east_oe [3 : 0];

//macros
macro #(0) macro_0 (.IO_east_o(east_o[0]), .IO_east_oe(east_oe[0]), .IO_west_o(west_o[0]), .IO_west_oe(west_oe[0]), .IO_north_o(north_o[0]), .IO_north_oe(north_oe[0]));
macro #(1) macro_1 (.IO_east_o(east_o[1]), .IO_east_oe(east_oe[1]), .IO_west_o(west_o[1]), .IO_west_oe(west_oe[1]), .IO_north_o(north_o[1]), .IO_north_oe(north_oe[1]));
macro #(2) macro_2 (.IO_east_o(east_o[2]), .IO_east_oe(east_oe[2]), .IO_west_o(west_o[2]), .IO_west_oe(west_oe[2]), .IO_north_o(north_o[2]), .IO_north_oe(north_oe[2]));
macro #(3) macro_3 (.IO_east_o(east_o[3]), .IO_east_oe(east_oe[3]), .IO_west_o(west_o[3]), .IO_west_oe(west_oe[3]), .IO_north_o(north_o[3]), .IO_north_oe(north_oe[3]));
//
chip_divider #(.n(4)) dut
(
    //inputs
    .configuration,
    .north_o,
    .north_oe,
    .west_o,
    .west_oe,
    .east_o,
    .east_oe,
    //outputs
    .IO_east_o,
    .IO_east_oe,
    .IO_west_o,
    .IO_west_oe,
    .IO_north_o,
    .IO_north_oe
);
//
initial begin
    configuration = 0;
    forever begin
        #10 configuration = configuration + 1;
    end      
end
//
endmodule
