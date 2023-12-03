`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 14:47:33
// Design Name: 
// Module Name: project3_top
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


module project3_top(column,row,seg,an,CLK100MHZ,reset,out_error,operator);
    input reset;
    input CLK100MHZ;
    
    input [0:3]column;
    output [0:3]row;
    
    output [0:7]seg;
    output [0:7]an;
    
    output out_error;
    parameter blank = 7'b1111111;
    
    wire slower_clock;
    slower_clock SC1 (.CLK100MHZ(CLK100MHZ), .slower_clock(slower_clock));
    
    wire [3:0]digit;
    wire push;
    
    keypad_lab11 KL11 (.clock(slower_clock), .column(column), .row(row), .digit(digit), .push(push), .reset(reset));
    
    wire [3:0]BCD3;
    wire [3:0]BCD2;
    wire [3:0]BCD1;
    wire [3:0]BCD0;
    wire negative_sign;
    wire error;
    
    wire [3:0]A3;
    wire [3:0]A2;
    wire [3:0]A1;
    wire [3:0]A0;
    wire AN;
    
    wire [3:0]B3;
    wire [3:0]B2;
    wire [3:0]B1;
    wire [3:0]B0;
    wire BN;
    
    wire [3:0]Z4;
    wire [3:0]Z3;
    wire [3:0]Z2;
    wire [3:0]Z1;
    wire [3:0]Z0;
    
    output [3:0]operator;
    
    calculator CAL1 (.push(push), .reset(reset), .digit(digit), .BCD3(BCD3), .BCD2(BCD2), .BCD1(BCD1), .BCD0(BCD0),
    .negative_sign(negative_sign), .error(error), .A3(A3), .A2(A2), .A1(A1), .A0(A0), .AN(AN), .B3(B3), .B2(B2),
    .B1(B1), .B0(B0), .BN(BN), .Z4(Z4), .Z3(Z3) , .Z2(Z2), .Z1(Z1), .Z0(Z0), .operator(operator), 
    .out_error(out_error));
    
    wire [15:0]out;
    wire negout;
    
    operator O1 (.A3(A3), .A2(A2), .A1(A1), .A0(A0), .AN(AN), .B3(B3), .B2(B2), .B1(B1), .B0(B0), .BN(BN),
    .operator(operator), .out(out), .negout(negout), .error(error));
    
    decimal_BCD_converter DBC1 (.decimal(out), .negative(negout), .error(error), .BCD3(BCD3), .BCD2(BCD2), 
    .BCD1(BCD1), .BCD0(BCD0), .negative_sign(negative_sign));
    
    wire [1:7]X4;
    wire [1:7]X3;
    wire [1:7]X2;
    wire [1:7]X1;
    wire [1:7]X0;
    
    seven_segment_display SS5 (.A(Z4), .X(X4));
    seven_segment_display SS4 (.A(Z3), .X(X3));
    seven_segment_display SS3 (.A(Z2), .X(X2));
    seven_segment_display SS2 (.A(Z1), .X(X1));
    seven_segment_display SS1 (.A(Z0), .X(X0));
    
    sSegDisplay_8 (.ck(CLK100MHZ), .digit0(blank), .digit1(blank), .digit2(blank), 
    .digit3(X4), .digit4(X3), .digit5(X2), .digit6(X1), .digit7(X0), .seg(seg), .an(an));
endmodule

