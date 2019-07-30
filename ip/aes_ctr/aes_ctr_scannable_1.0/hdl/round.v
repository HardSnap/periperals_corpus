/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* verilator lint_off UNOPTFLAT */

/* one AES round for every two clock cycles */
module one_round (clk, scan_input, scan_output, scan_ck_en, scan_enable, state_in, key, state_out);
input  scan_input;
output scan_output;
input  scan_ck_en;
input  scan_enable;
input              clk;
input      [127:0] state_in, key;
output reg [127:0] state_out;
wire       [31:0]  s0,  s1,  s2,  s3,
           z0,  z1,  z2,  z3,
           p00, p01, p02, p03,
           p10, p11, p12, p13,
           p20, p21, p22, p23,
           p30, p31, p32, p33,
           k0,  k1,  k2,  k3;

assign {k0, k1, k2, k3} = key;

assign {s0, s1, s2, s3} = state_in;

wire scan_output2;
wire scan_output3;
wire scan_output4;
wire scan_output5;

table_lookup
    t0 (clk, scan_input, scan_output2, scan_ck_en, scan_enable, s0, p00, p01, p02, p03),
    t1 (clk, scan_output2, scan_output3, scan_ck_en, scan_enable, s1, p10, p11, p12, p13),
    t2 (clk, scan_output3, scan_output4, scan_ck_en, scan_enable, s2, p20, p21, p22, p23),
    t3 (clk, scan_output4, scan_output5, scan_ck_en, scan_enable, s3, p30, p31, p32, p33);

assign z0 = p00 ^ p11 ^ p22 ^ p33 ^ k0;
assign z1 = p03 ^ p10 ^ p21 ^ p32 ^ k1;
assign z2 = p02 ^ p13 ^ p20 ^ p31 ^ k2;
assign z3 = p01 ^ p12 ^ p23 ^ p30 ^ k3;

assign scan_output = state_out[127];

always @ (posedge clk)
    if( scan_enable == 1'b1 )
    begin
      if( scan_ck_en == 1'b1 )
      begin
        state_out <= {state_out[126:0], scan_output5};
      end
    end else begin
    state_out <= {z0, z1, z2, z3};
    end
endmodule

/* AES final round for every two clock cycles */
module final_round (clk, scan_input, scan_output, scan_ck_en, scan_enable, state_in, key_in, state_out);
input  scan_input;
output scan_output;
input  scan_ck_en;
input  scan_enable;
input              clk;
input      [127:0] state_in;
input      [127:0] key_in;
output reg [127:0] state_out;
wire [31:0] s0,  s1,  s2,  s3,
     z0,  z1,  z2,  z3,
     k0,  k1,  k2,  k3;
wire [7:0]  p00, p01, p02, p03,
     p10, p11, p12, p13,
     p20, p21, p22, p23,
     p30, p31, p32, p33;

assign {k0, k1, k2, k3} = key_in;

assign {s0, s1, s2, s3} = state_in;

wire scan_output2;
wire scan_output3;
wire scan_output4;
wire scan_output5;

S4
    S4_1 (clk, scan_input, scan_output2, scan_ck_en, scan_enable, s0, {p00, p01, p02, p03}),
    S4_2 (clk, scan_output2, scan_output3, scan_ck_en, scan_enable, s1, {p10, p11, p12, p13}),
    S4_3 (clk, scan_output3, scan_output4, scan_ck_en, scan_enable, s2, {p20, p21, p22, p23}),
    S4_4 (clk, scan_output4, scan_output5, scan_ck_en, scan_enable, s3, {p30, p31, p32, p33});

assign z0 = {p00, p11, p22, p33} ^ k0;
assign z1 = {p10, p21, p32, p03} ^ k1;
assign z2 = {p20, p31, p02, p13} ^ k2;
assign z3 = {p30, p01, p12, p23} ^ k3;

assign scan_output = state_out[127];

always @ (posedge clk)
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
        state_out <= {state_out[126:0], scan_output5};
    end
  end else begin
  state_out <= {z0, z1, z2, z3};
  end
endmodule
