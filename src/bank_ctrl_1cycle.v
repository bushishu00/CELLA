// Implement one cycle access by a voltage control: clk=0, precharge; clk=1, WL turn on
module bank_ctrl_1cycle (
    input  clk,
    input  w_en,    
    input  cs,
    output preb
);
    assign preb = cs & (w_en | clk);
    

endmodule