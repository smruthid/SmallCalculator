`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 12:21:32 AM
// Design Name: 
// Module Name: sep_bcd
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


module sep_bcd(input [3:0] outResult, output reg [3:0] ten, one);
    always@* begin
    one = outResult % 10;
    ten = outResult/10;
    end
endmodule
