module bank_ctrl (
    input  clk_copy,
    input  w_en,    
    input  cs,
    output preb
);
    assign preb = cs & (w_en | clk_copy);

endmodule