`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 17:02:06
// Design Name: 
// Module Name: decimal_BCD_converter
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


module decimal_BCD_converter(decimal,negative,error,BCD3,BCD2,BCD1,BCD0,negative_sign);
    input [15:0]decimal;
    input negative;
    input error;
    //reg [15:0]current_values;
    output reg [3:0]BCD3;
    output reg [3:0]BCD2;
    output reg [3:0]BCD1;
    output reg [3:0]BCD0;
    output reg negative_sign;    
    
    always @*
begin
    begin
        if(negative)
            negative_sign = negative;
        else
            negative_sign = 0;
    end       
    
    begin
        if(error)
        begin
            //BCD3 = 4'b0000;
            //BCD2 = 4'b0000;
            //BCD1 = 4'b0000;
            //BCD0 = 4'b0000;
        end
        
        else            
        begin
        //Thousands
        BCD3 = (decimal / 1000);
        //Hundreds
        BCD2 = ((decimal - (BCD3 * 1000)) / 100);
        //Tenths
        BCD1 = ((decimal - (BCD3 * 1000) - (BCD2 * 100)) / 10);
        //Ones
        BCD0 = ((decimal - (BCD3 * 1000) - (BCD2 * 100) - (BCD1 * 10)) / 1);
        
        end
    end
end     
endmodule
