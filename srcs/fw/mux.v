`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 04:04:14 PM
// Design Name: 
// Module Name: mux
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


module mux #(
    parameter WIDTH=1
    )
(
    input [WIDTH-1:0] I0,
    input [WIDTH-1:0] I1,
    input SEL,
    output [WIDTH-1 : 0] O
    );
    assign O = (SEL == 0)? I0 : I1;
endmodule
