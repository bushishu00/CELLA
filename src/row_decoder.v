//Verilog HDL for "CIM_macro", "row_decoder" "functional"

module row_decoder (
    input        clk,
    input        cs,
	input        MAC_en,
    input        read_bar,
    input        w_en,
	input  [1:0] addr,
	input  [3:0] data,
	output [3:0] WL_bar,
	output [3:0] WLB_bar
 );
    // 2-4 decoder for address
    wire [3:0] addr_in;
    assign addr_in[0] = ~addr[1] & ~addr[0];
    assign addr_in[1] = ~addr[1] &  addr[0];
    assign addr_in[2] =  addr[1] & ~addr[0];
    assign addr_in[3] =  addr[1] &  addr[0];

    reg [3:0] WL, WLB;

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

    assign WL_bar  = ~WL;
    assign WLB_bar = ~WLB;
	
endmodule

