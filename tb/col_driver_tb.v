`timescale  1ns / 1ps

module col_driver_tb;
    // input
    reg w_en;
    reg [2:0] addr;
    reg [7:0] data;

    // output
    wire [7:0] BL;
    wire [7:0] BLB;

    // DUT
    col_driver dut (
        .w_en(w_en),
        .data(data),
        .BL(BL),
        .BLB(BLB)
    );

    // stimulus
    initial begin
        // case1: MAC read
        w_en = 1'b1;
        addr = 3'b010; 
        data = 8'b00000000; 
        // case2: data don't affect output in MAC mode
        #10;
        data = 8'b11111111; 
        // case3: addr affects output in MAC mode
        #10;
        addr = 3'b001;
        // case5: CAM search key
        #10;
        w_en = 1'b0;
        // case6: key affects output in CAM mode
        #10;
        data = 8'b10101010;
        // case7: addr don't affect output in CAM mode
        #10;
        addr = 3'b011;
        #10;

        $stop;

    end

endmodule