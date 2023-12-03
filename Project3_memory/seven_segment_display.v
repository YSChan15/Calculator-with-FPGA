`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2022 22:04:28
// Design Name: 
// Module Name: seven_segment_display
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


module seven_segment_display(A,X);
    input [3:0]A;
    output reg [1:7]X;
    
    always @(A)
    begin
        //Default value, active low 
        //X[1] = 1; X[2] = 1; X[3] = 1; X[4] = 1; X[5] = 1; X[6] = 1; X[7] = 1;
        X = 7'b1111111;
        
        case (A)
            0:
            begin
            X = 7'b0000001;
            //X[1] = 0; X[2] = 0; X[3] = 0; X[4] = 0; X[5] = 0; X[6] = 0;
            end
            
            1:
            begin
            X = 7'b1001111;
            //X[2] = 0; X[3] = 0;
            end
            
            2:
            begin
            X = 7'b0010010;
            //X[1] = 0; X[2] = 0; X[4] = 0; X[5] = 0; X[7] = 0;
            end
            
            3:
            begin 
            X = 7'b0000110;
            //X[1] = 0; X[2] = 0; X[3] = 0; X[4] = 0; X[7] = 0;
            end
            
            4:
            begin
            X = 7'b1001100;
            //X[2] = 0; X[3] = 0; X[6] = 0; X[7] = 0;
            end
            
            5:
            begin
            X = 7'b0100100;
            //X[1] = 0; X[3] = 0; X[4] = 0; X[6] = 0; X[7] = 0;
            end
            
            6:
            begin
            X = 7'b0100000;
            //X[1] = 0; X[3] = 0; X[4] = 0; X[5] = 0; X[6] = 0; X[7] = 0;
            end
            
            7:
            begin
             X = 7'b0001111;
            //X[1] = 0; X[2] = 0; X[3] = 0;
            end
            
            8:
            begin
             X = 7'b0000000;
            //X[1] = 0; X[2] = 0; X[3] = 0; X[4] = 0; X[5] = 0; X[6] = 0; X[7] = 0;
            end
            
            9:
            begin
            X = 7'b0000100;
            //X[1] = 0; X[2] = 0; X[3] = 0; X[4] = 0; X[6] = 0; X[7] = 0;
            end
            
            12:
            begin
            X = 7'b0110000;
            end
            
            15:
            begin
            X = 7'b1111110;
            end
            
            default:
            begin
            X = 7'b1111111;
            //X[1] = 1; X[2] = 1; X[3] = 1; X[4] = 1; X[5] = 1; X[6] = 1; X[7] = 1;
            end
            
            endcase
      end
endmodule
