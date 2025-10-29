module adder_tree (
    input  [7:0] bank0, bank1, bank2, bank3,
                 bank4, bank5, bank6, bank7,
                 bank8, bank9, bank10, bank11,
                 bank12, bank13, bank14, bank15,
    output [11:0] sum
);

    // --- Level 1: 8 × (8+8 → 9-bit) ---
    wire [8:0] s1_0, s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7;

    adder_nbit #(8) l1_0 (.a(bank0),  .b(bank1),  .sum(s1_0));
    adder_nbit #(8) l1_1 (.a(bank2),  .b(bank3),  .sum(s1_1));
    adder_nbit #(8) l1_2 (.a(bank4),  .b(bank5),  .sum(s1_2));
    adder_nbit #(8) l1_3 (.a(bank6),  .b(bank7),  .sum(s1_3));
    adder_nbit #(8) l1_4 (.a(bank8),  .b(bank9),  .sum(s1_4));
    adder_nbit #(8) l1_5 (.a(bank10), .b(bank11), .sum(s1_5));
    adder_nbit #(8) l1_6 (.a(bank12), .b(bank13), .sum(s1_6));
    adder_nbit #(8) l1_7 (.a(bank14), .b(bank15), .sum(s1_7));

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
    adder_nbit #(11) l4_0 (.a(s3_0), .b(s3_1), .sum(sum));

endmodule