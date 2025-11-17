module array_ctrl (
    input         clk,
    input         clk_inv,
    input         rst_n,

    input  [1:0]  op_code,
    input  [8:0]  addr,

    input  [15:0] data_bank,
    input  [15:0] data_in,

    output        mac_en,
    output [15:0] data_op,
    output [15:0] bank_mux,
    output [1:0]  addr_row,
    output        w_en,

    output [15:0] data_and,
    output [7:0]  col_mux,

    output        clk_copy,
    output [3:0]  query_bar
);  
// register input and decode them
    wire        mac_en_w;
    wire [15:0] data_op_w;
    wire [15:0] bank_mux_w;
    wire [1:0]  addr_row_w;
    wire        w_en_w;
    wire [15:0] data_and_w;
    wire [7:0]  col_mux_w;
// for glitch
	wire [3:0] query_bar_w;

    array_decoder decoder(
    .clk(clk),
    .rst_n(rst_n),
    .op_code(op_code),
    .addr(addr),
    .data_bank(data_bank),
    .data_in(data_in),

    .mac_en(mac_en_w),
    .data_op(data_op_w),
    .bank_mux(bank_mux_w),
    .addr_row(addr_row_w),
    .w_en(w_en_w),

    .data_and(data_and_w),
    .col_mux(col_mux_w),

	.query_bar(query_bar_w)
    );

// create clock copy signal
    wire clk_copy_w;
    clk_copy copy (
    .clk(clk),
    .clk_inv(clk_inv),
    .rst_n(rst_n),

    .clk_copy(clk_copy_w)
    );

// connect all outputs  
    assign mac_en   = mac_en_w;
    assign data_op  = data_op_w;
    assign bank_mux = bank_mux_w;
    assign addr_row = addr_row_w;
    assign w_en     = w_en_w;

    assign data_and = data_and_w;
    assign col_mux  = col_mux_w;

    assign clk_copy = clk_copy_w;

	assign query_bar = query_bar_w;
endmodule
