`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2023 11:45:54 PM
// Design Name: 
// Module Name: tb_seq_1010
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


module tb_seq_1010();

        parameter cycle = 10;
        
        reg clk,din,reset;
        wire dout;
        
        seq_1010 SQD (.clk(clk),.din(din),.reset(reset),.dout(dout));
        
        initial
        begin
            clk = 0;
            forever #(cycle/2) clk = ~clk;
        end
        
        task initialize;
            begin
                din = 0;
            end
        endtask
        
        task delay (input integer i);
            begin
                #i;
            end
        endtask
        
        task RESET;
            begin
                reset = 1;
                delay(10);
                reset = 0;
            end
        endtask
        
        task stimulus (input j);
            begin
                @(negedge clk)
                din = j;
            end
        endtask  
        
        initial 
        begin
            $monitor("reset = %b, state = %b, din = %b, dout = %b",reset, SQD.present_state, din, dout);
        end
        
        always@(SQD.present_state or dout)
        begin
            if(SQD.present_state==2'b11 && dout==1)
            $display("correct output at state %b",SQD.present_state);
        end
        
        initial
        begin
            initialize;
            RESET;
            stimulus(0);
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(1);
            
            RESET;
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(0);
            delay(10);
            $finish;
       end
            
endmodule
