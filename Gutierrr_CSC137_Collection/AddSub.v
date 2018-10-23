//Ricky Gutierrez
//Assignment #4, CSC137
//AddSub.v

module TestMod;
	parameter STDIN = 32'h8000_0000;

	reg [7:0] str [1:3];
	reg [4:0] X, Y;
	reg C0;
	wire C4, C5, E;
	wire [4:0] S;

	AdderSubtractorMod myAddSub(X, Y, S, C0, C4, C5, E);

	initial begin
		$display("Enter X: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);
		str[3] = $fgetc(STDIN);
		X = (str[1] - 48) * 10 + (str[2] - 48);

		$display("Enter Y: ");
                str[1] = $fgetc(STDIN);
                str[2] = $fgetc(STDIN);
                str[3] = $fgetc(STDIN);
                Y = (str[1] - 48) * 10 + (str[2] - 48);

		$display("Enter operator: ");
		str[1] = $fgetc(STDIN);
		str[2] = $fgetc(STDIN);

		if(str[1] == 8'h2D) C0 = 1; 
		else C0 = 0;

		#10;

		$display("X = %d (%b), Y = %d (%b), C0 = %b", X, X, Y, Y, C0);
		$display("Result = %d (%b)", S, S);
		$display("C4 = %b, C5 = %b, E = %b", C4, C5, E);

		if(E == 0) $display("Since E is 0, C5 is not needed");
		else $display("Since E is 1, C5 is needed: %b%b", C5, S);
	end
endmodule

module AdderSubtractorMod(X, Y, S, C0, C4, C5, E);
	input C0;
	input [4:0] X, Y;
	output C4, C5, E;
	output [4:0] S;

	wire C1, C2, C3;
	wire [4:0] xorY;

	xor( xorY[0], C0, Y[0] );
	xor( xorY[1], C0, Y[1] );
	xor( xorY[2], C0, Y[2] );
	xor( xorY[3], C0, Y[3] );
	xor( xorY[4], C0, Y[4] );

	FullAdderMod FA0(X[0], xorY[0], S[0], C0, C1);
	FullAdderMod FA1(X[1], xorY[1], S[1], C1, C2);
	FullAdderMod FA2(X[2], xorY[2], S[2], C2, C3);
	FullAdderMod FA3(X[3], xorY[3], S[3], C3, C4);
	FullAdderMod FA4(X[4], xorY[4], S[4], C4, C5);

	xor(E, C4, C5);
endmodule

module FullAdderMod(X, Y, S, cIn, cOut);
	input X, Y, cIn;
	output S, cOut;
	wire and0, and1, xor0;

	xor(xor0, X, Y);
	xor(S, xor0, cIn);

	and(and0, X, Y);
	and(and1, xor0, cIn);
	or(cOut, and0, and1);
endmodule


