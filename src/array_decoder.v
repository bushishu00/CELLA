module array_decoder (
    input             clk,
    input             rst_n,

    input      [1:0]  op_code,
    input      [8:0]  addr,

    input      [15:0] data_bank,
    input      [15:0] data_in,

    output reg        mac_en,
    output reg [15:0] data_op,
    output reg [15:0] bank_mux,
    output     [1:0]  addr_row,
    output reg        w_en,
    
    output reg [15:0] data_and,
    output reg [7:0]  col_mux,

	output reg [3:0] query_bar
);  
    // input registers
    reg [1:0]  op_code_r;
    reg [8:0]  addr_r;

    reg [15:0] data_bank_r;
    reg [15:0] data_in_r;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            op_code_r   <= 2'b00;
            addr_r      <= 9'b0_0000_0000;
            data_bank_r <= 16'b0000_0000_0000_0000;
            data_in_r   <= 16'b0000_0000_0000_0000;
        end
        else begin
            op_code_r   <= op_code;
            addr_r <= addr;
            data_bank_r <= data_bank;
            data_in_r   <= data_in;
        end
    end


    // addr decode
    wire [3:0] addr_bank_w;
    wire [2:0] addr_col_w;
    
    assign addr_bank_w = addr_r[8:5];
    assign addr_row = addr_r[4:3];
    assign addr_col_w = addr_r[2:0];
    wire [15:0] bank_mux_w;
    wire [7:0]  col_mux_w;
    //4 to 16 decoder for bank selection
    assign bank_mux_w[15] =  addr_bank_w[3] &  addr_bank_w[2] &  addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[14] =  addr_bank_w[3] &  addr_bank_w[2] &  addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[13] =  addr_bank_w[3] &  addr_bank_w[2] & ~addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[12] =  addr_bank_w[3] &  addr_bank_w[2] & ~addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[11] =  addr_bank_w[3] & ~addr_bank_w[2] &  addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[10] =  addr_bank_w[3] & ~addr_bank_w[2] &  addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[9]  =  addr_bank_w[3] & ~addr_bank_w[2] & ~addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[8]  =  addr_bank_w[3] & ~addr_bank_w[2] & ~addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[7]  = ~addr_bank_w[3] &  addr_bank_w[2] &  addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[6]  = ~addr_bank_w[3] &  addr_bank_w[2] &  addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[5]  = ~addr_bank_w[3] &  addr_bank_w[2] & ~addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[4]  = ~addr_bank_w[3] &  addr_bank_w[2] & ~addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[3]  = ~addr_bank_w[3] & ~addr_bank_w[2] &  addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[2]  = ~addr_bank_w[3] & ~addr_bank_w[2] &  addr_bank_w[1] & ~addr_bank_w[0];
    assign bank_mux_w[1]  = ~addr_bank_w[3] & ~addr_bank_w[2] & ~addr_bank_w[1] &  addr_bank_w[0];
    assign bank_mux_w[0]  = ~addr_bank_w[3] & ~addr_bank_w[2] & ~addr_bank_w[1] & ~addr_bank_w[0];

    // 3 to 8 decoder for column selection
    assign col_mux_w[7] =  addr_col_w[2] &  addr_col_w[1] &  addr_col_w[0];
    assign col_mux_w[6] =  addr_col_w[2] &  addr_col_w[1] & ~addr_col_w[0];
    assign col_mux_w[5] =  addr_col_w[2] & ~addr_col_w[1] &  addr_col_w[0];
    assign col_mux_w[4] =  addr_col_w[2] & ~addr_col_w[1] & ~addr_col_w[0];
    assign col_mux_w[3] = ~addr_col_w[2] &  addr_col_w[1] &  addr_col_w[0];
    assign col_mux_w[2] = ~addr_col_w[2] &  addr_col_w[1] & ~addr_col_w[0];
    assign col_mux_w[1] = ~addr_col_w[2] & ~addr_col_w[1] &  addr_col_w[0];
    assign col_mux_w[0] = ~addr_col_w[2] & ~addr_col_w[1] & ~addr_col_w[0];

// bank control signals, directly out
    always@(*) begin
		if (!rst_n) begin
            mac_en   = 1'b1;
            w_en     = 1'b0;
            bank_mux = 16'b0000_0000_0000_0000;
            data_op  = 16'b0000_0000_0000_0000;

            data_and = 16'b0000_0000_0000_0000;
            col_mux  = 8'b0000_0000;

			query_bar = 4'b0000;
        end
        else if (op_code_r == 2'b00) begin
            mac_en   = 1'b1;
            w_en     = 1'b0;
            bank_mux = 16'b1111_1111_1111_1111;
            data_op  = data_bank_r;

            data_and = data_in_r;
            col_mux  = 8'b1111_1111;

			query_bar = 4'b0000;
        end
        else if (op_code_r == 2'b01) begin
            mac_en   = 1'b1;
            w_en     = 1'b1;
            bank_mux = bank_mux_w;
            data_op  = {8'b0000_0000, {data_bank_r[7:0]}};

            data_and = 16'b0000_0000_0000_0000;
            col_mux  = 8'b0000_0000;
	
			query_bar = 4'b0000;
        end
        else if (op_code_r == 2'b10) begin
            mac_en   = 1'b0;
            w_en     = 1'b0;
            bank_mux = 16'b1111_1111_1111_1111; 
            data_op  = {12'b0000_0000_0000, {data_bank_r[3:0]}};

            data_and = 16'b1111_1111_1111_1111;
            col_mux  = col_mux_w;

			query_bar = ~data_bank_r[3:0];
        end
        else begin
            mac_en   = 1'b1;
            w_en     = 1'b0;
            bank_mux = 16'b0000_0000_0000_0000;
            data_op  = 16'b0000_0000_0000_0000;

            data_and = 16'b0000_0000_0000_0000;
            col_mux  = 8'b0000_0000;

			query_bar = 4'b0000;
        end
    end
endmodule
