module adder_nbit #(parameter N=8) (
    input  [N-1:0] a,
    input  [N-1:0] b,
    output [N:0]   sum
);
    wire [N-1:0] carry;

    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));

    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : GEN_FA
            full_adder fa (.a(a[i]), .b(b[i]), .cin(carry[i-1]), .sum(sum[i]), .cout(carry[i]));
        end
    endgenerate

    assign sum[N] = carry[N-1];
endmodule