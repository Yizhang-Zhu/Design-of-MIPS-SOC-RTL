`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: controller
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


module controller(
	input wire clk,rst,
	//decode stage
	input wire[5:0] opD,functD,
	output wire pcsrcD,branchD,equalD,jumpD,
	
	//execute stage
	input wire stallE, flushE,
	output wire memtoregE,alusrcE,
	output wire regdstE,regwriteE,	
	output wire[7:0] alucontrolE,

	//mem stage
	input wire stallM, flushM,
	output wire memtoregM,memwriteM,
				regwriteM,hilowriteM,
	//write back stage
	input wire stallW, flushW,
	output wire memtoregW,regwriteW

    );
	
	//decode stage
	wire[1:0] aluopD;
	wire memtoregD,memwriteD,alusrcD,
		regdstD,regwriteD;
	wire[7:0] alucontrolD;
	wire hilowriteD;

	//execute stage
	wire memwriteE;
	wire hilowriteE;


	maindec md(
		opD,
		functD,
		memtoregD,memwriteD,
		branchD,alusrcD,
		regdstD,regwriteD,
		jumpD,
		aluopD,
		hilowriteD
		);
	aludec ad(functD,opD,alucontrolD);

	assign pcsrcD = branchD & equalD;

	//pipeline registers
	flopenrc #(17) regE(
		clk,rst,
		~stallE,
		flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD,hilowriteD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE,hilowriteE}
		);
	flopenrc #(9) regM(
		clk,rst,
		~stallM,
		flushM,
		{memtoregE,memwriteE,regwriteE,hilowriteE},
		{memtoregM,memwriteM,regwriteM,hilowriteM}
		);
	flopenrc #(8) regW(
		clk,rst,
		~stallW,
		flushW,
		{memtoregM,regwriteM},
		{memtoregW,regwriteW}
		);
endmodule
