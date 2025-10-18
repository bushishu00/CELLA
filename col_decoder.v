// define independent ports for virtuoso design

module col_decoder (
	input MAC_en,
	input addr0, addr1, addr2,
	input data0, data1, data2, data3, data4, data5, data6, data7,
	output BL0, BL1, BL2, BL3, BL4, BL5, BL6, BL7,
	output BLB0, BLB1, BLB2, BLB3, BLB4, BLB5, BLB6, BLB7
 );
    // aggregate signals
    wire [2:0] addr;
    wire [7:0] word_in;
    assign addr = {addr2, addr1, addr0};
    assign word_in = {data3, data2, data1, data0};

    // 3-8 decoder for address
    wire [7:0] addr_in;
    assign addr_in[0] = ~addr[2] & ~addr[1] & ~addr[0];
    assign addr_in[1] = ~addr[2] & ~addr[1] &  addr[0];
    assign addr_in[2] = ~addr[2] &  addr[1] & ~addr[0];
    assign addr_in[3] = ~addr[2] &  addr[1] &  addr[0];
    assign addr_in[4] =  addr[2] & ~addr[1] & ~addr[0];
    assign addr_in[5] =  addr[2] & ~addr[1] &  addr[0];
    assign addr_in[6] =  addr[2] &  addr[1] & ~addr[0];
    assign addr_in[7] =  addr[2] &  addr[1] &  addr[0];

    // muxing logic for CAM and MAC
    wire [7:0] BL;
    wire [7:0] BLB;
	assign BL = MAC_en ? word_in : addr_in;
	assign BLB = MAC_en ? ~word_in : ~addr_in;

    // disaggregate output signals
	assign {BL7, BL6, BL5, BL4, BL3, BL2, BL1, BL0} = BL;
    assign {BLB7, BLB6, BLB5, BLB4, BLB3, BLB2, BLB1, BLB0} = BLB;

endmodule