module clk_copy_tb();
    reg clk;
    reg clk_inv;
    reg rst_n;
    wire clk_copy;

    // DUT instantiation
    clk_copy u_dut (
        .clk(clk),
        .clk_inv(clk_inv),
        .rst_n(rst_n),
        .clk_copy(clk_copy)
    );

    // Clock generation (ideal complementary clocks)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Generate ideal clk_inv = ~clk
    initial begin
        clk_inv = 1;
        forever #5 clk_inv = ~clk_inv;
    end

    // Reset control
    initial begin
        rst_n = 0;
        #6;               // Hold reset for 2.5 cycles
        rst_n = 1;
        #80;
        rst_n = 0;
        #8;
        rst_n = 1;
        #80;
        $finish;
    end
endmodule