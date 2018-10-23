module DecoderMod(s, o);
	input [0:0] s;
	output [0:1] o;

	not(o[0], s[0]);
	assign o[1] = s[0];
endmodule

module MuxMod(s, d, o);
	input s;
	input [0:1] d;
	output o;

	wire[0:1] s_decoded, and_out;
	DecoderMod my_decoder(s, s_decoded);

	and(and_out[0], d[0], s_decoded[0]);
	and(and_out[1], d[1], s_decoded[1]);
	or(o, and_out[0], and_out[1]);
endmodule

module TestMod;
	reg s;
	reg [0:1] d;
	wire o;

	MuxMod my_mux(s, d, o);

	initial begin
		$display("Time\ts\td0\td1\to");
		$display("-------------------------------");
		$monitor("%0d\t%b\t%b\t%b\t%b", $time, s, d[0], d[1], o);
	end

	initial begin
		s = 0; d[0] = 0; d[1] = 0; #1;
		s = 0; d[0] = 0; d[1] = 1; #1;
		s = 0; d[0] = 1; d[1] = 0; #1;
		s = 0; d[0] = 1; d[1] = 1; #1;
		s = 1; d[0] = 0; d[1] = 0; #1;
		s = 1; d[0] = 0; d[1] = 1; #1;
		s = 1; d[0] = 1; d[1] = 0; #1;
		s = 1; d[0] = 1; d[1] = 1; #1;
	end
endmodule
