///////////////////////////////////////////////////////////
//32-bit Carry Look Ahead Adder 
///////////////////////////////////////////////////////////
 
`timescale 1ns / 1ps
module cla32(
	o_sum,
	o_c,
	a,
	b, 
	cin		);

output	[31:0]	o_sum	;
output		o_c	;

input	[31:0]	a	;
input	[31:0]	b	;
input 		cin	;


wire c0,c1,c2,c3,c4,c5,c6;

cla4 cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(o_sum[3:0]), .cout(c0));
cla4 cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c0), .sum(o_sum[7:4]), .cout(c1));
cla4 cla3(.a(a[11:8]), .b(b[11:8]), .cin(c1), .sum(o_sum[11:8]), .cout(c2));
cla4 cla4(.a(a[15:12]), .b(b[15:12]), .cin(c2), .sum(o_sum[15:12]), .cout(c3));
cla4 cla5 (.a(a[19:16]), .b(b[19:16]), .cin(c3), .sum(o_sum[19:16]), .cout(c4));
cla4 cla6 (.a(a[23:20]), .b(b[23:20]), .cin(c4), .sum(o_sum[23:20]), .cout(c5));
cla4 cla7(.a(a[27:24]), .b(b[27:24]), .cin(c5), .sum(o_sum[27:24]), .cout(c6));
cla4 cla8(.a(a[31:28]), .b(b[31:28]), .cin(c6), .sum(o_sum[31:28]), .cout(o_c)); 

endmodule
 
////////////////////////////////////////////////////////
//4-bit Carry Look Ahead Adder 
////////////////////////////////////////////////////////
 
module cla4(
	sum,
	cout,
	a,
	b, 
	cin		);

output	[3:0]	sum	;
output	cout		;

input	[3:0]	a	;
input	[3:0]	b	;
input		cin	;

wire	[3:0]	p	;
wire	[3:0]	g	;
wire	[3:0]	c	;
 
assign		p=a^b	;	//propagate
assign		g=a&b	; 	//generate
 
//carry=gi + Pi.ci
 
assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;
 
endmodule
