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
	output wire memwriteM,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM 
    );
	
	wire [5:0] opD,functD;
	wire regdstE,alusrcE,pcsrcD,memtoregE,memtoregM,memtoregW,
			regwriteE,regwriteM,regwriteW;
	wire hilowriteM;
	wire [7:0] alucontrolE;
	wire flushE,equalD;

	controller c(
		clk,rst,
		//decode stage
		opD,functD,
		pcsrcD,branchD,equalD,jumpD,
		
		//execute stage
		stallE, flushE,
		memtoregE,alusrcE,
		regdstE,regwriteE,	
		alucontrolE,

		//mem stage
		stallM, flushM,
		memtoregM,memwriteM,
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
		pcsrcD,branchD,
		jumpD,
		equalD,
		opD,functD,
		//execute stage
		memtoregE,
		alusrcE,regdstE,
		regwriteE,
		alucontrolE,
		stallE,flushE,
		//mem stage
		memtoregM,
		regwriteM,
		aluoutM,writedataM,
		readdataM,
		hilowriteM,
		stallM,flushM,
		//writeback stage
		memtoregW,
		regwriteW,
		stallW,flushW
	    );
	
endmodule
