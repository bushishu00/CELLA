
module bank_ctrl_self_timing (
    input  clk,
    input  w_en,    
    input  cs,
    output preb
);
    // precharge when the chip is selected, accessed, and the clk=0. or when the chip is not selected
    assign preb = ~cs | (cs & ~w_en & ~clk);

endmodule