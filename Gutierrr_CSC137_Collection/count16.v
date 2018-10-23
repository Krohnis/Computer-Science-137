//CSC137, Chang
//Assignment #5
//count16.v

module TestMod;
	reg CLK;
	wire [15:0] Q;
	wire [3:0] C;

	always begin
		CLK = 0;
		#1;
		CLK = 1;
		#1;
	end

	RippleMod myRipple(CLK, Q);
	CoderMod myCoder(Q, C);

	initial #64 $finish;

	initial begin
		$display("		Time Q                C	   CLK");
		$display("----------------------------------------------------------------");
		$monitor("%d %b %b %b", $time, Q, C, CLK);
	end
endmodule

module CoderMod(Q, C);
	input [15:0] Q;
	output [3:0] C;
	wire [12:0] O;
	wire [7:0] Ou;

	//C[0]
	or(O[0], Q[1], Q[5]);
	or(O[1], Q[6], Q[7]);
	or(O[2], Q[12], Q[13]);
	or(O[3], Q[14], Q[15]);
	or(Ou[0], O[0], O[1]);
	or(Ou[1], O[2], O[3]);
	or(C[0], Ou[0], Ou[1]);
	//C[1]
	or(O[4], Q[2], Q[5]);
	or(O[5], Q[8], Q[10]);
	or(O[6], Q[11], Q[13]);
	or(Ou[2], O[4], O[5]);
	or(Ou[3], O[3], O[6]);
	or(C[1], Ou[2], Ou[3]);
	//C[2]
	or(O[7], Q[3], Q[6]);
	or(O[8], Q[9], Q[10]);
	or(O[9], Q[11], Q[12]);
	or(Ou[4], O[3], O[7]);
	or(Ou[5], O[8], O[9]);
	or(C[2], Ou[4], Ou[5]);
	//C[3]
	or(O[10], Q[4], Q[7]);
	or(O[11], Q[8], Q[9]);
	or(O[12], Q[13], Q[15]);
	or(Ou[6], O[9], O[10]);
	or(Ou[7], O[11], O[12]);
	or(C[3], Ou[6], Ou[7]);
endmodule

module RippleMod(CLK, Q);
	input CLK;
	output [15:0] Q;
	reg [15:0] Q;

	always @(posedge CLK) begin
		Q[0] <= Q[15];
		Q[1] <= Q[0];
		Q[2] <= Q[1];
		Q[3] <= Q[2];
		Q[4] <= Q[3];
		Q[5] <= Q[4];
		Q[6] <= Q[5];
		Q[7] <= Q[6];
		Q[8] <= Q[7];
		Q[9] <= Q[8];
		Q[10] <= Q[9];
		Q[11] <= Q[10];
		Q[12] <= Q[11];
		Q[13] <= Q[12];
		Q[14] <= Q[13];
		Q[15] <= Q[14];
	end

	initial begin
		Q[0] = 1;
		Q[1] = 0;
		Q[2] = 0;
		Q[3] = 0;
		Q[4] = 0;
		Q[5] = 0;
		Q[6] = 0;
		Q[7] = 0;
		Q[8] = 0;
		Q[9] = 0;
		Q[10] = 0;
		Q[11] = 0;
		Q[12] = 0;
		Q[13] = 0;
		Q[14] = 0;
		Q[15] = 0;
	end
endmodule
