module bank_ctrl (
    input  clk,
    input  w_en,    
    input  cs,
    output preb
);
    assign preb = cs & (w_en | clk);

endmodule