module array_ctrl (
    input             clk,
    input             clk_inv,
    input             rst_n,

    input   [1:0]     op_code,
    input   [3:0]     addr_bank,
    input   [2:0]     addr_col,

    input   [15:0]    data_bank,
    input   [15:0]    data_in,

    output            clk_copy,

    output reg        mac_en,
    output reg [15:0] data_op,
    output reg [15:0] bank_mux,
    output reg        w_en,

    output reg        mac_en_neg,
    output reg [15:0] data_and,
    output reg [7:0]  col_mux
);  

    assign clk_copy = clk;

    // addr decode
    wire [15:0] bank_mux_w;
    wire [7:0]  col_mux_w;

    //4 to 16 decoder for bank selection
    assign bank_mux_w[15]=  addr_bank[3] &  addr_bank[2] &  addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[14]=  addr_bank[3] &  addr_bank[2] &  addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[13]=  addr_bank[3] &  addr_bank[2] & ~addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[12]=  addr_bank[3] &  addr_bank[2] & ~addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[11]=  addr_bank[3] & ~addr_bank[2] &  addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[10]=  addr_bank[3] & ~addr_bank[2] &  addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[9] =  addr_bank[3] & ~addr_bank[2] & ~addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[8] =  addr_bank[3] & ~addr_bank[2] & ~addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[7] = ~addr_bank[3] &  addr_bank[2] &  addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[6] = ~addr_bank[3] &  addr_bank[2] &  addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[5] = ~addr_bank[3] &  addr_bank[2] & ~addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[4] = ~addr_bank[3] &  addr_bank[2] & ~addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[3] = ~addr_bank[3] & ~addr_bank[2] &  addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[2] = ~addr_bank[3] & ~addr_bank[2] &  addr_bank[1] & ~addr_bank[0];
    assign bank_mux_w[1] = ~addr_bank[3] & ~addr_bank[2] & ~addr_bank[1] &  addr_bank[0];
    assign bank_mux_w[0] = ~addr_bank[3] & ~addr_bank[2] & ~addr_bank[1] & ~addr_bank[0];

    // 3 to 8 decoder for column selection
    assign col_mux_w[7]=  addr_col[2] &  addr_col[1] &  addr_col[0];
    assign col_mux_w[6]=  addr_col[2] &  addr_col[1] & ~addr_col[0];
    assign col_mux_w[5]=  addr_col[2] & ~addr_col[1] &  addr_col[0];
    assign col_mux_w[4]=  addr_col[2] & ~addr_col[1] & ~addr_col[0];
    assign col_mux_w[3]= ~addr_col[2] &  addr_col[1] &  addr_col[0];
    assign col_mux_w[2]= ~addr_col[2] &  addr_col[1] & ~addr_col[0];
    assign col_mux_w[1]= ~addr_col[2] & ~addr_col[1] &  addr_col[0];
    assign col_mux_w[0]= ~addr_col[2] & ~addr_col[1] & ~addr_col[0];

// bank control signals, directly out
    always@(*) begin
        if (op_code == 2'b00) begin
            mac_en   = 1'b1;
            w_en     = 1'b0;
            bank_mux = 16'b1111_1111_1111_1111;
            data_op  = data_bank;
        end
        else if (op_code == 2'b01) begin
            mac_en   = 1'b1;
            w_en     = 1'b1;
            bank_mux = bank_mux_w;
            data_op  = {8'b0000_0000, {data_bank[7:0]}};
        end
        else if (op_code == 2'b10) begin
            mac_en   = 1'b0;
            w_en     = 1'b0;
            bank_mux = 16'b1111_1111_1111_1111; 
            data_op  = {12'b0000_0000_0000, {data_bank[3:0]}};
        end
        else begin
            mac_en   = 1'b1;
            w_en     = 1'b0;
            bank_mux = 16'b0000_0000_0000_0000;
            data_op  = 16'b0000_0000_0000_0000;
        end
    end

// adder tree signal, sync to negedge clk
    always@(posedge clk_inv or negedge rst_n) begin
        if (!rst_n) begin
            col_mux    <= 8'b0000_0000;
            mac_en_neg <= 1'b1;
            data_and   <= 16'b0000_0000_0000_0000;
        end
        else if (op_code == 2'b00) begin
            col_mux    <= 8'b1111_1111;
            mac_en_neg <= 1'b1;
            data_and   <= data_in;
        end
        else if (op_code == 2'b01) begin
            col_mux    <= 8'b0000_0000;
            mac_en_neg <= 1'b1;
            data_and   <= 16'b0000_0000_0000_0000;
        end
        else if (op_code == 2'b10) begin
            col_mux    <= col_mux_w;
            mac_en_neg <= 1'b0;
            data_and   <= 16'b1111_1111_1111_1111;
        end
        else begin
            col_mux    <= 8'b0000_0000;
            mac_en_neg <= 1'b1;
            data_and   <= 16'b0000_0000_0000_0000;
        end
    end

endmodule
