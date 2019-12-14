`timescale 1ns / 1ps
module tb_cu_dp;

    reg go, clk;
    reg rst = 0;
    reg [1:0] op;
    reg [3:0] in1, in2;
    wire [3:0] cs, out;
    wire done;
    integer err = 0;
    integer i, K;

    task oneCycle;
    begin
        #10; clk<=0;
        #10; clk<=1;
    end
    endtask
 
     cu_dp DUT1( .go(go), .op(op), .clk(clk), .rst(rst),
    .in1(in1), .in2(in2),
     .done(done), .current(cs), .out(out));

    initial begin
        in1 = 5;
        in2 = 3;
        op = 0;
        go = 0;
        if(cs != 0)begin
        err=err+1;
        end
        
        for(i = 0; i < 6; i = i + 1)
        begin
            oneCycle;
        end
        for(K=0; K<4; K= K+1)
        begin
            op= K;
            go=1;
            while(!done) oneCycle;
            casex(op)
                2'b00: if(in1 + in2 != out) err = err + 1;
                2'b01: if(in1 - in2 != out) err = err + 1;
                2'b10: if(in1 & in2 != out) err = err + 1;
                2'b11: if(in1 ^ in2 != out) err = err + 1;
            endcase
            
            oneCycle;
            #5;
        end
    end
endmodule