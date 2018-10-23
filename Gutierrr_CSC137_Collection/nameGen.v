//Ricky Gutierrez
//Assignment #6
//pattern.v

module TestMod;
	reg CLK;
	wire [4:0] Q;
	wire [7:0] C;

	always begin
		CLK = 0;
		#1;
		CLK = 1;
		#1;
	end

	RippleMod my_ripple(CLK, Q);
	CoderMod my_Coder(Q, C);

	initial #20 $finish;

	initial begin
		$display("		Time	Q	ASCII	 C  CLK");
		$display("---------------------------------------------------------");
		$monitor("%d	%b	%b %c    %b", $time, Q, C, C, CLK);
	end
endmodule

module CoderMod(Q, C);
	input [4:0] Q;
	output [7:0] C;
	wire [3:0] O;

	//C[0]
	or(O[0], Q[1], Q[2]);
	or(O[1], Q[3], Q[4]);
	or(C[0], O[0], O[1]);
	//C[1]
	or(O[2], Q[0], Q[2]);
	or(C[1], O[2], Q[3]);
	//C[2] (Always 0)
	assign C[2] = 0;
	//C[3]
	or(O[3], Q[1], Q[3]);
	or(C[3], O[3], Q[4]);
	//C[4]
	or(C[4], Q[0], Q[4]);
	//C[5] (Always 0)
	assign C[5] = 0;
	//C[6] (Always 1)
	assign C[6] = 1;
	//C[7] (Always 0)
	assign C[7] = 0;

endmodule

module RippleMod(CLK, Q);
	input CLK;
	output [4:0] Q;

	reg [4:0] Q;

        always @(posedge CLK) begin
		Q[0] <= Q[4];
		Q[1] <= Q[0];
		Q[2] <= Q[1];
		Q[3] <= Q[2];
		Q[4] <= Q[3];
	end

	initial begin
		Q[0] = 1;
		Q[1] = 0;
		Q[2] = 0;
		Q[3] = 0;
		Q[4] = 0;
	end
endmodule
