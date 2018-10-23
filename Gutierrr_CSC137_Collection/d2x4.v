//Ricky Gutierrez
//CSC137, Section 3
//Assignment #2
//d2x4.v

module DecoderMod(s, o);
	input [0:1] s;
	output [0:3] o;
	wire [0:3] e;
	wire [0:1] inv_s;

	not(inv_s[0], s[0]);
	not(inv_s[1], s[1]);	

	and(o[0], inv_s[0], inv_s[1]);
	and(o[1], s[0], inv_s[1]);
	and(o[2], inv_s[0], s[1]);
	and(o[3], s[0], s[1]);
	/*
	assign o[0] = (~s[0]) & (~s[1]);
	assign o[1] = s[0] & (~s[1]);
	assign o[2] = (~s[0]) & s[1];
	assign o[3] = s[0] & s[1];
	*/
endmodule

module TestMod;
	reg [0:1] s;
	wire [0:3] o;

	DecoderMod my_decoder(s, o);

	initial begin
		$monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b", $time, s[0], s[1], o[0], o[1], o[2], o[3]);
		$display("Time\ts[0]\ts[1]\to[0]\to[1]\to[2]\to[3]");
		$display("----------------------------------------------------");
	end

	initial begin
		s[0] = 0; s[1] = 0; #1;
		s[0] = 1; s[1] = 0; #1;
		s[0] = 0; s[1] = 1; #1;
		s[0] = 1; s[1] = 1; #1;
	end
endmodule
