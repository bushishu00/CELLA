module adder_tree (
    input  [15:0] in,
    output [3:0]  out
 );
    wire [7:0] sum_level1;
    wire [3:0] sum_level2;
    wire [1:0] sum_level3;

    // Level 1: 16 to 8
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : level1
            assign sum_level1[i] = in[2*i] + in[2*i + 1];
        end
    endgenerate

    // Level 2: 8 to 4
    generate
        for (i = 0; i < 4; i = i + 1) begin : level2
            assign sum_level2[i] = sum_level1[2*i] + sum_level1[2*i + 1];
        end
    endgenerate

    // Level 3: 4 to 2
    generate
        for (i = 0; i < 2; i = i + 1) begin : level3
            assign sum_level3[i] = sum_level2[2*i] + sum_level2[2*i + 1];
        end
    endgenerate

    // Final Level: 2 to 1
    assign out = sum_level3[0] + sum_level3[1];

endmodule