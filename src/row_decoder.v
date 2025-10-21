// define independent ports for virtuoso design

module row_decoder (
	input MAC_en,
    input read_bar,
	input addr0, addr1,
	input data0, data1, data2, data3,
	output WL0, WL1, WL2, WL3,
	output WLB0, WLB1, WLB2, WLB3
 );
    // aggregate signals
    wire [1:0] addr;
    wire [3:0] key_in;
    assign addr = {addr1, addr0};
    assign key_in = {data3, data2, data1, data0};

    // 2-4 decoder for address
    wire [3:0] addr_in;
    assign addr_in[0] = ~addr[1] & ~addr[0];
    assign addr_in[1] = ~addr[1] &  addr[0];
    assign addr_in[2] =  addr[1] & ~addr[0];
    assign addr_in[3] =  addr[1] &  addr[0];

    // muxing logic for CAM and MAC
    wire [3:0] WL;
    wire [3:0] WLB;
	assign WL = MAC_en ? (read_bar ? 0 : addr_in) : key_in;
	assign WLB = MAC_en ? (read_bar ? addr_in : 0) : ~key_in;

    // disaggregate output signals
	assign {WL3, WL2, WL1, WL0} = WL;
    assign {WLB3, WLB2, WLB1, WLB0} = WLB;
	
endmodule