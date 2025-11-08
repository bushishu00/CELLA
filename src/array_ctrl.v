module array_ctrl (
    input             clk,
    input             rst_n,

    input   [1:0]     op_code,
    input   [8:0]     addr,

    input   [15:0]    data,
    input   [3:0]     bank_sel,

    output reg        mac_en,
    output reg        w_en,
    output reg [15:0] data_op,
    output reg [15:0] bank_mux,
    output reg [7:0]  col_mux
);  


endmodule