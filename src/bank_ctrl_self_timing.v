
module bank_ctrl_self_timing (
    input  clk,
    input  w_en,    
    input  cs,
    output preb,
    output WL_dummy,
    output sampleb
);
    // precharge when the chip is selected, accessed, and the clk=0. or when the chip is not selected
    assign preb = cs & (w_en | ~w_en & clk);
    assign WL_dummy = cs & ~w_en & clk;
    assign sampleb = ~cs | w_en | ~clk;

endmodule