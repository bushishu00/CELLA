module row_decoder (
    input            clk_copy,
    input            cs,
	input            mac_en,
    input            read_bar,
    input            w_en,
	input  [1:0]     addr,
	input  [3:0]     data,
	input  [3:0]     data_bar,
	output reg [3:0] WL,
	output reg [3:0] WLB
 );
    // 2-4 decoder for address
    wire [3:0] addr_row;
    assign addr_row[0] = ~addr[1] & ~addr[0];
    assign addr_row[1] = ~addr[1] &  addr[0];
    assign addr_row[2] =  addr[1] & ~addr[0];
    assign addr_row[3] =  addr[1] &  addr[0];

    // muxing logic for CAM and MAC
	always @(*) begin
        if (!(cs & clk_copy)) begin
            WL  = 4'b0000;
            WLB = 4'b0000;
        end
        else if (w_en) begin
            WL  = addr_row;
            WLB = addr_row;
        end 
        else if (mac_en) begin
            if (read_bar) begin
                WL  = 4'b0000;
                WLB = addr_row;
            end else begin
                WL  = addr_row;
                WLB = 4'b0000;
            end
        end
        else begin
            WL  = data;
            WLB = data_bar;
        end
    end
endmodule
