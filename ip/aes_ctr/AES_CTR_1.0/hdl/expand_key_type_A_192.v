    /* expand k0,k1,k2,k3 for every two clock cycles */
    module expand_key_type_A_192 (clk, in, rcon, out_1, out_2);
input              clk;
input      [191:0] in;
input      [7:0]   rcon;
output reg [191:0] out_1;
output     [127:0] out_2;
wire       [31:0]  k0, k1, k2, k3, k4, k5,
           v0, v1, v2, v3;
reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a;
wire       [31:0]  k0b, k1b, k2b, k3b, k4b, k5b, k6a;

assign {k0, k1, k2, k3, k4, k5} = in;

assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
assign v1 = v0 ^ k1;
assign v2 = v1 ^ k2;
assign v3 = v2 ^ k3;

always @ (posedge clk)
    {k0a, k1a, k2a, k3a, k4a, k5a} <= {v0, v1, v2, v3, k4, k5};

S4
    S4_0 (clk, {k5[23:0], k5[31:24]}, k6a);

assign k0b = k0a ^ k6a;
assign k1b = k1a ^ k6a;
assign k2b = k2a ^ k6a;
assign k3b = k3a ^ k6a;
assign {k4b, k5b} = {k4a, k5a};

always @ (posedge clk)
    out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b};

assign out_2 = {k0b, k1b, k2b, k3b};
endmodule

