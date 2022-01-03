`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: maindec
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


module maindec(
	input wire[5:0] op,
	input wire[5:0] funct,

	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[1:0] aluop,
	output wire hilowrite
    );
	reg[9:0] controls;
	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop, hilowrite} = controls;
	always @(*) begin
		case (op)
			6'b000000: case(funct)
				`EXE_MFHI:controls <= 10'b1100000100;//mfhi
				`EXE_MTHI:controls <= 10'b0100000101;//mthi
				`EXE_MFLO:controls <= 10'b1100000100;//mflo
				`EXE_MTLO:controls <= 10'b0100000101;//mtlo
				default:controls <= 10'b1100000100;//R-TYRE
			endcase
			6'b001100:controls <= 10'b1010000000;//andi
			6'b001110:controls <= 10'b1010000000;//xori
			6'b001111:controls <= 10'b1010000000;//lui
			6'b001101:controls <= 10'b1010000000;//ori

			// `EXE_SLL:controls <= 9'b
			// `EXE_SRL:controls <= 
			// `EXE_SRA:controls <= 
			// `EXE_SLLV:controls <=
			// `EXE_SRLV:controls <=
			// `EXE_SRAV:controls <=
			6'b100011:controls <= 10'b1010010000;//LW
			6'b101011:controls <= 10'b0010100000;//SW
			6'b000100:controls <= 10'b0001000010;//BEQ
			6'b001000:controls <= 10'b1010000000;//ADDI
			
			6'b000010:controls <= 10'b0000001000;//J
			default:  controls <= 10'b0000000000;//illegal op
		endcase
	end
endmodule
