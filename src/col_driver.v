// define independent ports for virtuoso design

module col_driver (
	input        w_en,
	input  [7:0] data,
	output [7:0] BL,
	output [7:0] BLB
 );
	assign BL  = w_en ? data  : 8'bz;
	assign BLB = w_en ? ~data : 8'bz;
endmodule