module bank_ctrl (
    input  clk_copy,
    input  w_en,    
    input  cs,
    output preb,
    output w_drv
);
    assign preb = cs & clk_copy;
    assign w_drv = cs & w_en & clk_copy;

endmodule