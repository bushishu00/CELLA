module clk_copy (
    input clk,
    input clk_inv,
    input rst_n,
    output clk_copy
);

    reg high, low;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            high <= 1'b0;
        end else begin
            high <= ~low;
        end
    end
    always@(posedge clk_inv or negedge rst_n) begin
        if (!rst_n) begin
            low <= 1'b0;
        end else begin
            low <= ~high;
        end
    end

    assign clk_copy = high;

endmodule
