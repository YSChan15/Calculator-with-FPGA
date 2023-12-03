`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2022 17:10:31
// Design Name: 
// Module Name: keypad_lab11
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


module keypad_lab11(clock,column,row,digit,push,reset);
        input clock;
        input [0:3]column;
        input reset;        
        output reg [0:3]row;
        output reg [3:0]digit;
        output reg push;
        
        reg[2:0]state;
        reg[2:0]next;
        
         parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6;
        
        initial row = 0;
        
        always @*
        begin
        case(state)
            S0:
            begin
                if(column == 4'b1111)
                    next = S0;
                else
                    next = S1; 
            end
            
            S1:
            begin
                if(column [0] == 0)
                    next = S5;
                else if(column [1] == 0)    
                    next = S5;
                else if(column [2] == 0)    
                    next = S5;    
                else if(column [3] == 0)    
                    next = S5;      
                else
                    next = S2;
            end
            
            S2:
            begin
                if(column [0] == 0)
                    next = S5;
                else if(column [1] == 0)    
                    next = S5;
                else if(column [2] == 0)    
                    next = S5;    
                else if(column [3] == 0)    
                    next = S5;      
                else
                    next = S3;
            end
            
            S3:
            begin
                if(column [0] == 0)
                    next = S5;
                else if(column [1] == 0)    
                    next = S5;
                else if(column [2] == 0)    
                    next = S5;    
                else if(column [3] == 0)    
                    next = S5;      
                else
                    next = S4;          
            end
            
            S4:
            begin
                if(column [0] == 0)
                    next = S5;
                else if(column [1] == 0)    
                    next = S5;
                else if(column [2] == 0)    
                    next = S5;    
                else if(column [3] == 0)    
                    next = S5;  
                else    
                next = S0;
            end
              
            S5: next = S6;
                                    
            S6:
            begin
                    if(column == 4'b1111)
                        next = S0;    
                   
                    else
                        next = S6;     
            end
            
            default:
                next = S0;
            endcase
        end                        
        
        
        always @(posedge clock,posedge reset)
        begin
            if(reset)
                state <= S0;
            else
                state <= next;
        end
        
        
        
        always @(posedge clock,posedge reset)
        begin
        
        if(reset)
        begin    
            row <= 0;
            digit <= 0;
        end
        
        else          
        begin
        case(state)
            //Waiting for key press
            S0:
            begin
                row <= 0;
                if(~(column == 4'b1111))
                begin
                row <= 4'b0111;
                end
            end
            
            //Row 0 scanning 
            S1:
            begin
                if(column [0] == 0)
                    digit <= 1;
                else if(column [1] == 0)    
                    digit <= 2;
                else if(column [2] == 0)    
                    digit <= 3;    
                else if(column [3] == 0)    
                    digit <= 10;      
                else
                    begin
                    row <= 4'b1011;
                    end
                        
            end
            
            //Row 1 scanning
            S2:
            begin
                if(column [0] == 0)
                    digit <= 4;
                else if(column [1] == 0)    
                    digit <= 5;
                else if(column [2] == 0)    
                    digit <= 6;   
                else if(column [3] == 0)    
                    digit <= 11;      
                else
                    begin
                    row <= 4'b1101;
                    end
                         
            end
            
            //Row 2 scanning
            S3:
            begin
                if(column [0] == 0)
                    digit <= 7;
                else if(column [1] == 0)    
                    digit <= 8;
                else if(column [2] == 0)    
                    digit <= 9;    
                else if(column [3] == 0)    
                    digit <= 12;      
                else
                    begin
                    row <= 4'b1110; 
                    end  
            end
            
            //Row 3 scanning 
            S4:
            begin
                if(column[0] == 0)
                    digit <= 15;
                else if(column[1] == 0)    
                    digit <= 0;
                else if(column[2] == 0)    
                    digit <= 14;    
                else if(column[3] == 0)
                    digit <= 13;       
            end
            
            S5:
            begin
                push <= 1;
            end       
            
            S6:
            begin
                if(column == 4'b1111)
                begin
                    push <= 0;            
                    row <= 4'b0000;
                end      
            end       
            
        endcase
        end
    end
endmodule
