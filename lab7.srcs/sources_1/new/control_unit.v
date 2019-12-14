`timescale 1ns / 1ps

module control_unit(go, op, clk, rst, s1, we, wa, rea, raa, reb, rab, c, s2, done, current);
    input go, rst;
    input [1:0] op;
    input clk;
    output reg [1:0] s1, wa, raa, rab, c;
    output reg we, rea, reb, s2, done;
    output reg [3:0] current;
    reg [3:0] cs, ns;
    
    always@(posedge clk)
    begin
//        if(rst) begin cs = 0; ns = 0; end
        if(rst) begin cs = 0; end
        else cs <= ns;
    end
    
    always@(cs, go, op, rst)
    begin
            if(rst) ns = 0;
            else begin
            casex({cs, go, op})
                7'b0000_0_XX: ns <= 0;
                7'b0000_1_XX: ns <= 1;
                7'b0001_X_XX: ns <= 2;
                7'b0010_X_XX: ns <= 3;
                7'b0011_X_00: ns <= 4;
                7'b0011_X_01: ns <= 5;
                7'b0011_X_10: ns <= 6;
                7'b0011_X_11: ns <= 7;
                7'b0100_X_XX: ns <= 8;
                7'b0101_X_XX: ns <= 8;
                7'b0110_X_XX: ns <= 8;
                7'b0111_X_XX: ns <= 8;
                7'b1000_X_XX: ns <= 0;
            endcase
            end
            current = cs; 
     end
     
     always@(cs) begin
            
            casex(cs)
            4'b0000: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b00_0_00_0_00_0_00_00_0_0;
            4'b0001: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b01_1_01_0_00_0_00_00_0_0;
            4'b0010: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b10_1_10_0_00_0_00_00_0_0;
            4'b0011: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b00_0_00_1_01_1_10_00_0_0;
            4'b0100: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b11_1_11_1_01_1_10_00_0_0;
            4'b0101: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b11_1_11_1_01_1_10_01_0_0;
            4'b0110: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b11_1_11_1_01_1_10_10_0_0;
            4'b0111: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b11_1_11_1_01_1_10_11_0_0;
            4'b1000: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b00_0_00_1_11_1_11_10_1_1;
            default: {s1, we, wa, rea, raa, reb, rab, c, s2, done} = 15'b00_0_00_0_00_0_00_00_0_0;
        endcase
        end
   
    

endmodule
