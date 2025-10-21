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

    // clock generation
    // always begin
    //     #5 clk = ~clk;
    // end

    // stimulus
    integer i;
    initial begin
        // case 1: MAC read
        MAC_en = 1;
        read_bar = 0;
        addr = 2'b10; 
        data = 4'b0000; 
        // case 2: change of data don't affect output
        #10; 
        data = 4'b1111; 
        // case 3: change of addr affects output
        #10; 
        addr = 2'b01;
        // case 4: read bar
        #10;
        read_bar = 1;
        // case 5: CAM with data 1111
        #10;
        MAC_en = 0;
        // case 6: change of data affects output
        #10;
        data = 4'b1010;
        // case 6: change of addr don't affect output
        #10;
        addr = 2'b11;
        // case 7: change of read_bar don't affect output
        #10;
        read_bar = 0;
        #10;
        // Test all combinations of inputs
        // for (i = 0; i < 64; i = i + 1) begin
        //     {MAC_en, read_bar, addr1, addr0, data3, data2, data1, data0} = i;
        //     #10; // wait for 10 time units
        // end
        $finish;
    end

endmodule