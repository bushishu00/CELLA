module array_ctrl (
    input             clk,
    input             rst_n,
    input   [7:0]     word,
    input   [1:0]     op_code,
    input   [3:0]     bank_sel,
    output reg        mac_en,
    output reg        read_bar,
    output reg        w_en,
    output reg [15:0] bank_en
);  
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bank_en <= 16'b0;
        end else begin
            bank_en[0]  <= ~bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
            bank_en[1]  <= ~bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
            bank_en[2]  <= ~bank_sel[3] & ~bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
            bank_en[3]  <= ~bank_sel[3] & ~bank_sel[2] &  bank_sel[1] &  bank_sel[0];
            bank_en[4]  <= ~bank_sel[3] &  bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
            bank_en[5]  <= ~bank_sel[3] &  bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
            bank_en[6]  <= ~bank_sel[3] &  bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
            bank_en[7]  <= ~bank_sel[3] &  bank_sel[2] &  bank_sel[1] &  bank_sel[0];
            bank_en[8]  <=  bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
            bank_en[9]  <=  bank_sel[3] & ~bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
            bank_en[10] <=  bank_sel[3] & ~bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
            bank_en[11] <=  bank_sel[3] & ~bank_sel[2] &  bank_sel[1] &  bank_sel[0];
            bank_en[12] <=  bank_sel[3] &  bank_sel[2] & ~bank_sel[1] & ~bank_sel[0];
            bank_en[13] <=  bank_sel[3] &  bank_sel[2] & ~bank_sel[1] &  bank_sel[0];
            bank_en[14] <=  bank_sel[3] &  bank_sel[2] &  bank_sel[1] & ~bank_sel[0];
            bank_en[15] <=  bank_sel[3] &  bank_sel[2] &  bank_sel[1] &  bank_sel[0];
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mac_en   <= 1'b0;
            read_bar <= 1'b1;
            w_en     <= 1'b0;
        end else begin
            case (op_code)
                2'b00: begin
                    mac_en   <= 1'b1;
                    read_bar <= 1'b1;
                    w_en     <= 1'b0;
                end
                2'b01: begin
                    mac_en   <= 1'b0;
                    read_bar <= 1'b0;
                    w_en     <= 1'b0;
                end
                2'b10: begin
                    mac_en   <= 1'b0;
                    read_bar <= 1'b1;
                    w_en     <= 1'b1;
                end
                default: begin
                    mac_en   <= 1'b0;
                    read_bar <= 1'b1;
                    w_en     <= 1'b0;
                end
            endcase
        end
    end

endmodule