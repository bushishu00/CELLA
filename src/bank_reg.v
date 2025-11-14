module bank_reg (
	input [7:0] Din,
    input clk_inv,
    output reg [7:0] Q
);
    always@(negedge clk_inv) begin
        Q <= Din;
    end
endmodule