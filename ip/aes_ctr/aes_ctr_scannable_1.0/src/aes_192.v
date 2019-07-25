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

module aes_192 (clk, scan_input, scan_output, scan_ck_en, scan_enable, start, state, key, out, out_valid);
output scan_output;
input scan_input;
input scan_ck_en;
input scan_enable;
input          clk;
input          start;
input  [127:0] state;
input  [191:0] key;
output [127:0] out;
output         out_valid;
reg    [127:0] s0;
reg    [191:0] k0;
wire   [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
wire   [191:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11;
wire   [127:0] k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b, k8b, k9b, k10b, k11b;

assign scan_output = start_r;

reg start_r;
always @(posedge clk)
    begin
      if( scan_enable == 1'b1 )
      begin
        if( scan_ck_en == 1'b1 )
        begin
          start_r <= s0[127];
        end
      end else begin
      start_r <= start;
      end
    end

wire start_posedge = start & ~start_r;
reg [4:0] validCounter;

wire scan_output1;
wire scan_output2;
wire scan_output3;
wire scan_output4;
wire scan_output5;
wire scan_output6;
wire scan_output7;
wire scan_output8;
wire scan_output9;
wire scan_output10;
wire scan_output11;
wire scan_output12;
wire scan_output13;
wire scan_output14;
wire scan_output15;
wire scan_output16;
wire scan_output17;
wire scan_output18;
wire scan_output19;
wire scan_output20;
wire scan_output21;
wire scan_output22;
wire scan_output23;
wire scan_output24;

always @ (posedge clk)
begin
    if( scan_enable == 1'b1 )
    begin
      if( scan_ck_en == 1'b1 )
      begin
        s0 <= {s0[126:0], k0[191]};
        k0 <= {k0[190:0], validCounter[4]};
        validCounter[4] <= {validCounter[3:0], scan_output24};
      end
    end else begin
      if(start_posedge)
        begin
            s0 <= state ^ key[191:64];
            k0 <= key;
            validCounter <= 25;
        end
      else if(~out_valid)
      begin
          validCounter <= validCounter - 1;
      end
    end
end

assign out_valid = (validCounter == 0);

expand_key_type_D_192  a0 (clk, scan_input,   scan_output1, scan_ck_en, scan_enable, k0, 8'h1,   k1,  k0b);
expand_key_type_B_192  a1 (clk, scan_output1,  scan_output2, scan_ck_en, scan_enable, k1,         k2,  k1b);
expand_key_type_A_192  a2 (clk, scan_output2,  scan_output3, scan_ck_en, scan_enable, k2, 8'h2,   k3,  k2b);
expand_key_type_C_192  a3 (clk, scan_output3,  scan_output4, scan_ck_en, scan_enable, k3, 8'h4,   k4,  k3b);
expand_key_type_B_192  a4 (clk, scan_output4,  scan_output5, scan_ck_en, scan_enable, k4,         k5,  k4b);
expand_key_type_A_192  a5 (clk, scan_output5,  scan_output6, scan_ck_en, scan_enable, k5, 8'h8,   k6,  k5b);
expand_key_type_C_192  a6 (clk, scan_output6,  scan_output7, scan_ck_en, scan_enable, k6, 8'h10,  k7,  k6b);
expand_key_type_B_192  a7 (clk, scan_output7,  scan_output8, scan_ck_en, scan_enable, k7,         k8,  k7b);
expand_key_type_A_192  a8 (clk, scan_output8,  scan_output9, scan_ck_en, scan_enable, k8, 8'h20,  k9,  k8b);
expand_key_type_C_192  a9 (clk, scan_output9,  scan_output10, scan_ck_en, scan_enable, k9, 8'h40, k10,  k9b);
expand_key_type_B_192 a10 (clk, scan_output10, scan_output11, scan_ck_en, scan_enable, k10,        k11, k10b);
expand_key_type_A_192 a11 (clk, scan_output11, scan_output12, scan_ck_en, scan_enable, k11, 8'h80,    , k11b);

one_round
    r1 (clk, scan_output12, scan_output13, scan_ck_en, scan_enable, s0, k0b, s1),
    r2 (clk, scan_output13, scan_output14, scan_ck_en, scan_enable, s1, k1b, s2),
    r3 (clk, scan_output14, scan_output15, scan_ck_en, scan_enable, s2, k2b, s3),
    r4 (clk, scan_output15, scan_output16, scan_ck_en, scan_enable, s3, k3b, s4),
    r5 (clk, scan_output16, scan_output17, scan_ck_en, scan_enable, s4, k4b, s5),
    r6 (clk, scan_output17, scan_output18, scan_ck_en, scan_enable, s5, k5b, s6),
    r7 (clk, scan_output18, scan_output19, scan_ck_en, scan_enable, s6, k6b, s7),
    r8 (clk, scan_output19, scan_output20, scan_ck_en, scan_enable, s7, k7b, s8),
    r9 (clk, scan_output20, scan_output21, scan_ck_en, scan_enable, s8, k8b, s9),
    r10 (clk, scan_output21, scan_output22, scan_ck_en, scan_enable, s9, k9b, s10),
    r11 (clk, scan_output22, scan_output23, scan_ck_en, scan_enable, s10, k10b, s11);

final_round
    rf (clk, scan_output23, scan_output24, scan_ck_en, scan_enable, s11, k11b, out);
endmodule

/* expand k0,k1,k2,k3 for every two clock cycles */
module expand_key_type_A_192 (clk, scan_input, scan_output, scan_ck_en, scan_enable, in, rcon, out_1, out_2);
output scan_output;
input scan_input;
input scan_ck_en;
input scan_enable;
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

assign scan_output = k0a[31];

wire scan_output2;

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      k0a <= {k0a[30:0], k1a[31]};
      k1a <= {k1a[30:0], k2a[31]};
      k2a <= {k2a[30:0], k3a[31]};
      k3a <= {k3a[30:0], k4a[31]};
      k4a <= {k4a[30:0], k5a[31]};
      k5a <= {k5a[30:0], out_1[191]};
    end
  end else begin
      {k0a, k1a, k2a, k3a, k4a, k5a} <= {v0, v1, v2, v3, k4, k5};
  end
end

S4 S4_0 (clk, scan_input, scan_output2, scan_ck_en, scan_enable, {k5[23:0], k5[31:24]}, k6a);

assign k0b = k0a ^ k6a;
assign k1b = k1a ^ k6a;
assign k2b = k2a ^ k6a;
assign k3b = k3a ^ k6a;
assign {k4b, k5b} = {k4a, k5a};

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      out_1 <= {out_1[190:0], scan_output2};
    end
  end else begin
    out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b};
  end
end

assign out_2 = {k0b, k1b, k2b, k3b};
endmodule

/* expand k2,k3,k4,k5 for every two clock cycles */
module expand_key_type_B_192 (clk, scan_input, scan_output, scan_ck_en, scan_enable, in, out_1, out_2);
output scan_output;
input scan_input;
input scan_ck_en;
input scan_enable;
input              clk;
input      [191:0] in;
output reg [191:0] out_1;
output     [127:0] out_2;
wire       [31:0]  k0, k1, k2, k3, k4, k5,
           v2, v3, v4, v5;
reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a;

assign {k0, k1, k2, k3, k4, k5} = in;

assign v2 = k1 ^ k2;
assign v3 = v2 ^ k3;
assign v4 = v3 ^ k4;
assign v5 = v4 ^ k5;

assign scan_output = k0a[31];

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      k0a <= {k0a[30:0], k1a[31]};
      k1a <= {k1a[30:0], k2a[31]};
      k2a <= {k2a[30:0], k3a[31]};
      k3a <= {k3a[30:0], k4a[31]};
      k4a <= {k4a[30:0], k5a[31]};
      k5a <= {k5a[30:0], out_1[191]};
    end
  end else begin
    {k0a, k1a, k2a, k3a, k4a, k5a} <= {k0, k1, v2, v3, v4, v5};
  end
end

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      out_1 <= {out_1[190:0], scan_input};
    end
  end else begin
    out_1 <= {k0a, k1a, k2a, k3a, k4a, k5a};
  end
end

assign out_2 = {k2a, k3a, k4a, k5a};
endmodule

/* expand k0,k1,k4,k5 for every two clock cycles */
module expand_key_type_C_192 (clk, scan_input, scan_output, scan_ck_en, scan_enable, in, rcon, out_1, out_2);
output scan_output;
input scan_input;
input scan_ck_en;
input scan_enable;
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

wire scan_output2;
assign scan_output = k0a[31];

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      k0a <= {k0a[30:0], k1a[31]};
      k1a <= {k1a[30:0], k2a[31]};
      k2a <= {k2a[30:0], k3a[31]};
      k3a <= {k3a[30:0], k4a[31]};
      k4a <= {k4a[30:0], k5a[31]};
      k5a <= {k5a[30:0], out_1[191]};
    end
  end else begin
    {k0a, k1a, k2a, k3a, k4a, k5a} <= {v0, v1, k2, k3, v4, v5};
  end
end

S4 S4_0 (clk, scan_input, scan_output2, scan_ck_en, scan_enable, {v5[23:0], v5[31:24]}, k6a);

assign k0b = k0a ^ k6a;
assign k1b = k1a ^ k6a;
assign {k2b, k3b, k4b, k5b} = {k2a, k3a, k4a, k5a};

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      out_1 <= {out_1[190:0], scan_output2};
    end
  end else begin
    out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b};
  end
end

assign out_2 = {k4b, k5b, k0b, k1b};
endmodule

/* expand k0,k1 for every two clock cycles */
module expand_key_type_D_192 (clk, scan_input, scan_output, scan_ck_en, scan_enable, in, rcon, out_1, out_2);
output scan_output;
input scan_input;
input scan_ck_en;
input scan_enable;
input              clk;
input      [191:0] in;
input      [7:0]   rcon;
output reg [191:0] out_1;
output     [127:0] out_2;
wire       [31:0]  k0, k1, k2, k3, k4, k5,
           v0, v1;
reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a;
wire       [31:0]  k0b, k1b, k2b, k3b, k4b, k5b, k6a;

assign {k0, k1, k2, k3, k4, k5} = in;

assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
assign v1 = v0 ^ k1;

wire scan_output2;
assign scan_output = k0a[31];

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      k0a <= {k0a[30:0], k1a[31]};
      k1a <= {k1a[30:0], k2a[31]};
      k2a <= {k2a[30:0], k3a[31]};
      k3a <= {k3a[30:0], k4a[31]};
      k4a <= {k4a[30:0], k5a[31]};
      k5a <= {k5a[30:0], out_1[191]};
    end
  end else begin
    {k0a, k1a, k2a, k3a, k4a, k5a} <= {v0, v1, k2, k3, k4, k5};
  end
end

S4 S4_0 (clk, scan_input, scan_output2, scan_ck_en, scan_enable, {k5[23:0], k5[31:24]}, k6a);

assign k0b = k0a ^ k6a;
assign k1b = k1a ^ k6a;
assign {k2b, k3b, k4b, k5b} = {k2a, k3a, k4a, k5a};

always @ (posedge clk)
begin
  if( scan_enable == 1'b1 )
  begin
    if( scan_ck_en == 1'b1 )
    begin
      out_1 <= {out_1[190:0], scan_output2};
    end
  end else begin
    out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b};
  end
end

assign out_2 = {k4b, k5b, k0b, k1b};
endmodule
