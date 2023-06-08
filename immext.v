`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 19:43:55
// Design Name: 
// Module Name: immext
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


module immext(
    input [31:0] inst,
    input sext,
    input i_lui,
    input i_sw,
    input shift,
    input [1:0] pcsource,
    output [31:0] immediate
    );
    wire e;
    wire [31:0]lui_imm, shift_imm, sw_imm, branchpc_offset, jalpc_offset, itype_imm;
    assign e = sext & inst[31];
    assign lui_imm = {inst[31:12], 12'b0};
    assign shift_imm = {{27{1'b0}}, inst[24:20]};
    assign sw_imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    assign branchpc_offset = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
    assign jalpc_offset = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
    assign itype_imm = {{20{e}}, inst[31:20]};
    
    assign immediate =  
    i_lui ? lui_imm:                        
    shift ? shift_imm:
    i_sw ? sw_imm:
    (pcsource == 2'b01) ? branchpc_offset:
    (pcsource == 2'b11) ? jalpc_offset:
    itype_imm;
    
endmodule
