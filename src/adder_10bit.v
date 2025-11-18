module adder_10bit ( 
	input  [9:0] a,
    input  [9:0] b,
    output [10:0] sum
);
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9;

    adder_1bit fa0 (.a(a[0]), .b(b[0]), .cin(1'b0),   .sum(sum[0]), .cout(c1));
    adder_1bit fa1 (.a(a[1]), .b(b[1]), .cin(c1),     .sum(sum[1]), .cout(c2));
    adder_1bit fa2 (.a(a[2]), .b(b[2]), .cin(c2),     .sum(sum[2]), .cout(c3));
    adder_1bit fa3 (.a(a[3]), .b(b[3]), .cin(c3),     .sum(sum[3]), .cout(c4));
    adder_1bit fa4 (.a(a[4]), .b(b[4]), .cin(c4),     .sum(sum[4]), .cout(c5));
    adder_1bit fa5 (.a(a[5]), .b(b[5]), .cin(c5),     .sum(sum[5]), .cout(c6));
    adder_1bit fa6 (.a(a[6]), .b(b[6]), .cin(c6),     .sum(sum[6]), .cout(c7));
    adder_1bit fa7 (.a(a[7]), .b(b[7]), .cin(c7),     .sum(sum[7]), .cout(c8));
    adder_1bit fa8 (.a(a[8]), .b(b[8]), .cin(c8),     .sum(sum[8]), .cout(c9));
    adder_1bit fa9 (.a(a[9]), .b(b[9]), .cin(c9),     .sum(sum[9]), .cout(sum[10]));
endmodule
