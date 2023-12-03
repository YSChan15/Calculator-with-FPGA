`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2022 16:28:11
// Design Name: 
// Module Name: memory
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


module memory(clock,enable,ReadWrite,Address,DataIn,DataOut);
    parameter n = 17;        //DataIn,Dataout,Mem size 
    parameter m = 3;        //Address input
    parameter pow2m = 8;   //2 to the power of m 
    
    input clock;
    input enable;
    input ReadWrite;
    input [n-1:0] DataIn;
    input [m-1:0] Address;
    
    output reg [n-1:0] DataOut;
    
    reg [n-1:0] Mem[0:pow2m-1];
    
    integer j;
    initial
        for(j = 0; j < pow2m; j = j + 1)
            Mem[j] = j;
      
    always @(posedge clock)
        if(enable)
            if(ReadWrite == 1'b1) 
                DataOut <= Mem[Address];
           
            else
                Mem[Address] <= DataIn;          
                
        else
            DataOut <= 'bz;        
              
endmodule
