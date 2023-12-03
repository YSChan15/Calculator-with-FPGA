`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2022 13:36:01
// Design Name: 
// Module Name: slower_clock
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


module slower_clock(CLK100MHZ, slower_clock);
    parameter n = 500;
    parameter log2n = 9;
    
    input CLK100MHZ;
    output reg slower_clock;
    reg [log2n:0] counter;
    
    reg [1:0]next;
    reg [1:0]state;
    
    parameter S0 = 2'b00; parameter S1 = 2'b11;
    
    initial slower_clock = 0;
    initial counter = 0;
    
    always @*
    begin
        case(state)
        S0:
            if(counter == (n - 1'b1)) next = S1; else next = S0;
        
        S1: 
            if(counter == 0) next = S0; else next = S1;
        
        default:
            next = S0;        
        endcase
    end
            
    always @(posedge CLK100MHZ)
        state <= next;
        
    //RTL & output 
    always @(posedge CLK100MHZ)
    begin
        case(state)
        S0:
            begin
            if(counter != (n -1'b1))
                counter <= counter + 1'b1;
                
            if(counter == (n - 1'b1))
                slower_clock <= 1'b1;    
            end
              
        S1:
            begin
            if(counter != 0)
                counter <= counter - 1'b1;
                
            if(counter == 0)
                slower_clock <= 1'b0;    
            end    
        endcase
    end        
endmodule
