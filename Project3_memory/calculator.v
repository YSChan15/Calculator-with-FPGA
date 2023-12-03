`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2022 13:04:23
// Design Name: 
// Module Name: calculator
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


module calculator(push,reset,digit,BCD3,BCD2,BCD1,BCD0,negative_sign,error,A3,A2,A1,A0,AN,B3,B2,B1,B0,BN,Z4,Z3,Z2,Z1,Z0,operator,out_error);
    input push;
    input reset;
    input [3:0]digit;
    input [3:0]BCD3;
    input [3:0]BCD2;
    input [3:0]BCD1;
    input [3:0]BCD0;
    input negative_sign;
    input error;
    
    output reg [3:0]A3;
    output reg [3:0]A2;
    output reg [3:0]A1;
    output reg [3:0]A0;
    output reg AN;
    
    output reg [3:0]B3;
    output reg [3:0]B2;
    output reg [3:0]B1;
    output reg [3:0]B0;
    output reg BN;
    
    output reg [3:0]Z4;
    output reg [3:0]Z3;
    output reg [3:0]Z2;
    output reg [3:0]Z1;
    output reg [3:0]Z0;
    output reg [3:0]operator;
    output reg out_error;
    
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10, S12 = 12;
    parameter add = 10, subtract = 11, multiply = 12, divide = 13;
    reg[4:0]state;
    reg[4:0]next;
    
    parameter blank = 4'b1110;
    parameter negative = 4'b1111;
    parameter error_E = 4'b1100;
    
    initial begin
    state = S0;
    A3 = 0; A2 = 0; A1 = 0; A0 = 0; AN = 0;
    B3 = 0; B2 = 0; B1 = 0; B0 = 0; BN = 0;
    end
    
    always @(posedge push, posedge reset)
        if(reset)
            state <= S0;
        
        else
            state <= next;
    
    //Next state logic
    always @*
    begin
        case(state)
            S0:
            begin
                if((0 < digit) && (digit <= 9))
                    next = S1;
                
                else
                    next = S0;
            end
            
            S1:
            begin
                if(digit == 15)
                    next = S1;    
                else if ((10 <= digit) && (digit <= 13))
                    next = S5;
                else if (digit == 14)
                    next = S1;
                else
                    next = S2;
            end
            
            S2:
            begin
                if(digit == 15)
                    next = S2;    
                else if ((10 <= digit) && (digit <= 13))
                    next = S5;
                else if (digit == 14)
                    next = S2;
                else
                    next = S3;
            end
            
            S3:
            begin
                if(digit == 15)
                    next = S3;    
                else if ((10 <= digit) && (digit <= 13))
                    next = S5;
                else if (digit == 14)
                    next = S3;
                else
                    next = S4;                        
            end          
            
            S4:
            begin
                if(digit == 15)
                    next = S4;    
                else if ((10 <= digit) && (digit <= 13))
                    next = S5;
                else
                    next = S4;    
            end
            
            S5:
            begin
                if((0 <= digit) && (digit <= 9))
                    next = S6;
                
                else
                    next = S5;
            end
            
            S6:
            begin
                if(digit == 15)
                    next = S6;    
                else if ((10 <= digit) && (digit <= 13))
                    if(error)
                        next = S12;
                    else    
                        next = S5;
                        
                else if (digit == 14)
                    if(error)
                        next = S12;
                    else
                        next = S10;
                
                else if (digit == 0)
                    if(B0 == 0)
                        next = S6;
                    
                    else    
                        next = S7;    
                
                else if(B0 == 0)
                    next = S6;
                          
                else
                    next = S7;
            end
            
            S7:
            begin
                if(digit == 15)
                    next = S7;    
                else if ((10 <= digit) && (digit <= 13))
                    if(error)
                        next = S12;
                    else    
                        next = S5;
                        
                else if (digit == 14)
                    if(error)
                        next = S12;
                    else    
                        next = S10;
                        
                else
                    next = S8; 
            end
            
            S8:
            begin
                if(digit == 15)
                    next = S8;    
                else if ((10 <= digit) && (digit <= 13))
                    if(error)
                        next = S12;
                    else
                        next = S5;
                        
                else if (digit == 14)
                    if(error)
                        next = S12;
                    else    
                        next = S10;
                        
                else
                    next = S9;
            end
            
            S9:
            begin
                if(digit == 15)
                    next = S9;    
                else if ((10 <= digit) && (digit <= 13))
                    if(error)
                        next = S12;
                    else    
                        next = S5;
                        
                else if (digit == 14)
                    if(error)
                        next = S12;
                    else    
                        next = S10;
                        
                else
                    next = S9;
            end
            
            S10:
            begin
                //if(error)
                //    next = S12; 
                if ((10 <= digit) && (digit <= 13))
                    next = S5;
                else if (digit == 15)
                    next = S10;
                else if (digit == 14)
                    next = S10;
                else if ((0 < digit) && (digit <= 9))
                    next = S1;
                else
                    next = S0;                                              
            end
            
            S12:
            begin
                next = S12;
            end
            
            default:
                next = S0;
    endcase
end                              

    always @(posedge push, posedge reset)
        if(reset)
        begin
               A3 <= 0; A2 <= 0; A1 <= 0; A0 <=0; AN <=0;
               B3 <= 0; B2 <= 0; B1 <= 0; B0 <=0; BN <=0;
               operator <= 0;
        end
        
        else
        begin
            case(state)
                S0:
                begin
                    A0 <= digit;
                end
                
                S1:
                begin
                    if(digit == 15)
                        AN <= ~AN;
                    
                    else if((10 <= digit) && (digit <= 13))
                        operator <= digit;
                    
                    else if(~(digit == 14))
                    begin
                        A1 <= A0; A0 <= digit;     
                    end
                end
                
                S2:
                begin
                    if(digit == 15)
                        AN <= ~AN;
                    
                    else if((10 <= digit) && (digit <= 13))
                        operator <= digit;
                    
                    else if(~(digit == 14))
                    begin
                       A2<= A1; A1 <= A0; A0 <= digit;     
                    end
                end
                
                S3:
                begin
                    if(digit == 15)
                        AN <= ~AN;
                    
                    else if((10 <= digit) && (digit <= 13))
                        operator <= digit;
                    
                    else if(~(digit == 14))
                    begin
                        A3 <= A2; A2 <= A1; A1 <= A0; A0 <= digit;     
                    end
                end
                
                S4:
                begin
                    if(digit == 15)
                        AN <= ~AN;
                        
                    else if((10 <= digit) && (digit <= 13))
                        operator <= digit;
                end
                
                S5:
                begin
                    if((0 <= digit) && (digit <= 9))
                        B0 <= digit;
                    
                    else if((10 <= digit) && (digit <= 13))
                        operator <= digit;     
                end
                
                S6:
                begin
                    if(digit == 15)
                        BN <= ~BN;
                    
                    else if((10 <= digit) && (digit <= 13))
                    begin
                        operator <= digit;
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                    
                    else if(digit == 14)
                    begin
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                    
                    else if(digit == 0)
                    begin
                        if(B0 != 0)
                            B1 <= B0; B0 <= digit;
                    end
                                
                    else if(B0 == 0)
                        B0 <= digit;
                        
                    else if(~(B0 == 0))   
                    begin
                       B1 <= B0; B0 <= digit;     
                    end
                end
                
                S7:
                begin
                    if(digit == 15)
                        BN <= ~BN;
                    
                    else if((10 <= digit) && (digit <= 13))
                    begin
                        operator <= digit;
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end     
                    
                    else if(digit == 14)
                    begin
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                    
                    else 
                    begin
                       B2 <= B1; B1 <= B0; B0 <= digit;     
                    end
                end
                
                S8: 
                begin
                    if(digit == 15)
                        BN <= ~BN;
                    
                    else if((10 <= digit) && (digit <= 13))
                    begin   
                        operator <= digit;
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end  
                    
                    else if(digit == 14)
                    begin
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                    
                    else 
                    begin
                        B3 <= B2; B2 <= B1; B1 <= B0; B0 <= digit;     
                    end  
                end
                
                S9:
                begin
                    if(digit == 15)
                        BN <= ~BN;
                    
                    else if((10 <= digit) && (digit <= 13))
                    begin
                        operator <= digit;
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                    
                    else if(digit == 14)
                    begin
                        A3 <= BCD3; A2 <= BCD2; A1 <= BCD1; A0 <= BCD0; AN <= negative_sign;
                        B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                    end
                end       
                
                S10:
                begin
                if(digit == 15)
                    AN <= ~AN;
                        
                else if((10 <= digit) && (digit <= 13))
                    operator <= digit;       
                
                else if ((0 < digit) && (digit <= 9))
                begin
                    A3 <= 0; A2 <= 0; A1 <= 0; A0 <= digit; AN <= 0;
                    B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                end
                
                else if (digit == 0)
                begin
                    A3 <= 0; A2 <= 0; A1 <= 0; A0 <= 0; AN <= 0;
                    B3 <= 0; B2 <= 0; B1 <= 0; B0 <= 0; BN <= 0;
                end    
                end
                
                S12:
                begin
                end
                  
            endcase                      
    end                         

    always @*
    begin
        out_error = 0;
        case(state)
            S0:
            begin
                Z4 = blank; Z3 = blank; Z2 = blank; Z1 = blank;
                Z0 = 0;                        
            end
            
            S1:
            begin
                Z4 = blank; Z3 = blank; Z2 = blank;       
                if(AN)                  
                    Z1 = negative;
                else
                    Z1 = blank;
                
                Z0 = A0;    
            end
            
            S2: 
            begin
                Z4 = blank; Z3 = blank;       
                if(AN)                  
                    Z2 = negative;
                else
                    Z2 = blank;
                Z1 = A1;
                Z0 = A0;    
            end
            
            S3:
            begin
                Z4 = blank;       
                if(AN)                  
                    Z3 = negative;
                else
                    Z3 = blank;
                Z2 = A2;
                Z1 = A1;
                Z0 = A0;    
            end
            
            S4:
            begin
                if(AN)
                    Z4 = negative;
                else
                    Z4 = blank;
                Z3 = A3;
                Z2 = A2;
                Z1 = A1;
                Z0 = A0;
            end
            
            S5:
            begin   
            if(A3 != 0)
            begin
                if(AN)
                    Z4 = negative;
                else
                    Z4 = blank;
            Z3 = A3; 
            Z2 = A2; 
            Z1 = A1; 
            Z0 = A0;
            end
            
            else if(A2 != 0)
            begin
                Z4 = blank;
                if(AN)
                    Z3 = negative;
                else
                    Z3 = blank;
                
                Z2 = A2; 
                Z1 = A1; 
                Z0 = A0;
            end
            
            else if (A1 != 0)
            begin
                Z4 = blank; Z3 = blank;
                if(AN)
                    Z2 = negative;
                else
                    Z2 = blank;
                
                Z1 = A1;
                Z0 = A0;
            end                                        
                                
            else if (A0 != 0)
            begin
                Z4 = blank; Z3 = blank; Z2 = blank;
                if(AN)
                    Z1 = negative;
                else
                    Z1 = blank;
                
                Z0 = A0;
            end
            
            else if(A0 == 0)
            begin
                Z4 = blank; Z3 = blank; Z2 = blank; Z1 = blank;
                Z0 = A0;            
            end        
            end
            
            S6:
            begin
                Z4 = blank; Z3 = blank; Z2 = blank; 
                if(BN)
                    Z1 = negative;
                else
                    Z1 = blank;    
                Z0 = B0;    
            end
            
            S7:
            begin
                Z4 = blank; Z3 = blank;
                if(BN)
                    Z2 = negative;
                else
                    Z2 = blank;
                Z1 = B1;
                Z0 = B0;
            end
            
            S8:
            begin
                Z4 = blank;
                if(BN)
                    Z3 = negative;
                else
                    Z3 = blank;
                    
                Z2 = B2;
                Z1 = B1;
                Z0 = B0;
            end
            
            S9:
            begin
                if(BN)
                    Z4 = negative;
                else
                    Z4 = blank;
                    
                Z3 = B3;
                Z2 = B2;    
                Z1 = B1;
                Z0 = B0;                 
            end
            
            S10:
            begin   
            if(A3 != 0)
            begin
                if(AN)
                    Z4 = negative;
                else
                    Z4 = blank;
            Z3 = A3; 
            Z2 = A2; 
            Z1 = A1; 
            Z0 = A0;
            end
            
            else if(A2 != 0)
            begin
                Z4 = blank;
                if(AN)
                    Z3 = negative;
                else
                    Z3 = blank;
                
                Z2 = A2; 
                Z1 = A1; 
                Z0 = A0;
            end
            
            else if (A1 != 0)
            begin
                Z4 = blank; Z3 = blank;
                if(AN)
                    Z2 = negative;
                else
                    Z2 = blank;
                
                Z1 = A1;
                Z0 = A0;
            end                                        
                                
            else if (A0 != 0)
            begin
                Z4 = blank; Z3 = blank; Z2 = blank;
                if(AN)
                    Z1 = negative;
                else
                    Z1 = blank;
                
                Z0 = A0;
            end
            
            else
            begin
                Z4 = blank; Z3 = blank; Z2 = blank; Z1 = blank;
                Z0 = A0;            
            end        
            end
            
            
            S12:
            begin
                out_error = 1;
                Z4 = error_E;
                Z3 = error_E;
                Z2 = error_E;
                Z1 = error_E;
                Z0 = error_E;
            end
                 
    endcase
end                        
          
endmodule
