    /* substitue four bytes in a word */
    module S4 (clk, in, out);
input clk;
input [31:0] in;
output [31:0] out;

S   
    S_0 (clk, in[31:24], out[31:24]),
    S_1 (clk, in[23:16], out[23:16]),
    S_2 (clk, in[15:8],  out[15:8] ),
    S_3 (clk, in[7:0],   out[7:0]  );
endmodule

