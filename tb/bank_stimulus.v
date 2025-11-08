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
        read_bar = 0;
        addr = 0;
        query = 4'b1111;
        word = 8'h00;

        #10 CS = 1;         // Enable chip

        // === MAC Write Test ===
        #10 addr = 2'b00; word = 8'h27; w_en = 1;
        #10 addr = 2'b01; word = 8'hA4; w_en = 1;
        #10 addr = 2'b10; word = 8'h7A; w_en = 1;
        #10 addr = 2'b11; word = 8'h6C; w_en = 1;

        // === MAC Read Test (Q) ===
        #10 w_en = 0;addr = 2'b00; read_bar = 0;  // Read Q
        // === MAC Read Test (QB) ===
        #10 addr = 2'b10; read_bar = 1;  // Read QB
        #10 addr = 2'b01; read_bar = 0;  // Read Q
        #10 addr = 2'b11; read_bar = 1;  // Read QB

        // === Switch to CAM Mode ===
        #10 MAC_en = 0;

        // === Back to MAC ===
        #10 MAC_en = 1;
        // === MAC Read Test (Q) ===
        #10 w_en = 0;addr = 2'b00; read_bar = 0;  // Read Q
        // === MAC Read Test (QB) ===
        #10 addr = 2'b10; read_bar = 1;  // Read QB
        #10 addr = 2'b01; read_bar = 0;  // Read Q
        #10 addr = 2'b11; read_bar = 1;  // Read QB

    end
endmodule