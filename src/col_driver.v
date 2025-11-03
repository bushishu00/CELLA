// define independent ports for virtuoso design

module col_driver (
	input            clk,
	input            cs,
	input            w_en,
	input      [7:0] data,
	output reg [7:0] BL,
	output reg [7:0] BLB
 );
	always@(posedge clk or negedge cs) begin
		if (!cs) begin
			BL  = 8'bz;
			BLB = 8'bz;
		end
		else if (w_en) begin
			BL  = data;
			BLB = ~data;
		end
		else begin
			BL  = 8'bz;
			BLB = 8'bz;
		end
	end
endmodule