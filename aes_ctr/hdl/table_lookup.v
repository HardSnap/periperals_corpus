module table_lookup (clk, state, p0, p1, p2, p3);
input clk;
input [31:0] state;
output [31:0] p0, p1, p2, p3;
wire [7:0] b0, b1, b2, b3;

assign {b0, b1, b2, b3} = state;
T   
    t0 (clk, b0, {p0[23:0], p0[31:24]}),
    t1 (clk, b1, {p1[15:0], p1[31:16]}),
    t2 (clk, b2, {p2[7:0],  p2[31:8]} ),
    t3 (clk, b3, p3);
endmodule
