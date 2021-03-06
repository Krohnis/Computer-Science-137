//Ricky Gu tierrez
//CSC137, Section 3
//Assignment #2
//m4x1.v

module DecoderMod(s, o);
        input [0:1] s;
        output [0:3] o;
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

module MuxMod(s, d, o);
        input [0:1] s;
        input [0:3] d;
        output o;

        wire [0:3] and_result, s_decoded;
	wire [0:1] or_result;

        DecoderMod my_decoder(s, s_decoded);

        and(and_result[0], d[0], s_decoded[0]);
        and(and_result[1], d[1], s_decoded[1]);
        and(and_result[2], d[2], s_decoded[2]);
        and(and_result[3], d[3], s_decoded[3]);
	or(or_result[0], and_result[0], and_result[1]);
	or(or_result[1], and_result[2], and_result[3]);
        or(o, or_result[0], or_result[1]);
endmodule

module TestMod;
        reg [0:1] s;
        reg [0:3] d;
        wire o;

        MuxMod my_mux(s, d, o);

        initial begin
                $display("Time\ts[0]\ts[1]\td[0]\td[1]\td[2]\td[3]\to");
                $display("----------------------------------------------------------");
                $monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t", $time, s[0], s[1], d[0], d[1], d[2], d[3], o);
        end

        initial begin
//#1
	s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 1; #1;       
	s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#2
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#3
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#4
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 0; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#5
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#6
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 0; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#7
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 1; #1;
//#8
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 0; d[2] = 1; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; #1;
        s[0] = 1; s[1] = 1; d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 1; #1;
	end
endmodule
