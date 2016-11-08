module adder
(
    input wire clk,
    input wire rst,
    input wire [11:0] in_a,
    input wire [11:0] in_b,
    
    output reg [11:0] out
);

always @ (posedge clk or negedge rst)
begin
    if (!rst) out <= 10'd0;
    else out <= in_a + in_b;
end

endmodule