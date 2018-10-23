//Adder.v, CSC137 Verilog Programming Assignment #3
//Adding Number, 5 bits maximum
//Ricky Gutierrez

module TestMod;
	parameter STDIN = 32'h8000_0000;

	reg [7:0] str [1:3];
	reg C0;
	reg [4:0] X, Y;
	wire [4:0] S;
	wire C4, C5, E;

	BigAdder myAdderSuber(X, Y, S, C0, C4, C5, E);

	initial begin
		$display("Enter X: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);
		str[3] = $fgetc(STDIN);
		assign X = (str[1] - 48) * 10 + str[2] - 48;

		$display("Enter Y: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);
		str[3] = $fgetc(STDIN);
		assign Y = (str[1] - 48) * 10 + str[2] - 48;

		$display("Enter operator: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);

                $display("X = %0d (%b) Y = %0d (%b)", X, X, Y, Y );
		if(str[1] == 8'h2D) begin C0 = 1; assign Y = Y - 1; end
		else C0 = 0;
		#10;

		$display("Result = %0d (%b)", S, S);
		$display("C4 = %b, C5 = %b, E = %b", C4, C5, E);
		if(E == 0) $display("Since E is 0, C5 is not needed");
		else $display("Since E is 1, C5 is needed %b%b", C5, S);
	end
endmodule

module BigAdder(X, Y, S, C0, C4, C5, E);
	input [4:0] X, Y;
	input C0;
	output [4:0] S;
	output C4, C5, E;
	wire [5:1] C;

	FullAdderMod g0(S[0], 0, C[1], X[0], Y[0], C0);
	FullAdderMod g1(S[1], C[1], C[2], X[1], Y[1], C0);
	FullAdderMod g2(S[2], C[2], C[3], X[2], Y[2], C0);
	FullAdderMod g3(S[3], C[3], C[4], X[3], Y[3], C0);
	FullAdderMod g4(S[4], C[4], C[5], X[4], Y[4], C0);

	assign C4 = C[4];
	assign C5 = C[5];
	xor(E, C[4], C[5]);

endmodule

module FullAdderMod(S, cIn, cOut, X, Y, C0);
	input X, Y, cIn, C0;
	output S, cOut;
	wire [4:0] B;
	wire xorY;

	xor(xorY, Y, C0);

	xor(B[0], X, xorY);
	xor(S, B[0], cIn);
	and(B[1], cIn, X);
	and(B[2], cIn, xorY);
	and(B[3], X, xorY);
	or(B[4], B[1], B[2]);
	or(cOut, B[3], B[4]);

	/*assign S = (X ^ xorY) ^ cIn;
	assign cOut = (X & xorY) | (cIn & X) | (cIn & xorY);*/
endmodule
