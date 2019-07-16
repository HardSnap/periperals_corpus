//======================================================================
//
// sha256_w_mem_regs.v
// -------------------
// The W memory. This version uses 16 32-bit registers as a sliding
// window to generate the 64 words.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2013, Secworks Sweden AB
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or
// without modification, are permitted provided that the following
// conditions are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module sha256_w_mem(
                    input wire           clk,
                    input wire           reset_n,

                    input  wire scan_input,
                    output wire scan_output,
                    input  wire scan_enable,
                    input  wire scan_ck_en,

                    input wire [511 : 0] block,

                    input wire           init,
                    input wire           next,
                    output wire [31 : 0] w
                   );


  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  parameter CTRL_IDLE   = 0;
  parameter CTRL_UPDATE = 1;


  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [31 : 0] w_mem [0 : 15];
  reg [31 : 0] w_mem00_new;
  reg [31 : 0] w_mem01_new;
  reg [31 : 0] w_mem02_new;
  reg [31 : 0] w_mem03_new;
  reg [31 : 0] w_mem04_new;
  reg [31 : 0] w_mem05_new;
  reg [31 : 0] w_mem06_new;
  reg [31 : 0] w_mem07_new;
  reg [31 : 0] w_mem08_new;
  reg [31 : 0] w_mem09_new;
  reg [31 : 0] w_mem10_new;
  reg [31 : 0] w_mem11_new;
  reg [31 : 0] w_mem12_new;
  reg [31 : 0] w_mem13_new;
  reg [31 : 0] w_mem14_new;
  reg [31 : 0] w_mem15_new;
  reg          w_mem_we;

  reg [5 : 0] w_ctr_reg;
  reg [5 : 0] w_ctr_new;
  reg         w_ctr_we;


  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  reg [31 : 0] w_tmp;
  reg [31 : 0] w_new;


  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign w = w_tmp;


  // Scan output
  reg my_scan_output;
  assign scan_output = w_mem[15][31];

  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with synchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk or negedge reset_n)
    begin : reg_update
      integer i;

      if (!reset_n)
        begin
          for (i = 0 ; i < 16 ; i = i + 1)
            w_mem[i] <= 32'h0;

          w_ctr_reg <= 6'h0;
          my_scan_output  <= 1'b0;
        end
      else
        begin
          if( scan_enable == 1'b1 )
          begin
              if( scan_ck_en == 1'b1 )
              begin
//my_scan_output <= w_mem[15][31];
w_mem[15][31] <= w_mem[15][30];
w_mem[15][30] <= w_mem[15][29];
w_mem[15][29] <= w_mem[15][28];
w_mem[15][28] <= w_mem[15][27];
w_mem[15][27] <= w_mem[15][26];
w_mem[15][26] <= w_mem[15][25];
w_mem[15][25] <= w_mem[15][24];
w_mem[15][24] <= w_mem[15][23];
w_mem[15][23] <= w_mem[15][22];
w_mem[15][22] <= w_mem[15][21];
w_mem[15][21] <= w_mem[15][20];
w_mem[15][20] <= w_mem[15][19];
w_mem[15][19] <= w_mem[15][18];
w_mem[15][18] <= w_mem[15][17];
w_mem[15][17] <= w_mem[15][16];
w_mem[15][16] <= w_mem[15][15];
w_mem[15][15] <= w_mem[15][14];
w_mem[15][14] <= w_mem[15][13];
w_mem[15][13] <= w_mem[15][12];
w_mem[15][12] <= w_mem[15][11];
w_mem[15][11] <= w_mem[15][10];
w_mem[15][10] <= w_mem[15][9];
w_mem[15][9] <= w_mem[15][8];
w_mem[15][8] <= w_mem[15][7];
w_mem[15][7] <= w_mem[15][6];
w_mem[15][6] <= w_mem[15][5];
w_mem[15][5] <= w_mem[15][4];
w_mem[15][4] <= w_mem[15][3];
w_mem[15][3] <= w_mem[15][2];
w_mem[15][2] <= w_mem[15][1];
w_mem[15][1] <= w_mem[15][0];
w_mem[15][0] <= w_mem[14][31];
w_mem[14][31] <= w_mem[14][30];
w_mem[14][30] <= w_mem[14][29];
w_mem[14][29] <= w_mem[14][28];
w_mem[14][28] <= w_mem[14][27];
w_mem[14][27] <= w_mem[14][26];
w_mem[14][26] <= w_mem[14][25];
w_mem[14][25] <= w_mem[14][24];
w_mem[14][24] <= w_mem[14][23];
w_mem[14][23] <= w_mem[14][22];
w_mem[14][22] <= w_mem[14][21];
w_mem[14][21] <= w_mem[14][20];
w_mem[14][20] <= w_mem[14][19];
w_mem[14][19] <= w_mem[14][18];
w_mem[14][18] <= w_mem[14][17];
w_mem[14][17] <= w_mem[14][16];
w_mem[14][16] <= w_mem[14][15];
w_mem[14][15] <= w_mem[14][14];
w_mem[14][14] <= w_mem[14][13];
w_mem[14][13] <= w_mem[14][12];
w_mem[14][12] <= w_mem[14][11];
w_mem[14][11] <= w_mem[14][10];
w_mem[14][10] <= w_mem[14][9];
w_mem[14][9] <= w_mem[14][8];
w_mem[14][8] <= w_mem[14][7];
w_mem[14][7] <= w_mem[14][6];
w_mem[14][6] <= w_mem[14][5];
w_mem[14][5] <= w_mem[14][4];
w_mem[14][4] <= w_mem[14][3];
w_mem[14][3] <= w_mem[14][2];
w_mem[14][2] <= w_mem[14][1];
w_mem[14][1] <= w_mem[14][0];
w_mem[14][0] <= w_mem[13][31];
w_mem[13][31] <= w_mem[13][30];
w_mem[13][30] <= w_mem[13][29];
w_mem[13][29] <= w_mem[13][28];
w_mem[13][28] <= w_mem[13][27];
w_mem[13][27] <= w_mem[13][26];
w_mem[13][26] <= w_mem[13][25];
w_mem[13][25] <= w_mem[13][24];
w_mem[13][24] <= w_mem[13][23];
w_mem[13][23] <= w_mem[13][22];
w_mem[13][22] <= w_mem[13][21];
w_mem[13][21] <= w_mem[13][20];
w_mem[13][20] <= w_mem[13][19];
w_mem[13][19] <= w_mem[13][18];
w_mem[13][18] <= w_mem[13][17];
w_mem[13][17] <= w_mem[13][16];
w_mem[13][16] <= w_mem[13][15];
w_mem[13][15] <= w_mem[13][14];
w_mem[13][14] <= w_mem[13][13];
w_mem[13][13] <= w_mem[13][12];
w_mem[13][12] <= w_mem[13][11];
w_mem[13][11] <= w_mem[13][10];
w_mem[13][10] <= w_mem[13][9];
w_mem[13][9] <= w_mem[13][8];
w_mem[13][8] <= w_mem[13][7];
w_mem[13][7] <= w_mem[13][6];
w_mem[13][6] <= w_mem[13][5];
w_mem[13][5] <= w_mem[13][4];
w_mem[13][4] <= w_mem[13][3];
w_mem[13][3] <= w_mem[13][2];
w_mem[13][2] <= w_mem[13][1];
w_mem[13][1] <= w_mem[13][0];
w_mem[13][0] <= w_mem[12][31];
w_mem[12][31] <= w_mem[12][30];
w_mem[12][30] <= w_mem[12][29];
w_mem[12][29] <= w_mem[12][28];
w_mem[12][28] <= w_mem[12][27];
w_mem[12][27] <= w_mem[12][26];
w_mem[12][26] <= w_mem[12][25];
w_mem[12][25] <= w_mem[12][24];
w_mem[12][24] <= w_mem[12][23];
w_mem[12][23] <= w_mem[12][22];
w_mem[12][22] <= w_mem[12][21];
w_mem[12][21] <= w_mem[12][20];
w_mem[12][20] <= w_mem[12][19];
w_mem[12][19] <= w_mem[12][18];
w_mem[12][18] <= w_mem[12][17];
w_mem[12][17] <= w_mem[12][16];
w_mem[12][16] <= w_mem[12][15];
w_mem[12][15] <= w_mem[12][14];
w_mem[12][14] <= w_mem[12][13];
w_mem[12][13] <= w_mem[12][12];
w_mem[12][12] <= w_mem[12][11];
w_mem[12][11] <= w_mem[12][10];
w_mem[12][10] <= w_mem[12][9];
w_mem[12][9] <= w_mem[12][8];
w_mem[12][8] <= w_mem[12][7];
w_mem[12][7] <= w_mem[12][6];
w_mem[12][6] <= w_mem[12][5];
w_mem[12][5] <= w_mem[12][4];
w_mem[12][4] <= w_mem[12][3];
w_mem[12][3] <= w_mem[12][2];
w_mem[12][2] <= w_mem[12][1];
w_mem[12][1] <= w_mem[12][0];
w_mem[12][0] <= w_mem[11][31];
w_mem[11][31] <= w_mem[11][30];
w_mem[11][30] <= w_mem[11][29];
w_mem[11][29] <= w_mem[11][28];
w_mem[11][28] <= w_mem[11][27];
w_mem[11][27] <= w_mem[11][26];
w_mem[11][26] <= w_mem[11][25];
w_mem[11][25] <= w_mem[11][24];
w_mem[11][24] <= w_mem[11][23];
w_mem[11][23] <= w_mem[11][22];
w_mem[11][22] <= w_mem[11][21];
w_mem[11][21] <= w_mem[11][20];
w_mem[11][20] <= w_mem[11][19];
w_mem[11][19] <= w_mem[11][18];
w_mem[11][18] <= w_mem[11][17];
w_mem[11][17] <= w_mem[11][16];
w_mem[11][16] <= w_mem[11][15];
w_mem[11][15] <= w_mem[11][14];
w_mem[11][14] <= w_mem[11][13];
w_mem[11][13] <= w_mem[11][12];
w_mem[11][12] <= w_mem[11][11];
w_mem[11][11] <= w_mem[11][10];
w_mem[11][10] <= w_mem[11][9];
w_mem[11][9] <= w_mem[11][8];
w_mem[11][8] <= w_mem[11][7];
w_mem[11][7] <= w_mem[11][6];
w_mem[11][6] <= w_mem[11][5];
w_mem[11][5] <= w_mem[11][4];
w_mem[11][4] <= w_mem[11][3];
w_mem[11][3] <= w_mem[11][2];
w_mem[11][2] <= w_mem[11][1];
w_mem[11][1] <= w_mem[11][0];
w_mem[11][0] <= w_mem[10][31];
w_mem[10][31] <= w_mem[10][30];
w_mem[10][30] <= w_mem[10][29];
w_mem[10][29] <= w_mem[10][28];
w_mem[10][28] <= w_mem[10][27];
w_mem[10][27] <= w_mem[10][26];
w_mem[10][26] <= w_mem[10][25];
w_mem[10][25] <= w_mem[10][24];
w_mem[10][24] <= w_mem[10][23];
w_mem[10][23] <= w_mem[10][22];
w_mem[10][22] <= w_mem[10][21];
w_mem[10][21] <= w_mem[10][20];
w_mem[10][20] <= w_mem[10][19];
w_mem[10][19] <= w_mem[10][18];
w_mem[10][18] <= w_mem[10][17];
w_mem[10][17] <= w_mem[10][16];
w_mem[10][16] <= w_mem[10][15];
w_mem[10][15] <= w_mem[10][14];
w_mem[10][14] <= w_mem[10][13];
w_mem[10][13] <= w_mem[10][12];
w_mem[10][12] <= w_mem[10][11];
w_mem[10][11] <= w_mem[10][10];
w_mem[10][10] <= w_mem[10][9];
w_mem[10][9] <= w_mem[10][8];
w_mem[10][8] <= w_mem[10][7];
w_mem[10][7] <= w_mem[10][6];
w_mem[10][6] <= w_mem[10][5];
w_mem[10][5] <= w_mem[10][4];
w_mem[10][4] <= w_mem[10][3];
w_mem[10][3] <= w_mem[10][2];
w_mem[10][2] <= w_mem[10][1];
w_mem[10][1] <= w_mem[10][0];
w_mem[10][0] <= w_mem[09][31];
w_mem[09][31] <= w_mem[09][30];
w_mem[09][30] <= w_mem[09][29];
w_mem[09][29] <= w_mem[09][28];
w_mem[09][28] <= w_mem[09][27];
w_mem[09][27] <= w_mem[09][26];
w_mem[09][26] <= w_mem[09][25];
w_mem[09][25] <= w_mem[09][24];
w_mem[09][24] <= w_mem[09][23];
w_mem[09][23] <= w_mem[09][22];
w_mem[09][22] <= w_mem[09][21];
w_mem[09][21] <= w_mem[09][20];
w_mem[09][20] <= w_mem[09][19];
w_mem[09][19] <= w_mem[09][18];
w_mem[09][18] <= w_mem[09][17];
w_mem[09][17] <= w_mem[09][16];
w_mem[09][16] <= w_mem[09][15];
w_mem[09][15] <= w_mem[09][14];
w_mem[09][14] <= w_mem[09][13];
w_mem[09][13] <= w_mem[09][12];
w_mem[09][12] <= w_mem[09][11];
w_mem[09][11] <= w_mem[09][10];
w_mem[09][10] <= w_mem[09][9];
w_mem[09][9] <= w_mem[09][8];
w_mem[09][8] <= w_mem[09][7];
w_mem[09][7] <= w_mem[09][6];
w_mem[09][6] <= w_mem[09][5];
w_mem[09][5] <= w_mem[09][4];
w_mem[09][4] <= w_mem[09][3];
w_mem[09][3] <= w_mem[09][2];
w_mem[09][2] <= w_mem[09][1];
w_mem[09][1] <= w_mem[09][0];
w_mem[09][0] <= w_mem[08][31];
w_mem[08][31] <= w_mem[08][30];
w_mem[08][30] <= w_mem[08][29];
w_mem[08][29] <= w_mem[08][28];
w_mem[08][28] <= w_mem[08][27];
w_mem[08][27] <= w_mem[08][26];
w_mem[08][26] <= w_mem[08][25];
w_mem[08][25] <= w_mem[08][24];
w_mem[08][24] <= w_mem[08][23];
w_mem[08][23] <= w_mem[08][22];
w_mem[08][22] <= w_mem[08][21];
w_mem[08][21] <= w_mem[08][20];
w_mem[08][20] <= w_mem[08][19];
w_mem[08][19] <= w_mem[08][18];
w_mem[08][18] <= w_mem[08][17];
w_mem[08][17] <= w_mem[08][16];
w_mem[08][16] <= w_mem[08][15];
w_mem[08][15] <= w_mem[08][14];
w_mem[08][14] <= w_mem[08][13];
w_mem[08][13] <= w_mem[08][12];
w_mem[08][12] <= w_mem[08][11];
w_mem[08][11] <= w_mem[08][10];
w_mem[08][10] <= w_mem[08][9];
w_mem[08][9] <= w_mem[08][8];
w_mem[08][8] <= w_mem[08][7];
w_mem[08][7] <= w_mem[08][6];
w_mem[08][6] <= w_mem[08][5];
w_mem[08][5] <= w_mem[08][4];
w_mem[08][4] <= w_mem[08][3];
w_mem[08][3] <= w_mem[08][2];
w_mem[08][2] <= w_mem[08][1];
w_mem[08][1] <= w_mem[08][0];
w_mem[08][0] <= w_mem[07][31];
w_mem[07][31] <= w_mem[07][30];
w_mem[07][30] <= w_mem[07][29];
w_mem[07][29] <= w_mem[07][28];
w_mem[07][28] <= w_mem[07][27];
w_mem[07][27] <= w_mem[07][26];
w_mem[07][26] <= w_mem[07][25];
w_mem[07][25] <= w_mem[07][24];
w_mem[07][24] <= w_mem[07][23];
w_mem[07][23] <= w_mem[07][22];
w_mem[07][22] <= w_mem[07][21];
w_mem[07][21] <= w_mem[07][20];
w_mem[07][20] <= w_mem[07][19];
w_mem[07][19] <= w_mem[07][18];
w_mem[07][18] <= w_mem[07][17];
w_mem[07][17] <= w_mem[07][16];
w_mem[07][16] <= w_mem[07][15];
w_mem[07][15] <= w_mem[07][14];
w_mem[07][14] <= w_mem[07][13];
w_mem[07][13] <= w_mem[07][12];
w_mem[07][12] <= w_mem[07][11];
w_mem[07][11] <= w_mem[07][10];
w_mem[07][10] <= w_mem[07][9];
w_mem[07][9] <= w_mem[07][8];
w_mem[07][8] <= w_mem[07][7];
w_mem[07][7] <= w_mem[07][6];
w_mem[07][6] <= w_mem[07][5];
w_mem[07][5] <= w_mem[07][4];
w_mem[07][4] <= w_mem[07][3];
w_mem[07][3] <= w_mem[07][2];
w_mem[07][2] <= w_mem[07][1];
w_mem[07][1] <= w_mem[07][0];
w_mem[07][0] <= w_mem[06][31];
w_mem[06][31] <= w_mem[06][30];
w_mem[06][30] <= w_mem[06][29];
w_mem[06][29] <= w_mem[06][28];
w_mem[06][28] <= w_mem[06][27];
w_mem[06][27] <= w_mem[06][26];
w_mem[06][26] <= w_mem[06][25];
w_mem[06][25] <= w_mem[06][24];
w_mem[06][24] <= w_mem[06][23];
w_mem[06][23] <= w_mem[06][22];
w_mem[06][22] <= w_mem[06][21];
w_mem[06][21] <= w_mem[06][20];
w_mem[06][20] <= w_mem[06][19];
w_mem[06][19] <= w_mem[06][18];
w_mem[06][18] <= w_mem[06][17];
w_mem[06][17] <= w_mem[06][16];
w_mem[06][16] <= w_mem[06][15];
w_mem[06][15] <= w_mem[06][14];
w_mem[06][14] <= w_mem[06][13];
w_mem[06][13] <= w_mem[06][12];
w_mem[06][12] <= w_mem[06][11];
w_mem[06][11] <= w_mem[06][10];
w_mem[06][10] <= w_mem[06][9];
w_mem[06][9] <= w_mem[06][8];
w_mem[06][8] <= w_mem[06][7];
w_mem[06][7] <= w_mem[06][6];
w_mem[06][6] <= w_mem[06][5];
w_mem[06][5] <= w_mem[06][4];
w_mem[06][4] <= w_mem[06][3];
w_mem[06][3] <= w_mem[06][2];
w_mem[06][2] <= w_mem[06][1];
w_mem[06][1] <= w_mem[06][0];
w_mem[06][0] <= w_mem[05][31];
w_mem[05][31] <= w_mem[05][30];
w_mem[05][30] <= w_mem[05][29];
w_mem[05][29] <= w_mem[05][28];
w_mem[05][28] <= w_mem[05][27];
w_mem[05][27] <= w_mem[05][26];
w_mem[05][26] <= w_mem[05][25];
w_mem[05][25] <= w_mem[05][24];
w_mem[05][24] <= w_mem[05][23];
w_mem[05][23] <= w_mem[05][22];
w_mem[05][22] <= w_mem[05][21];
w_mem[05][21] <= w_mem[05][20];
w_mem[05][20] <= w_mem[05][19];
w_mem[05][19] <= w_mem[05][18];
w_mem[05][18] <= w_mem[05][17];
w_mem[05][17] <= w_mem[05][16];
w_mem[05][16] <= w_mem[05][15];
w_mem[05][15] <= w_mem[05][14];
w_mem[05][14] <= w_mem[05][13];
w_mem[05][13] <= w_mem[05][12];
w_mem[05][12] <= w_mem[05][11];
w_mem[05][11] <= w_mem[05][10];
w_mem[05][10] <= w_mem[05][9];
w_mem[05][9] <= w_mem[05][8];
w_mem[05][8] <= w_mem[05][7];
w_mem[05][7] <= w_mem[05][6];
w_mem[05][6] <= w_mem[05][5];
w_mem[05][5] <= w_mem[05][4];
w_mem[05][4] <= w_mem[05][3];
w_mem[05][3] <= w_mem[05][2];
w_mem[05][2] <= w_mem[05][1];
w_mem[05][1] <= w_mem[05][0];
w_mem[05][0] <= w_mem[04][31];
w_mem[04][31] <= w_mem[04][30];
w_mem[04][30] <= w_mem[04][29];
w_mem[04][29] <= w_mem[04][28];
w_mem[04][28] <= w_mem[04][27];
w_mem[04][27] <= w_mem[04][26];
w_mem[04][26] <= w_mem[04][25];
w_mem[04][25] <= w_mem[04][24];
w_mem[04][24] <= w_mem[04][23];
w_mem[04][23] <= w_mem[04][22];
w_mem[04][22] <= w_mem[04][21];
w_mem[04][21] <= w_mem[04][20];
w_mem[04][20] <= w_mem[04][19];
w_mem[04][19] <= w_mem[04][18];
w_mem[04][18] <= w_mem[04][17];
w_mem[04][17] <= w_mem[04][16];
w_mem[04][16] <= w_mem[04][15];
w_mem[04][15] <= w_mem[04][14];
w_mem[04][14] <= w_mem[04][13];
w_mem[04][13] <= w_mem[04][12];
w_mem[04][12] <= w_mem[04][11];
w_mem[04][11] <= w_mem[04][10];
w_mem[04][10] <= w_mem[04][9];
w_mem[04][9] <= w_mem[04][8];
w_mem[04][8] <= w_mem[04][7];
w_mem[04][7] <= w_mem[04][6];
w_mem[04][6] <= w_mem[04][5];
w_mem[04][5] <= w_mem[04][4];
w_mem[04][4] <= w_mem[04][3];
w_mem[04][3] <= w_mem[04][2];
w_mem[04][2] <= w_mem[04][1];
w_mem[04][1] <= w_mem[04][0];
w_mem[04][0] <= w_mem[03][31];
w_mem[03][31] <= w_mem[03][30];
w_mem[03][30] <= w_mem[03][29];
w_mem[03][29] <= w_mem[03][28];
w_mem[03][28] <= w_mem[03][27];
w_mem[03][27] <= w_mem[03][26];
w_mem[03][26] <= w_mem[03][25];
w_mem[03][25] <= w_mem[03][24];
w_mem[03][24] <= w_mem[03][23];
w_mem[03][23] <= w_mem[03][22];
w_mem[03][22] <= w_mem[03][21];
w_mem[03][21] <= w_mem[03][20];
w_mem[03][20] <= w_mem[03][19];
w_mem[03][19] <= w_mem[03][18];
w_mem[03][18] <= w_mem[03][17];
w_mem[03][17] <= w_mem[03][16];
w_mem[03][16] <= w_mem[03][15];
w_mem[03][15] <= w_mem[03][14];
w_mem[03][14] <= w_mem[03][13];
w_mem[03][13] <= w_mem[03][12];
w_mem[03][12] <= w_mem[03][11];
w_mem[03][11] <= w_mem[03][10];
w_mem[03][10] <= w_mem[03][9];
w_mem[03][9] <= w_mem[03][8];
w_mem[03][8] <= w_mem[03][7];
w_mem[03][7] <= w_mem[03][6];
w_mem[03][6] <= w_mem[03][5];
w_mem[03][5] <= w_mem[03][4];
w_mem[03][4] <= w_mem[03][3];
w_mem[03][3] <= w_mem[03][2];
w_mem[03][2] <= w_mem[03][1];
w_mem[03][1] <= w_mem[03][0];
w_mem[03][0] <= w_mem[02][31];
w_mem[02][31] <= w_mem[02][30];
w_mem[02][30] <= w_mem[02][29];
w_mem[02][29] <= w_mem[02][28];
w_mem[02][28] <= w_mem[02][27];
w_mem[02][27] <= w_mem[02][26];
w_mem[02][26] <= w_mem[02][25];
w_mem[02][25] <= w_mem[02][24];
w_mem[02][24] <= w_mem[02][23];
w_mem[02][23] <= w_mem[02][22];
w_mem[02][22] <= w_mem[02][21];
w_mem[02][21] <= w_mem[02][20];
w_mem[02][20] <= w_mem[02][19];
w_mem[02][19] <= w_mem[02][18];
w_mem[02][18] <= w_mem[02][17];
w_mem[02][17] <= w_mem[02][16];
w_mem[02][16] <= w_mem[02][15];
w_mem[02][15] <= w_mem[02][14];
w_mem[02][14] <= w_mem[02][13];
w_mem[02][13] <= w_mem[02][12];
w_mem[02][12] <= w_mem[02][11];
w_mem[02][11] <= w_mem[02][10];
w_mem[02][10] <= w_mem[02][9];
w_mem[02][9] <= w_mem[02][8];
w_mem[02][8] <= w_mem[02][7];
w_mem[02][7] <= w_mem[02][6];
w_mem[02][6] <= w_mem[02][5];
w_mem[02][5] <= w_mem[02][4];
w_mem[02][4] <= w_mem[02][3];
w_mem[02][3] <= w_mem[02][2];
w_mem[02][2] <= w_mem[02][1];
w_mem[02][1] <= w_mem[02][0];
w_mem[02][0] <= w_mem[01][31];
w_mem[01][31] <= w_mem[01][30];
w_mem[01][30] <= w_mem[01][29];
w_mem[01][29] <= w_mem[01][28];
w_mem[01][28] <= w_mem[01][27];
w_mem[01][27] <= w_mem[01][26];
w_mem[01][26] <= w_mem[01][25];
w_mem[01][25] <= w_mem[01][24];
w_mem[01][24] <= w_mem[01][23];
w_mem[01][23] <= w_mem[01][22];
w_mem[01][22] <= w_mem[01][21];
w_mem[01][21] <= w_mem[01][20];
w_mem[01][20] <= w_mem[01][19];
w_mem[01][19] <= w_mem[01][18];
w_mem[01][18] <= w_mem[01][17];
w_mem[01][17] <= w_mem[01][16];
w_mem[01][16] <= w_mem[01][15];
w_mem[01][15] <= w_mem[01][14];
w_mem[01][14] <= w_mem[01][13];
w_mem[01][13] <= w_mem[01][12];
w_mem[01][12] <= w_mem[01][11];
w_mem[01][11] <= w_mem[01][10];
w_mem[01][10] <= w_mem[01][9];
w_mem[01][9] <= w_mem[01][8];
w_mem[01][8] <= w_mem[01][7];
w_mem[01][7] <= w_mem[01][6];
w_mem[01][6] <= w_mem[01][5];
w_mem[01][5] <= w_mem[01][4];
w_mem[01][4] <= w_mem[01][3];
w_mem[01][3] <= w_mem[01][2];
w_mem[01][2] <= w_mem[01][1];
w_mem[01][1] <= w_mem[01][0];
w_mem[01][0] <= w_mem[00][31];
w_mem[00][31] <= w_mem[00][30];
w_mem[00][30] <= w_mem[00][29];
w_mem[00][29] <= w_mem[00][28];
w_mem[00][28] <= w_mem[00][27];
w_mem[00][27] <= w_mem[00][26];
w_mem[00][26] <= w_mem[00][25];
w_mem[00][25] <= w_mem[00][24];
w_mem[00][24] <= w_mem[00][23];
w_mem[00][23] <= w_mem[00][22];
w_mem[00][22] <= w_mem[00][21];
w_mem[00][21] <= w_mem[00][20];
w_mem[00][20] <= w_mem[00][19];
w_mem[00][19] <= w_mem[00][18];
w_mem[00][18] <= w_mem[00][17];
w_mem[00][17] <= w_mem[00][16];
w_mem[00][16] <= w_mem[00][15];
w_mem[00][15] <= w_mem[00][14];
w_mem[00][14] <= w_mem[00][13];
w_mem[00][13] <= w_mem[00][12];
w_mem[00][12] <= w_mem[00][11];
w_mem[00][11] <= w_mem[00][10];
w_mem[00][10] <= w_mem[00][9];
w_mem[00][9] <= w_mem[00][8];
w_mem[00][8] <= w_mem[00][7];
w_mem[00][7] <= w_mem[00][6];
w_mem[00][6] <= w_mem[00][5];
w_mem[00][5] <= w_mem[00][4];
w_mem[00][4] <= w_mem[00][3];
w_mem[00][3] <= w_mem[00][2];
w_mem[00][2] <= w_mem[00][1];
w_mem[00][1] <= w_mem[00][0];
w_mem[00][0] <= scan_input;
          end else begin
                my_scan_output <= my_scan_output;
              end
          end else begin
              if (w_mem_we)
                begin
                  w_mem[00] <= w_mem00_new;
                  w_mem[01] <= w_mem01_new;
                  w_mem[02] <= w_mem02_new;
                  w_mem[03] <= w_mem03_new;
                  w_mem[04] <= w_mem04_new;
                  w_mem[05] <= w_mem05_new;
                  w_mem[06] <= w_mem06_new;
                  w_mem[07] <= w_mem07_new;
                  w_mem[08] <= w_mem08_new;
                  w_mem[09] <= w_mem09_new;
                  w_mem[10] <= w_mem10_new;
                  w_mem[11] <= w_mem11_new;
                  w_mem[12] <= w_mem12_new;
                  w_mem[13] <= w_mem13_new;
                  w_mem[14] <= w_mem14_new;
                  w_mem[15] <= w_mem15_new;
                end
              if (w_ctr_we)
                w_ctr_reg <= w_ctr_new;
          end
        end
    end // reg_update


  //----------------------------------------------------------------
  // select_w
  //
  // Mux for the external read operation. This is where we exract
  // the W variable.
  //----------------------------------------------------------------
  always @*
    begin : select_w
      if (w_ctr_reg < 16)
        w_tmp = w_mem[w_ctr_reg[3 : 0]];
      else
        w_tmp = w_new;
    end // select_w


  //----------------------------------------------------------------
  // w_new_logic
  //
  // Logic that calculates the next value to be inserted into
  // the sliding window of the memory.
  //----------------------------------------------------------------
  always @*
    begin : w_mem_update_logic
      reg [31 : 0] w_0;
      reg [31 : 0] w_1;
      reg [31 : 0] w_9;
      reg [31 : 0] w_14;
      reg [31 : 0] d0;
      reg [31 : 0] d1;

      w_mem00_new = 32'h0;
      w_mem01_new = 32'h0;
      w_mem02_new = 32'h0;
      w_mem03_new = 32'h0;
      w_mem04_new = 32'h0;
      w_mem05_new = 32'h0;
      w_mem06_new = 32'h0;
      w_mem07_new = 32'h0;
      w_mem08_new = 32'h0;
      w_mem09_new = 32'h0;
      w_mem10_new = 32'h0;
      w_mem11_new = 32'h0;
      w_mem12_new = 32'h0;
      w_mem13_new = 32'h0;
      w_mem14_new = 32'h0;
      w_mem15_new = 32'h0;
      w_mem_we    = 0;

      w_0  = w_mem[0];
      w_1  = w_mem[1];
      w_9  = w_mem[9];
      w_14 = w_mem[14];

      d0 = {w_1[6  : 0], w_1[31 :  7]} ^
           {w_1[17 : 0], w_1[31 : 18]} ^
           {3'b000, w_1[31 : 3]};

      d1 = {w_14[16 : 0], w_14[31 : 17]} ^
           {w_14[18 : 0], w_14[31 : 19]} ^
           {10'b0000000000, w_14[31 : 10]};

      w_new = d1 + w_9 + d0 + w_0;

      if (init)
        begin
          w_mem00_new = block[511 : 480];
          w_mem01_new = block[479 : 448];
          w_mem02_new = block[447 : 416];
          w_mem03_new = block[415 : 384];
          w_mem04_new = block[383 : 352];
          w_mem05_new = block[351 : 320];
          w_mem06_new = block[319 : 288];
          w_mem07_new = block[287 : 256];
          w_mem08_new = block[255 : 224];
          w_mem09_new = block[223 : 192];
          w_mem10_new = block[191 : 160];
          w_mem11_new = block[159 : 128];
          w_mem12_new = block[127 :  96];
          w_mem13_new = block[95  :  64];
          w_mem14_new = block[63  :  32];
          w_mem15_new = block[31  :   0];
          w_mem_we    = 1;
        end

      if (next && (w_ctr_reg > 15))
        begin
          w_mem00_new = w_mem[01];
          w_mem01_new = w_mem[02];
          w_mem02_new = w_mem[03];
          w_mem03_new = w_mem[04];
          w_mem04_new = w_mem[05];
          w_mem05_new = w_mem[06];
          w_mem06_new = w_mem[07];
          w_mem07_new = w_mem[08];
          w_mem08_new = w_mem[09];
          w_mem09_new = w_mem[10];
          w_mem10_new = w_mem[11];
          w_mem11_new = w_mem[12];
          w_mem12_new = w_mem[13];
          w_mem13_new = w_mem[14];
          w_mem14_new = w_mem[15];
          w_mem15_new = w_new;
          w_mem_we    = 1;
        end
    end // w_mem_update_logic


  //----------------------------------------------------------------
  // w_ctr
  // W schedule adress counter. Counts from 0x10 to 0x3f and
  // is used to expand the block into words.
  //----------------------------------------------------------------
  always @*
    begin : w_ctr
      w_ctr_new = 6'h0;
      w_ctr_we  = 1'h0;

      if (init)
        begin
          w_ctr_new = 6'h0;
          w_ctr_we  = 1'h1;
        end

      if (next)
        begin
          w_ctr_new = w_ctr_reg + 6'h01;
          w_ctr_we  = 1'h1;
        end
    end // w_ctr
endmodule // sha256_w_mem

//======================================================================
// sha256_w_mem.v
//======================================================================
