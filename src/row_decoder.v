module row_decoder (
    input        clk,
    input        preb,
    input        cs,
	input        MAC_en,
    input        read_bar,
    input        w_en,
	input  [1:0] addr,
	input  [3:0] data,
	output [3:0] WL,
	output [3:0] WLB
 );
    // 2-4 decoder for address
    wire [3:0] addr_in;
    assign addr_in[0] = ~addr[1] & ~addr[0];
    assign addr_in[1] = ~addr[1] &  addr[0];
    assign addr_in[2] =  addr[1] & ~addr[0];
    assign addr_in[3] =  addr[1] &  addr[0];

    reg [3:0] WL_r, WLB_r;
    // muxing logic for CAM and MAC
	always @(posedge clk) begin
        if (!cs) begin
            WL_r <= 4'b0000;
            WLB_r <= 4'b0000;
        end
        else if (w_en) begin
            WL_r <= addr_in;
            WLB_r <= addr_in;
        end 
        else if (MAC_en) begin
            if (read_bar) begin
                WL_r <= 4'b0000;
                WLB_r <= addr_in;
            end else begin
                WL_r <= addr_in;
                WLB_r <= 4'b0000;
            end
        end
        else begin
            WL_r <= data;
            WLB_r <= ~data;
        end
    end
	
    assign WL  = preb ? WL_r  : 4'b0000;
    assign WLB = preb ? WLB_r : 4'b0000;
endmodule