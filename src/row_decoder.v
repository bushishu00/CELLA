// define independent ports for virtuoso design

module row_decoder (
    input            clk,
    input            cs,
	input            MAC_en,
    input            read_bar,
    input            w_en,
	input      [1:0] addr,
	input      [3:0] data,
	output reg [3:0] WL,
	output reg [3:0] WLB,
    output           WL_dummy
 );
    // when access(w_en=0), WL_dummy is high for self timing
    assign WL_dummy = ~w_en & cs;

    // 2-4 decoder for address
    wire [3:0] addr_in;
    assign addr_in[0] = ~addr[1] & ~addr[0];
    assign addr_in[1] = ~addr[1] &  addr[0];
    assign addr_in[2] =  addr[1] & ~addr[0];
    assign addr_in[3] =  addr[1] &  addr[0];

    // muxing logic for CAM and MAC
	always @(posedge clk or negedge cs) begin
        if (!cs) begin
            WL = 4'b0000;
            WLB = 4'b0000;
        end
        else if (w_en) begin
            WL = addr_in;
            WLB = addr_in;
        end 
        else if (MAC_en) begin
            if (read_bar) begin
                WL = 4'b0000;
                WLB = addr_in;
            end else begin
                WL = addr_in;
                WLB = 4'b0000;
            end
        end
        else begin
            WL = data;
            WLB = ~data;
        end
    end

	
endmodule