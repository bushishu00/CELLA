module array_AND_logic (
    input [7:0] data_bank,
    input data_in,
    input [7:0] col_mux,
    input MAC_en,
    output [7:0] data_out
);
    assign data_out = MAC_en ? (data_bank & {8{data_in}}) : (data_bank & col_mux);

endmodule