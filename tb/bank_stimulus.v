module bank_stimulus (
    output reg [3:0] query,
    output reg [7:0] word,
    output reg [1:0] addr,
    output reg MAC_en, w_en, read_bar,
    output reg clk, CS
);
    // Clock: 100 MHz (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5ns high, 5ns low
    end

    // Main stimulus sequence
    initial begin
        // Initialize
        CS = 0;
        MAC_en = 1;
        w_en = 0;
        read_bar = 1;
        addr = 0;
        query = 0;
        word = 8'h00;

        #10 CS = 1;         // Enable chip

        // === MAC Write Test ===
        #10 addr = 2'b00; word = 8'hAA; w_en = 1;
        #10 w_en = 0;

        #10 addr = 2'b01; word = 8'h55; w_en = 1;
        #10 w_en = 0;

        // === MAC Read Test (Q) ===
        #10 addr = 2'b00; read_bar = 0;  // Read Q
        #20;

        // === MAC Read Test (QB) ===
        #10 addr = 2'b00; read_bar = 1;  // Read QB
        #20;

        // === Switch to CAM Mode ===
        #10 MAC_en = 0;
        #10 query = 4'hA;   // Search key 0xA
        #20;

        #10 query = 4'hF;   // Search key 0xF (no match)
        #20;

        // === Back to MAC ===
        #10 MAC_en = 1;
        #10 addr = 2'b10; word = 8'h33; w_en = 1;
        #10 w_en = 0;

    end
endmodule