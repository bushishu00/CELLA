`timescale  1ns / 1ps

module row_decoder_tb;
    // input
    reg MAC_en, read_bar, w_en, CS;
    reg [1:0] addr;
    reg [3:0] data;

    // output
    wire [3:0] WL;
    wire [3:0] WLB;

    // DUT
    row_decoder dut (
        .MAC_en(MAC_en),
        .read_bar(read_bar),
        .w_en(w_en),
        .CS(CS),
        .addr(addr),
        .data(data),
        .WL(WL),
        .WLB(WLB)
    );

    // stimulus
    integer i;
    initial begin
        addr = 2'b01;
        data = 4'b1010;
        // test all combinations
        for (i = 0; i < 16; i = i + 1) begin
            {MAC_en, read_bar, w_en, CS} = i;
            #10;
        end
    end

endmodule