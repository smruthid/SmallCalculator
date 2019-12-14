`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 01:48:23 AM
// Design Name: 
// Module Name: tb_cu
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


module tb_cu;
    //declaring registers and outputs
    reg go, rst, clk;
    reg [1:0] op;
    wire [3:0] current;
    wire [1:0] s1, wa, raa, rab, c;
    wire we, rea, reb, s2, done;
    integer i;
    
    task clkCycle; //generates one clock cycle
        begin
            clk <= 1; #5;
            clk <= 0; #5;
        end
    endtask
    
    //instantiation
    control_unit cu(.go(go), .op(op), .clk(clk), .rst(rst), .s1(s1), .we(we), .wa(wa), .rea(rea), .raa(raa),
                    .reb(reb), .rab(rab), .c(c), .s2(s2), .done(done), .current(current)); 

    
    initial begin      
        rst = 1;
        clkCycle;
        rst = 0;
        go = 1; //idle to load
        clkCycle;          
        for(i = 0; i < 4; i = i + 1)
        begin
            op = i;
            //bc excitation table has 6 states in every round depending on operation 
            clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle; clkCycle;
        end
        $finish;
        $stop;
    end 
endmodule
