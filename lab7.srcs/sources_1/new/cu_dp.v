`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 02:33:23 PM
// Design Name: 
// Module Name: cu_dp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cu_dp(input go, input [1:0] op, input clk, input rst, input [3:0] in1, in2, output done, output [3:0] current, output[3:0] out);

    //intermediate wires
    wire [1:0] intr_s1, intr_wa, intr_raa, intr_rab, intr_c;
    wire intr_we, intr_rea, intr_reb, intr_s2;
    
    control_unit contr(.go(go), .op(op), .clk(clk), .rst(rst), .s1(intr_s1), 
                       .we(intr_we), .wa(intr_wa), .rea(intr_rea), .raa(intr_raa), 
                       .reb(intr_reb), .rab(intr_rab), .c(intr_c), .s2(intr_s2), 
                       .done(done), .current(current));
                       
    small_calculator_dp data(.clk(clk), .in1(in1), .in2(in2), .s1(intr_s1), .wa(intr_wa), 
                             .raa(intr_raa), .rab(intr_rab), .c(intr_c), .we(intr_we), 
                             .rea(intr_rea), .reb(intr_reb), .s2(intr_s2), .out(out));
endmodule
