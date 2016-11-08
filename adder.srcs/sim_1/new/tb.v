`timescale 1ns/1ps
module tb();

initial begin
  $dumpfile("out.vcd");
  $dumpvars;
end

localparam CLK_PERIOD = 10;
localparam RST_PERIOD = 23;
localparam RUN_PERIOD = 20*CLK_PERIOD;

//clock
reg clk = 1'b0;
always # (CLK_PERIOD/2) clk = ~clk;

//reset
reg rst;
initial
begin
    #0 rst = 1'b0;
    #RST_PERIOD rst = 1'b1;
end

//finish
initial #RUN_PERIOD $finish();

reg [2:0] count;
initial
begin
    count = 0;
    forever #40 count = count + 1;
end

//in_a, in_b
reg [11:0] in_a_buffer[0:4];
reg [11:0] in_b_buffer[0:4];

initial
begin
    $readmemh("/home/tju2/adder/adder.sim.data/in_a.txt",in_a_buffer);
    $readmemh("/home/tju2/adder/adder.sim.data/in_b.txt",in_b_buffer);
end

wire [11:0] in_a;
wire [11:0] in_b;

assign in_a = in_a_buffer[count];
assign in_b = in_b_buffer[count];

wire [11:0] out;

adder adder
    (.clk(clk),
     .rst(rst),
     .in_a(in_a),
     .in_b(in_b),
     .out(out));


endmodule