module sync_to_negedge (
    input             clk_inv,
    input             rst_n,
    input             mac_en,
    input      [7:0]  col_mux,
    input      [15:0] data_in,
    input      [7:0]  bank0,  bank1,  bank2,  bank3,
                      bank4,  bank5,  bank6,  bank7,
                      bank8,  bank9,  bank10, bank11,
                      bank12, bank13, bank14, bank15,

    output reg        mac_en_neg,
    output reg [15:0] data_in_neg,
    output reg [7:0]  col_mux_neg,
    output reg [7:0]  bank0_neg,  bank1_neg,  bank2_neg,  bank3_neg,
                      bank4_neg,  bank5_neg,  bank6_neg,  bank7_neg,
                      bank8_neg,  bank9_neg,  bank10_neg, bank11_neg,
                      bank12_neg, bank13_neg, bank14_neg, bank15_neg
);
    always @(posedge clk_inv or negedge rst_n) begin
        if (!rst_n) begin
            mac_en_neg  <= 1'b1;
            data_in_neg <= 16'b0000_0000_0000_0000;
            col_mux_neg <= 8'b0000_0000;

            bank0_neg   <= 8'b0000_0000;
            bank1_neg   <= 8'b0000_0000;
            bank2_neg   <= 8'b0000_0000;
            bank3_neg   <= 8'b0000_0000;
            bank4_neg   <= 8'b0000_0000;
            bank5_neg   <= 8'b0000_0000;
            bank6_neg   <= 8'b0000_0000;
            bank7_neg   <= 8'b0000_0000;
            bank8_neg   <= 8'b0000_0000;
            bank9_neg   <= 8'b0000_0000;
            bank10_neg  <= 8'b0000_0000;
            bank11_neg  <= 8'b0000_0000;
            bank12_neg  <= 8'b0000_0000;
            bank13_neg  <= 8'b0000_0000;
            bank14_neg  <= 8'b0000_0000;
            bank15_neg  <= 8'b0000_0000;
        end
        else begin
            mac_en_neg  <= mac_en;
            data_in_neg <= data_in;
            col_mux_neg <= col_mux;

            bank0_neg   <= bank0;
            bank1_neg   <= bank1;
            bank2_neg   <= bank2;
            bank3_neg   <= bank3;
            bank4_neg   <= bank4;
            bank5_neg   <= bank5;
            bank6_neg   <= bank6;
            bank7_neg   <= bank7;
            bank8_neg   <= bank8;
            bank9_neg   <= bank9;
            bank10_neg  <= bank10;
            bank11_neg  <= bank11;
            bank12_neg  <= bank12;
            bank13_neg  <= bank13;
            bank14_neg  <= bank14;
            bank15_neg  <= bank15;
        end
    end

endmodule
