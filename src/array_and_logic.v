module array_and_logic ( 
    input [7:0] data_bank,
    input data_in,
    input [7:0] col_mux,
    input MAC_en,
    output [7:0] data_out
);	
	wire match;
    assign match = |(data_bank & col_mux);
    assign data_out = MAC_en ? (data_bank & {8{data_in}}) : {7'd0,{match}};
endmodule
