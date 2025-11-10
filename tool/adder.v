// The automatically generated xmvrun script for verilog simution has some problems
// The parameter "-v93" doesn't assist parameter definition in module instantiation
// However, N bit adder is widely configured and used in adder tree structure
// So, we manually design 8bit, 9bit, 10bit, 11bit, 12bit adder modules here

module verilog_adder_tree (
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

    verilog_adder_8bit l1_0 (.a(din0),  .b(din1),  .sum(s1_0));
    verilog_adder_8bit l1_1 (.a(din2),  .b(din3),  .sum(s1_1));
    verilog_adder_8bit l1_2 (.a(din4),  .b(din5),  .sum(s1_2));
    verilog_adder_8bit l1_3 (.a(din6),  .b(din7),  .sum(s1_3));
    verilog_adder_8bit l1_4 (.a(din8),  .b(din9),  .sum(s1_4));
    verilog_adder_8bit l1_5 (.a(din10), .b(din11), .sum(s1_5));
    verilog_adder_8bit l1_6 (.a(din12), .b(din13), .sum(s1_6));
    verilog_adder_8bit l1_7 (.a(din14), .b(din15), .sum(s1_7));

    // --- Level 2: 4 × (9+9 → 10-bit) ---
    wire [9:0] s2_0, s2_1, s2_2, s2_3;

    verilog_adder_9bit l2_0 (.a(s1_0), .b(s1_1), .sum(s2_0));
    verilog_adder_9bit l2_1 (.a(s1_2), .b(s1_3), .sum(s2_1));
    verilog_adder_9bit l2_2 (.a(s1_4), .b(s1_5), .sum(s2_2));
    verilog_adder_9bit l2_3 (.a(s1_6), .b(s1_7), .sum(s2_3));

    // --- Level 3: 2 × (10+10 → 11-bit) ---
    wire [10:0] s3_0, s3_1;

    verilog_adder_10bit l3_0 (.a(s2_0), .b(s2_1), .sum(s3_0));
    verilog_adder_10bit l3_1 (.a(s2_2), .b(s2_3), .sum(s3_1));

    // --- Level 4: 1 × (11+11 → 12-bit) ---
    wire [11:0] s4;
    verilog_adder_11bit l4_0 (.a(s3_0), .b(s3_1), .sum(s4));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum <= 12'd0;
        end else begin
            sum <= s4;
        end
    end

endmodule

module verilog_adder_8bit (
    input  [7:0] a,
    input  [7:0] b,
    output [8:0] sum
);
    wire c1, c2, c3, c4, c5, c6, c7;

    verilog_full_adder fa0 (.a(a[0]), .b(b[0]), .cin(1'b0),   .sum(sum[0]), .cout(c1));
    verilog_full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),     .sum(sum[1]), .cout(c2));
    verilog_full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),     .sum(sum[2]), .cout(c3));
    verilog_full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),     .sum(sum[3]), .cout(c4));
    verilog_full_adder fa4 (.a(a[4]), .b(b[4]), .cin(c4),     .sum(sum[4]), .cout(c5));
    verilog_full_adder fa5 (.a(a[5]), .b(b[5]), .cin(c5),     .sum(sum[5]), .cout(c6));
    verilog_full_adder fa6 (.a(a[6]), .b(b[6]), .cin(c6),     .sum(sum[6]), .cout(c7));
    verilog_full_adder fa7 (.a(a[7]), .b(b[7]), .cin(c7),     .sum(sum[7]), .cout(sum[8]));
endmodule

module verilog_adder_9bit (
    input  [8:0] a,
    input  [8:0] b,
    output [9:0] sum
);
    wire c1, c2, c3, c4, c5, c6, c7, c8;

    verilog_full_adder fa0 (.a(a[0]), .b(b[0]), .cin(1'b0),   .sum(sum[0]), .cout(c1));
    verilog_full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),     .sum(sum[1]), .cout(c2));
    verilog_full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),     .sum(sum[2]), .cout(c3));
    verilog_full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),     .sum(sum[3]), .cout(c4));
    verilog_full_adder fa4 (.a(a[4]), .b(b[4]), .cin(c4),     .sum(sum[4]), .cout(c5));
    verilog_full_adder fa5 (.a(a[5]), .b(b[5]), .cin(c5),     .sum(sum[5]), .cout(c6));
    verilog_full_adder fa6 (.a(a[6]), .b(b[6]), .cin(c6),     .sum(sum[6]), .cout(c7));
    verilog_full_adder fa7 (.a(a[7]), .b(b[7]), .cin(c7),     .sum(sum[7]), .cout(c8));
    verilog_full_adder fa8 (.a(a[8]), .b(b[8]), .cin(c8),     .sum(sum[8]), .cout(sum[9]));
endmodule

module verilog_adder_10bit (
    input  [9:0] a,
    input  [9:0] b,
    output [10:0] sum
);
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9;

    verilog_full_adder fa0 (.a(a[0]), .b(b[0]), .cin(1'b0),   .sum(sum[0]), .cout(c1));
    verilog_full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),     .sum(sum[1]), .cout(c2));
    verilog_full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),     .sum(sum[2]), .cout(c3));
    verilog_full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),     .sum(sum[3]), .cout(c4));
    verilog_full_adder fa4 (.a(a[4]), .b(b[4]), .cin(c4),     .sum(sum[4]), .cout(c5));
    verilog_full_adder fa5 (.a(a[5]), .b(b[5]), .cin(c5),     .sum(sum[5]), .cout(c6));
    verilog_full_adder fa6 (.a(a[6]), .b(b[6]), .cin(c6),     .sum(sum[6]), .cout(c7));
    verilog_full_adder fa7 (.a(a[7]), .b(b[7]), .cin(c7),     .sum(sum[7]), .cout(c8));
    verilog_full_adder fa8 (.a(a[8]), .b(b[8]), .cin(c8),     .sum(sum[8]), .cout(c9));
    verilog_full_adder fa9 (.a(a[9]), .b(b[9]), .cin(c9),     .sum(sum[9]), .cout(sum[10]));
endmodule

module verilog_adder_11bit (
    input  [10:0] a,
    input  [10:0] b,
    output [11:0] sum
);
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10;

    verilog_full_adder fa0  (.a(a[0]),  .b(b[0]),  .cin(1'b0),   .sum(sum[0]),  .cout(c1));
    verilog_full_adder fa1  (.a(a[1]),  .b(b[1]),  .cin(c1),     .sum(sum[1]),  .cout(c2));
    verilog_full_adder fa2  (.a(a[2]),  .b(b[2]),  .cin(c2),     .sum(sum[2]),  .cout(c3));
    verilog_full_adder fa3  (.a(a[3]),  .b(b[3]),  .cin(c3),     .sum(sum[3]),  .cout(c4));
    verilog_full_adder fa4  (.a(a[4]),  .b(b[4]),  .cin(c4),     .sum(sum[4]),  .cout(c5));
    verilog_full_adder fa5  (.a(a[5]),  .b(b[5]),  .cin(c5),     .sum(sum[5]),  .cout(c6));
    verilog_full_adder fa6  (.a(a[6]),  .b(b[6]),  .cin(c6),     .sum(sum[6]),  .cout(c7));
    verilog_full_adder fa7  (.a(a[7]),  .b(b[7]),  .cin(c7),     .sum(sum[7]),  .cout(c8));
    verilog_full_adder fa8  (.a(a[8]),  .b(b[8]),  .cin(c8),     .sum(sum[8]),  .cout(c9));
    verilog_full_adder fa9  (.a(a[9]),  .b(b[9]),  .cin(c9),     .sum(sum[9]),  .cout(c10));
    verilog_full_adder fa10 (.a(a[10]), .b(b[10]), .cin(c10),    .sum(sum[10]), .cout(sum[11]));
endmodule

module verilog_full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule