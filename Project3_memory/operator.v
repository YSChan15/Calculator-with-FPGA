`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 13:42:31
// Design Name: 
// Module Name: operator
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


module operator(A3,A2,A1,A0,AN,B3,B2,B1,B0,BN,operator,out,negout,error);
    //Input for first set of number
    input [3:0]A3;
    input [3:0]A2;
    input [3:0]A1;
    input [3:0]A0;
    input AN;
    
    //Input for second set of number
    input [3:0]B3;
    input [3:0]B2;
    input [3:0]B1;
    input [3:0]B0;
    input BN;
    
    //Operator 
    input [3:0]operator;
    
    //Registers to hold A and B values
    wire [15:0]A;
    wire [15:0]B;
    
    //Output 
    output reg [15:0]out;
    output reg negout;
    output reg error;
    reg [15:0]outadd;
    reg [15:0]outminus;
    reg [32:0]outmul;
    reg [15:0]outdiv;
    reg negadd;
    reg negminus;
    reg errormul;
    reg errordiv;
    reg erroradd;
    reg errorminus;
    
    parameter add = 4'b1010, minus = 4'b1011, multiply = 4'b1100, divide = 4'b1101;
    
    //Converting A and B to decimal values 
    assign A = (A3*1000) + (A2*100) + (A1*10) + A0;
    assign B = (B3*1000) + (B2*100) + (B1*10) + B0;
    
    //Addition
    always @*
    begin
        if((~AN) && (~BN))
            outadd = A + B;
        
        else if((AN) && (~BN))
            outadd = (-A) + B;
        
        else if((~AN) && (BN))
            outadd = A + (-B);        
        
        else if ((AN) && (BN))
            outadd = (-A) + (-B);
          
      
        if(outadd[15] == 1)
            negadd = 1'b1;
        else
            negadd = 1'b0; 
            
                        
        if(negadd)
            outadd = -outadd;
        else
            outadd = outadd;    
            
            
        if(outadd > 9999)
            erroradd = 1'b1;
        else
            erroradd = 1'b0;
                            
    end
    
    
    //Subtraction
    always @*
    begin
        if((~AN) && (~BN))
            outminus = A - B;
        
        else if((AN) && (~BN))
            outminus = (-A) - B;
        
        else if((~AN) && (BN))
            outminus = A - (-B);        
        
        else if ((AN) && (BN))
            outminus = (-A) - (-B);
        
        /*
        else
            outminus = 4'b0000;   
        */
      
        if(outminus[15] == 1)
            negminus = 1'b1;
        else
            negminus = 1'b0;
            
            
        if(negminus)
            outminus = -outminus;
        else
            outminus = outminus;
            
    
        if(outminus > 9999)
            errorminus = 1'b1;
        else
            errorminus = 1'b0;         
                     
    end    
        
     
    //Multiply 
    always @*
    begin
        outmul = A * B;
        if(outmul > 9999)
            errormul = 1'b1;  
        else
            errormul = 1'b0;            
    end  
    
    //Division
    always @*
    begin
        outdiv = A / B;
        if(B == 0)
            errordiv = 1'b1;
        else
            errordiv = 1'b0;
    end
    
    
    
    
    always @*
    begin
    case(operator)
        add:
        begin
            negout = negadd;
            out = outadd; 
  
            if(erroradd)
                error = 1'b1;
            else
                error = 1'b0;
                    
        end    
        
    
        minus:
        begin
            negout = negminus;
            out = outminus;
     
            if(errorminus) 
                error = 1'b1;
            else
                error = 1'b0;    
        end
        
        
        multiply:
        begin
            out = outmul;
        begin
        if(((~AN) && (~BN)) || ((AN && BN)))
            begin
                negout = 1'b0;
            end
        
            else if(((~AN) && (BN)) || ((AN) && (~BN)))
            begin    
                negout = 1'b1;
            end    
            
            /*    
            else
            begin
                negout = 1'b0;
            end
            */
        end
        
        if(errormul)
            error = 1'b1;
        else
            error = 1'b0;    
        end
        
        
        divide:
        begin
            out = outdiv;
            if(((~AN) && (~BN)) || ((AN && BN)))
            begin
                negout = 1'b0;
            end
        
            else if(((~AN) && (BN)) || ((AN) && (~BN)))
            begin    
                negout = 1'b1;
            end    
            
            /*    
            else
            begin
                negout = 1'b0;
            end
            */
                    
        if(errordiv)
            error = 1'b1;
        else
            error = 1'b0;
                
        end    
        
        /*
        default:
        begin
            out = 4'b0000;
            error = 1'b10;
        end
        */
        endcase
    end        
endmodule
