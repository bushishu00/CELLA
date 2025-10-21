`timescale  1ns / 1ps

module row_decoder_tb;
    // input
    reg MAC_en, read_bar;
    reg [1:0] addr;
    reg [3:0] data;

    // output
    wire [3:0] WL;
    wire [3:0] WLB;

    // DUT
    row_decoder dut (
        .MAC_en(MAC_en),
        .read_bar(read_bar),
        .addr0(addr[0]), .addr1(addr[1]),
        .data0(data[0]), .data1(data[1]), .data2(data[2]), .data3(data[3]),
        .WL0(WL[0]), .WL1(WL[1]), .WL2(WL[2]), .WL3(WL[3]),
        .WLB0(WLB[0]), .WLB1(WLB[1]), .WLB2(WLB[2]), .WLB3(WLB[3])
    );

    // stimulus
    initial begin
        // case1: MAC read
        MAC_en = 1'b1;
        read_bar = 1'b0;
        addr = 2'b10; 
        data = 4'b0000; 
        // case2: data don't affect output in MAC mode
        #10;
        data = 4'b1111; 
        // case3: addr affects output in MAC mode
        #10;
        addr = 2'b01;
        // case4: read QB
        #10;
        read_bar = 1'b1;
        // case5: CAM search key
        #10;
        MAC_en = 1'b0;
        // case6: key affects output in CAM mode
        #10;
        data = 4'b1010;
        // case7: addr don't affect output in CAM mode
        #10;
        addr = 2'b11;
        // case8: read QB don't affect output in CAM mode
        #10;
        read_bar = 1'b0;
        #10;

        $stop;

    end

endmodule