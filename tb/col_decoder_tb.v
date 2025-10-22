`timescale  1ns / 1ps

module col_decoder_tb;
    // input
    reg MAC_en;
    reg [2:0] addr;
    reg [7:0] data;

    // output
    wire [7:0] BL;
    wire [7:0] BLB;

    // DUT
    col_decoder dut (
        .MAC_en(MAC_en),
        .addr0(addr[0]), .addr1(addr[1]), .addr2(addr[2]),
        .data0(data[0]), .data1(data[1]), .data2(data[2]), .data3(data[3]), .data4(data[4]), .data5(data[5]), .data6(data[6]), .data7(data[7]),
        .BL0(BL[0]), .BL1(BL[1]), .BL2(BL[2]), .BL3(BL[3]), .BL4(BL[4]), .BL5(BL[5]), .BL6(BL[6]), .BL7(BL[7]),
        .BLB0(BLB[0]), .BLB1(BLB[1]), .BLB2(BLB[2]), .BLB3(BLB[3]), .BLB4(BLB[4]), .BLB5(BLB[5]), .BLB6(BLB[6]), .BLB7(BLB[7])
    );

    // stimulus
    initial begin
        // case1: MAC read
        MAC_en = 1'b1;
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
        MAC_en = 1'b0;
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