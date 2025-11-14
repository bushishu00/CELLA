module bank_ctrl (
    input  preb_en,
    input  w_en,    
    input  cs,
    output preb
);
    assign preb = cs & (w_en | preb_en);

endmodule