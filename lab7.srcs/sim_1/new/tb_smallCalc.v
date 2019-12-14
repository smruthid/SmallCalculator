`timescale 1ns / 1ps


module tb_smallCalc;
    reg tb_clk;
    reg [3:0] tb_in1, tb_in2;
    reg [1:0] tb_s1, tb_wa, tb_raa, tb_rab, tb_c;
    reg tb_we, tb_rea, tb_reb, tb_s2;
    wire [3:0] tb_out;
    reg [3:0] expected_dout;
    integer i, j,k;
    integer err_count = 0;
    
    
    small_calculator_dp calc(.clk(tb_clk), .in1(tb_in1), .in2(tb_in2), .s1(tb_s1), 
                             .wa(tb_wa), .raa(tb_raa), .rab(tb_rab), .c(tb_c), .we(tb_we), 
                             .rea(tb_rea), .reb(tb_reb), .s2(tb_s2), .out(tb_out));
    
    
    task oneCycle;
        begin
            tb_clk <= 1;
            #10; tb_clk <= 0; #10;
        end
    endtask
                             
    initial begin
        
//        for(i = 0; i < 16; i = i + 1)
//        begin
//            tb_in2 = i;
//            for(j = 0; j < 16; j = j + 1)
//            begin               
//                tb_in1 = j;    
                for(k = 0; k < 4; k = k + 1)
                begin 
                    tb_in1 = $random;
                    tb_in2 = $random;
                    //idle state 
                    tb_s1 = 0;
                    tb_wa = 0;
                    tb_we = 0;
                    tb_raa = 0;
                    tb_rea = 0;
                    tb_rab = 0;
                    tb_reb = 0;
                    tb_c = 0;
                    tb_s2 = 0;
                    oneCycle;

                    //load1 - state 2
                    tb_s1 = 1;
                    tb_wa = 1;
                    tb_we = 1;
                    tb_raa = 0;
                    tb_rea = 0;
                    tb_rab = 0;
                    tb_reb = 0;
                    tb_c = 0;
                    tb_s2 = 0;
                    oneCycle;

                    //load2 - state 3
                    tb_s1 = 2;
                    tb_wa = 2;
                    tb_we = 1;
                    tb_raa = 0;
                    tb_rea = 0;
                    tb_rab = 0;
                    tb_reb = 0;
                    tb_c = 0;
                    tb_s2 = 0;
                    
                    oneCycle;

                    //operation 
                    tb_s1 = 0;
                    tb_wa = 0;
                    tb_we = 0;                   
                    tb_raa = 1;
                    tb_rea = 1;
                    tb_rab = 2;
                    tb_reb = 1;
                    tb_c = k; 
                    oneCycle;
                    
                    //load into mux1 and into register
                    tb_s1 = 3;
                    tb_wa = 3;
                    tb_we = 1;
                    tb_s2 = 0;
                    oneCycle;

                    //reads from 

                    tb_raa = 3;
                    tb_rea = 1;
                    tb_rab = 3;
                    tb_reb = 1;
                    tb_c = 2;
                    tb_s2 = 1;
                    tb_s1 = 0;
                    tb_wa = 0;
                    tb_we = 0; 
                    oneCycle;
                    
//                    if(tb_c == 0) 
//                    begin
//                        expected_dout <= tb_in1 - tb_in2;
//                        if(tb_out != expected_dout)
//                    err_count = err_count + 1;
//                    end
//                    else if(tb_c == 1)
//                    begin 
//                        expected_dout <= tb_in1 - tb_in2;
//                        if(expected_dout != tb_out) err_count = err_count + 1;
//                    end
//                    else if(tb_c == 2)
//                    begin
//                        expected_dout <= tb_in1 & tb_in2;
//                        if(expected_dout != tb_out) err_count = err_count + 1;
//                    end
//                    else if(tb_c == 3)
//                    begin
//                        expected_dout <= tb_in1 ^ tb_in2;
//                        if(expected_dout != tb_out) err_count = err_count + 1;
//                    end
                   // else expected_dout = 4'bz;         
                end
             end
//        end
//    end
    
endmodule
