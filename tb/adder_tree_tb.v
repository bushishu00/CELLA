`timescale 1ns / 1ps

module adder_tree_tb;

    // DUT inputs (16 x 8-bit)
    reg [7:0] bank0, bank1, bank2, bank3;
    reg [7:0] bank4, bank5, bank6, bank7;
    reg [7:0] bank8, bank9, bank10, bank11;
    reg [7:0] bank12, bank13, bank14, bank15;

    // DUT output
    wire [11:0] sum;

    // Instantiate DUT
    adder_tree u_dut (
        .bank0(bank0),   .bank1(bank1),   .bank2(bank2),   .bank3(bank3),
        .bank4(bank4),   .bank5(bank5),   .bank6(bank6),   .bank7(bank7),
        .bank8(bank8),   .bank9(bank9),   .bank10(bank10), .bank11(bank11),
        .bank12(bank12), .bank13(bank13), .bank14(bank14), .bank15(bank15),
        .sum(sum)
    );

    // Reference sum (for checking)
    reg [11:0] expected_sum;
    integer i, error_count;

    // Task: apply input and check result
    task apply_and_check;
        input [7:0] d0, d1, d2, d3, d4, d5, d6, d7;
        input [7:0] d8, d9, d10, d11, d12, d13, d14, d15;
        begin
            // Assign inputs
            {bank15, bank14, bank13, bank12, bank11, bank10, bank9, bank8,
             bank7,  bank6,  bank5,  bank4,  bank3,  bank2,  bank1, bank0} =
            {d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, d0};

            // Compute expected sum (testbench-only, uses +)
            expected_sum = d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 +
                           d8 + d9 + d10 + d11 + d12 + d13 + d14 + d15;

            #1; // Wait for combinational logic to settle

            if (sum !== expected_sum) begin
                $display("ERROR at time %0t: sum = %0d, expected = %0d", $time, sum, expected_sum);
                error_count = error_count + 1;
            end else begin
                $display("PASS at time %0t: sum = %0d", $time, sum);
            end
        end
    endtask

    initial begin
        error_count = 0;

        // Test 1: All zeros
        apply_and_check(8'd0, 8'd0, 8'd0, 8'd0,
                        8'd0, 8'd0, 8'd0, 8'd0,
                        8'd0, 8'd0, 8'd0, 8'd0,
                        8'd0, 8'd0, 8'd0, 8'd0);

        // Test 2: All ones (255 each)
        apply_and_check(8'd255, 8'd255, 8'd255, 8'd255,
                        8'd255, 8'd255, 8'd255, 8'd255,
                        8'd255, 8'd255, 8'd255, 8'd255,
                        8'd255, 8'd255, 8'd255, 8'd255); // sum = 4080

        // Test 3: One non-zero
        apply_and_check(8'd100, 8'd0, 8'd0, 8'd0,
                        8'd0,   8'd0, 8'd0, 8'd0,
                        8'd0,   8'd0, 8'd0, 8'd0,
                        8'd0,   8'd0, 8'd0, 8'd0); // sum = 100

        // Test 4: Alternating pattern
        apply_and_check(8'd1, 8'd2, 8'd4, 8'd8,
                        8'd16, 8'd32, 8'd64, 8'd128,
                        8'd1, 8'd2, 8'd4, 8'd8,
                        8'd16, 8'd32, 8'd64, 8'd128); // sum = 2*(1+2+4+8+16+32+64+128) = 2*255 = 510

        // Test 5: Random values (you can add more)
        apply_and_check(8'd123, 8'd45, 8'd67, 8'd89,
                        8'd12, 8'd34, 8'd56, 8'd78,
                        8'd90, 8'd11, 8'd22, 8'd33,
                        8'd44, 8'd55, 8'd66, 8'd77); // sum = ?

        // Final result
        if (error_count == 0) begin
            $display("===================================");
            $display("All %0d tests PASSED!", 5);
            $display("===================================");
        end else begin
            $display("===================================");
            $display("%0d test(s) FAILED!", error_count);
            $display("===================================");
        end

        $finish;
    end

endmodule