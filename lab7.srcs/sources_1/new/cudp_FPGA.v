`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 04:19:43 PM
// Design Name: 
// Module Name: fourbit_fpga
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


module cudp_FPGA(input [3:0] in1, input [3:0] in2, input wire clk100MHz, input wire button1, input wire goButton,
    input wire [1:0] op, input wire rst, output wire doneSig, output wire [3:0] LEDSEL,
    output wire [7:0] LEDOUT);
    
    
    wire cout;
    wire [3:0] sum; 
  //  wire [7:0] outputMult;
    wire [3:0] csSig, aluOut, ten, one;
    //wire doneSig;
    wire [7:0] BCDOut1;
    wire [7:0] BCDOut2;
    wire [7:0] BCDOut3;
    wire DONT_USE;
    wire clk_5KHz;
    wire button;
    supply1 [7:0] vcc;
    
    
    clk_gen CLK (
        .clk100MHz (clk100MHz),
        .rst (rst),
        .clk_4sec (DONT_USE),
        .clk_5KHz (clk_5KHz)
    );   
    
    button_debouncer debounce(.clk(clk_5KHz), 
                              .button(button1), 
                              .debounced_button(button)); 
    
    cu_dp contrData(.go(goButton), 
                    .op(op), 
                    .clk(button), 
                    .rst(rst), 
                    .in1(in1), 
                    .in2(in2), 
                    .done(doneSig), 
                    .current(csSig), 
                    .out(aluOut));

    
    sep_bcd separator(aluOut, ten, one);
    bcd_to_7seg(csSig, BCDOut3);
    bcd_to_7seg(ten, BCDOut2);
    bcd_to_7seg(one, BCDOut1);
                
                    
   
   led_mux(.clk(clk_5KHz),
           .rst(rst),
           .LED3(BCDOut3),
           .LED2(vcc),
           .LED1(BCDOut2),
           .LED0(BCDOut1),
           .LEDSEL(LEDSEL),
           .LEDOUT(LEDOUT));            
        
endmodule

