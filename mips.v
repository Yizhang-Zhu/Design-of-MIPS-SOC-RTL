`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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


module mips(
	input wire clk,rst,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire [3:0]memwriteM,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM 
    );
	
	wire [5:0] opD,functD;
	wire [1:0] regdstE; 
	wire alusrcE,pcsrcD,memtoregE,memtoregM,memtoregW,
			regwriteE,regwriteM,regwriteW;
	wire hilowriteM;
	wire [7:0] alucontrolE;
	wire flushE,equalD;
	wire [3:0] memwriteD;
	wire [2:0] memop;
    wire [4:0] rtD;
    wire [1:0]jumpop;
    wire jbalE;

	controller c(
		clk,rst,
		//decode stage
		opD,functD,rtD,
		// pcsrcD,
		branchD,
		// equalD,
		jumpD,
		memwriteD,
		memop,
		jumpop,
		//execute stage
		stallE, flushE,
		memtoregE,alusrcE,
		regdstE,regwriteE,	
		alucontrolE,
		jbalE,
		//mem stage
		stallM, flushM,
		memtoregM,
		// memwriteM,
		regwriteM,hilowriteM,
		//write back stage
		stallW, flushW,
		memtoregW,regwriteW
		);
	datapath dp(
		clk,rst,
		//fetch stage
		pcF,
		instrF,
		//decode stage
		// pcsrcD,
		branchD,
		jumpD,
		// equalD,
		opD,functD,rtD,
		jumpop,
		memwriteD,
		memop,
		//execute stage
		memtoregE,
		alusrcE,regdstE,
		regwriteE,
		alucontrolE,
		jbalE,
		stallE,flushE,
		//mem stage
		memtoregM,
		regwriteM,
		aluoutM,writedataM,
		readdataM,
		memwriteM,
		hilowriteM,
		stallM,flushM,
		//writeback stage
		memtoregW,
		regwriteW,
		stallW,flushW
	    );
	
endmodule
