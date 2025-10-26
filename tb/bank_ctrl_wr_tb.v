`timescale 1ns / 1ps

module bank_ctrl_wr_tb;

    // DUT interface
    reg clk;
    reg rst_n;
    reg w_en;
    reg r_en;
    wire preb;
    wire w_drv;
    wire sampleb;
    wire sa_en;

    // Instantiate DUT
    bank_ctrl_wr uut (
        .clk(clk),
        .rst_n(rst_n),
        .w_en(w_en),
        .r_en(r_en),
        .preb(preb),
        .w_drv(w_drv),
        .sampleb(sampleb),
        .sa_en(sa_en)
    );

    // Clock generation: 100 MHz (period = 10 ns)
    always #5 clk = ~clk;  // 5ns high, 5ns low

    // Test stimulus
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        w_en = 0;
        r_en = 0;

        // Hold reset for 20 ns
        #20 rst_n = 1;

        // Wait in PRE state
        #20;

        // Test WRITE operation
        w_en = 1;
        #10;
        w_en = 0;
        #30;  // Should go: PRE → WRITE → PRE

        // Test READ (SENSE) operation
        r_en = 1;
        #10;
        r_en = 0;
        #50;  // Should go: PRE → SENSE1 → SENSE2 → PRE

        // Test back-to-back operations
        w_en = 1;
        #10;
        w_en = 0;
        #10;
        r_en = 1;
        #10;
        r_en = 0;
        #40;

        // Finish
        $display("Simulation completed.");
        $finish;
    end

endmodule