`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2023 11:33:58 PM
// Design Name: 
// Module Name: seq_1010
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


module seq_1010(clk,din,reset,dout);

        
        parameter IDLE = 3'b000,
                  STATE1 = 3'b001,
                  STATE2 = 3'b010,
                  STATE3 = 3'b011,
                  STATE4 = 3'b100;
                  
        input clk,din,reset;
        output dout;
        
        reg [2:0] present_state, nxt_state;
        
        always@(posedge clk)
        begin
            if(reset)
            present_state <= IDLE;
            else
            present_state <= nxt_state;  
        end
        
        always@(present_state or din)
        begin
            nxt_state = IDLE;
            case(present_state) 
            IDLE : if(din == 1)
                   nxt_state <= STATE1;
                   else
                   nxt_state <= IDLE;
            STATE1 : if(din == 0)
                   nxt_state <= STATE2;
                   else
                   nxt_state <= STATE1;
            STATE2 : if(din == 1)
                   nxt_state <= STATE3;
                   else
                   nxt_state <= IDLE;
            STATE3 : if(din == 0)
                   nxt_state <= STATE4;
                   else
                   nxt_state <= STATE1; 
            STATE4 : if(din == 1)
                   nxt_state <= STATE3;
                   else
                   nxt_state <= IDLE;  
            
            default : nxt_state <= IDLE;
            endcase
        end
        
        assign dout = (present_state == STATE4);
        
endmodule