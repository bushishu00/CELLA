module array_ctrl (
    input        clk,
    input        rst_n,
    input [7:0]  word,
    input [1:0]  op_code,
    input [3:0]  bank_sel,
    output       mac_en,
    output       read_bar,
    output       w_en,
    output[15:0] bank_en
);
    assign mac_en   = (op_code == 2'b00) ? 1'b1 : 1'b0;
    assign read_bar = (op_code == 2'b01) ? 1'b0 : 1'b1;
    assign w_en     = (op_code == 2'b10) ? 1'b1 : 1'b0;

    assign bank_en[0]  = bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
    assign bank_en[1]  = bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
    assign bank_en[2]  = bank_sel[3] & ~bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
    assign bank_en[3]  = bank_sel[3] & ~bank_sel[2] &  bank_sel[1] &  bank_sel[0];
    assign bank_en[4]  = bank_sel[3] &  bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
    assign bank_en[5]  = bank_sel[3] &  bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
    assign bank_en[6]  = bank_sel[3] &  bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
    assign bank_en[7]  = bank_sel[3] &  bank_sel[2] &  bank_sel[1] &  bank_sel[0];
    assign bank_en[8]  = bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
    assign bank_en[9]  = bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
    assign bank_en[10] = bank_sel[3] & ~bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
    assign bank_en[11] = bank_sel[3] & ~bank_sel[2] &  bank_sel[1] &  bank_sel[0];
    assign bank_en[12] = bank_sel[3] &  bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
    assign bank_en[13] = bank_sel[3] &  bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
    assign bank_en[14] = bank_sel[3] &  bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
    assign bank_en[15] = bank_sel[3] &  bank_sel[2] &  bank_sel[1] &  bank_sel[0];
endmodule