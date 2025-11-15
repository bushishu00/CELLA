module clk_copy (
    input clk, clk_inv,
    input rst_n,
    output clk_copy
    );
    reg high, low;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            high <= 0;
        end
        else begin
            high <= ~high;
        end
    end
    always@(posedge clk_inv or negedge rst_n) begin
        if (!rst_n) begin
            low <= 0;
        end
        else if (high) begin
            low <= ~low;
        end
        else begin
            low <= 0;
        end
    end

    assign clk_copy = high ^ low;
endmodule