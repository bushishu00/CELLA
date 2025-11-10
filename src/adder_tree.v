module adder_tree (
    input             clk,
    input             rst_n,
    input      [7:0]  bank0, bank1, bank2, bank3,
                      bank4, bank5, bank6, bank7,
                      bank8, bank9, bank10, bank11,
                      bank12, bank13, bank14, bank15,
    output reg [11:0] sum
);
    // input reg
    reg [7:0] din0, din1, din2, din3;
    reg [7:0] din4, din5, din6, din7;
    reg [7:0] din8, din9, din10, din11;
    reg [7:0] din12, din13, din14, din15;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            din0  <= 8'd0;  din1  <= 8'd0;  din2  <= 8'd0;  din3  <= 8'd0;
            din4  <= 8'd0;  din5  <= 8'd0;  din6  <= 8'd0;  din7  <= 8'd0;
            din8  <= 8'd0;  din9  <= 8'd0;  din10 <= 8'd0;  din11 <= 8'd0;
            din12 <= 8'd0;  din13 <= 8'd0;  din14 <= 8'd0;  din15 <= 8'd0;
        end else begin
            din0  <= bank0;   din1  <= bank1;   din2  <= bank2;   din3  <= bank3;
            din4  <= bank4;   din5  <= bank5;   din6  <= bank6;   din7  <= bank7;
            din8  <= bank8;   din9  <= bank9;   din10 <= bank10; din11 <= bank11;
            din12 <= bank12;  din13 <= bank13;  din14 <= bank14; din15 <= bank15;
        end
    end
    // --- Level 1: 8 × (8+8 → 9-bit) ---
    wire [8:0] s1_0, s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7;

    adder_nbit #(8) l1_0 (.a(din0),  .b(din1),  .sum(s1_0));
    adder_nbit #(8) l1_1 (.a(din2),  .b(din3),  .sum(s1_1));
    adder_nbit #(8) l1_2 (.a(din4),  .b(din5),  .sum(s1_2));
    adder_nbit #(8) l1_3 (.a(din6),  .b(din7),  .sum(s1_3));
    adder_nbit #(8) l1_4 (.a(din8),  .b(din9),  .sum(s1_4));
    adder_nbit #(8) l1_5 (.a(din10), .b(din11), .sum(s1_5));
    adder_nbit #(8) l1_6 (.a(din12), .b(din13), .sum(s1_6));
    adder_nbit #(8) l1_7 (.a(din14), .b(din15), .sum(s1_7));

    // --- Level 2: 4 × (9+9 → 10-bit) ---
    wire [9:0] s2_0, s2_1, s2_2, s2_3;

    adder_nbit #(9) l2_0 (.a(s1_0), .b(s1_1), .sum(s2_0));
    adder_nbit #(9) l2_1 (.a(s1_2), .b(s1_3), .sum(s2_1));
    adder_nbit #(9) l2_2 (.a(s1_4), .b(s1_5), .sum(s2_2));
    adder_nbit #(9) l2_3 (.a(s1_6), .b(s1_7), .sum(s2_3));

    // --- Level 3: 2 × (10+10 → 11-bit) ---
    wire [10:0] s3_0, s3_1;

    adder_nbit #(10) l3_0 (.a(s2_0), .b(s2_1), .sum(s3_0));
    adder_nbit #(10) l3_1 (.a(s2_2), .b(s2_3), .sum(s3_1));

    // --- Level 4: 1 × (11+11 → 12-bit) ---
    wire [11:0] s4;
    adder_nbit #(11) l4_0 (.a(s3_0), .b(s3_1), .sum(s4));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum <= 12'd0;
        end else begin
            sum <= s4;
        end
    end

endmodule