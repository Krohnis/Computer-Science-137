//Ricky Gutierrez
//CSC 137, Section 3
//Assignment #1
//decoder2x4.v

module DecoderMod(s0, s1, o0, o1, o2, o3);
	input s0, s1;
	output o0, o1, o2, o3;

	assign o0 = (~s0) & (~s1);
	assign o1 = s0 & (~s1);
	assign o2 = (~s0) & s1;
	assign o3 = s0 & s1;
endmodule

module TestMod;
	reg s0, s1;
	wire o0, o1, o2, o3;

	DecoderMod my_decoder(s0, s1, o0, o1, o2, o3);

	initial begin
		$monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b", $time, s0, s1, o0, o1, o2, o3);
		$display("Time\ts0\ts1\to0\to1\to2\to3");
		$display("--------------------------------------------------");
	end
	
	initial begin
		s0 = 0; s1 = 0; #1;
		s0 = 1; s1 = 0; #1;
		s0 = 0; s1 = 1; #1;
		s0 = 1; s1 = 1; #1;
	end
endmodule
