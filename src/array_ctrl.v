module array_ctrl (
    input             clk,
    input             rst_n,

    input   [1:0]     op_code,
    input   [3:0]     addr_bank,
    input   [2:0]     addr_col,

    input   [15:0]    data,

    output reg        mac_en,
    output reg        w_en,
    output reg [15:0] data_op,
    output reg [15:0] bank_mux,
    output reg [7:0]  col_mux
);  

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

    // bank_mux, col_mux
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bank_mux <= 16'b0;
            col_mux  <= 8'b0;
        end
        else if (op_code == 2'b00) begin
            // read, all banks selected, all cols selected
            bank_mux <= 16'hFFFF;
            col_mux  <= 8'hFF;
        end
        else if (op_code == 2'b01) begin
            // write, only one bank selected, no cols selected because write
            bank_mux <= bank_mux_w;
            col_mux  <= 8'b0;
        end
        else if (op_code == 2'b10) begin
            // search, all banks selected, only one col selected
            bank_mux <= 16'hFFFF; 
            col_mux  <= col_mux_w;
        end
        else begin
            bank_mux <= 16'b0;
            col_mux  <= 8'b0;
        end
    end
    
    // mac_en, w_en
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mac_en <= 1'b1;
            w_en   <= 1'b0;
        end
        else if (op_code == 2'b00) begin
            // read 
            mac_en <= 1'b1;
            w_en   <= 1'b0;
        end
        else if (op_code == 2'b01) begin
            // write 
            mac_en <= 1'b1;
            w_en   <= 1'b1;
        end
        else if (op_code == 2'b10) begin
            // search
            mac_en <= 1'b0;
            w_en   <= 1'b0;
        end
        else begin
            // idle
            mac_en <= 1'b1;
            w_en   <= 1'b0;
        end
    end

    // data_op
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_op <= 16'b0;
        end
        else if (op_code == 2'b00) begin
            // read, data_op is read_bar
            data_op <= data;
        end
        else if (op_code == 2'b01) begin
            // write, data_op is word, lower 8bits valid
            data_op <= {8'b00000000, {data[7:0]}};
        end
        else if (op_code == 2'b10) begin
            // search, data_op is query, lower 4 bits valid
            data_op <= {12'b000000000000, {data[3:0]}};
        end
        else begin
            data_op <= 16'b0;
        end
    end

endmodule