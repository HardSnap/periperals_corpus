    /* expand k0,k1,k4,k5 for every two clock cycles */
    module expand_key_type_C_192 (clk, in, rcon, out_1, out_2);
input              clk;
input      [191:0] in;
input      [7:0]   rcon;
output reg [191:0] out_1;
output     [127:0] out_2;
wire       [31:0]  k0, k1, k2, k3, k4, k5,
           v4, v5, v0, v1;
reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a;
wire       [31:0]  k0b, k1b, k2b, k3b, k4b, k5b, k6a;

assign {k0, k1, k2, k3, k4, k5} = in;

assign v4 = k3 ^ k4;
assign v5 = v4 ^ k5;
assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
assign v1 = v0 ^ k1;

always @ (posedge clk)
    {k0a, k1a, k2a, k3a, k4a, k5a} <= {v0, v1, k2, k3, v4, v5};

S4
    S4_0 (clk, {v5[23:0], v5[31:24]}, k6a);

assign k0b = k0a ^ k6a;
assign k1b = k1a ^ k6a;
assign {k2b, k3b, k4b, k5b} = {k2a, k3a, k4a, k5a};

always @ (posedge clk)
    out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b};

assign out_2 = {k4b, k5b, k0b, k1b};
endmodule


