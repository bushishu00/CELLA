module array_and_logic ( 
    input         clk_inv,
    input         rst_n,

    input         mac_en,
    input  [7:0]  col_mux,
    input  [15:0] data_in,
    input  [7:0]  bank0,  bank1,  bank2,  bank3,
                  bank4,  bank5,  bank6,  bank7,
                  bank8,  bank9,  bank10, bank11,
                  bank12, bank13, bank14, bank15,

    output [7:0]  add0,  add1,  add2,  add3,
                  add4,  add5,  add6,  add7,
                  add8,  add9,  add10, add11,
                  add12, add13, add14, add15
);	

// sync to negedge
    wire        mac_en_neg;
    wire [7:0]  col_mux_neg;
    wire [15:0] data_in_neg;
    wire [7:0]  bank0_neg;
    wire [7:0]  bank1_neg;
    wire [7:0]  bank2_neg;
    wire [7:0]  bank3_neg;
    wire [7:0]  bank4_neg;
    wire [7:0]  bank5_neg;
    wire [7:0]  bank6_neg;
    wire [7:0]  bank7_neg;
    wire [7:0]  bank8_neg;
    wire [7:0]  bank9_neg;
    wire [7:0]  bank10_neg;
    wire [7:0]  bank11_neg;
    wire [7:0]  bank12_neg;
    wire [7:0]  bank13_neg;
    wire [7:0]  bank14_neg;
    wire [7:0]  bank15_neg;

    sync_to_negedge u_sync (
    .clk_inv       (clk_inv),          
    .rst_n         (rst_n),            

    // to be synced to negedge
    .mac_en        (mac_en),           
    .col_mux       (col_mux),          
    .data_in       (data_in),         
    .bank0         (bank0),
    .bank1         (bank1),
    .bank2         (bank2),
    .bank3         (bank3),
    .bank4         (bank4),
    .bank5         (bank5),
    .bank6         (bank6),
    .bank7         (bank7),
    .bank8         (bank8),
    .bank9         (bank9),
    .bank10        (bank10),
    .bank11        (bank11),
    .bank12        (bank12),
    .bank13        (bank13),
    .bank14        (bank14),
    .bank15        (bank15),
    // synced output
    .mac_en_neg    (mac_en_neg),       
    .col_mux_neg   (col_mux_neg),      
    .data_in_neg   (data_in_neg),      
    .bank0_neg     (bank0_neg),
    .bank1_neg     (bank1_neg),
    .bank2_neg     (bank2_neg),
    .bank3_neg     (bank3_neg),
    .bank4_neg     (bank4_neg),
    .bank5_neg     (bank5_neg),
    .bank6_neg     (bank6_neg),
    .bank7_neg     (bank7_neg),
    .bank8_neg     (bank8_neg),
    .bank9_neg     (bank9_neg),
    .bank10_neg    (bank10_neg),
    .bank11_neg    (bank11_neg),
    .bank12_neg    (bank12_neg),
    .bank13_neg    (bank13_neg),
    .bank14_neg    (bank14_neg),
    .bank15_neg    (bank15_neg)
);


    wire [15:0] match;
    assign match[0]  = |(bank0_neg  & col_mux_neg);
    assign match[1]  = |(bank1_neg  & col_mux_neg);
    assign match[2]  = |(bank2_neg  & col_mux_neg);
    assign match[3]  = |(bank3_neg  & col_mux_neg);
    assign match[4]  = |(bank4_neg  & col_mux_neg);
    assign match[5]  = |(bank5_neg  & col_mux_neg);
    assign match[6]  = |(bank6_neg  & col_mux_neg);
    assign match[7]  = |(bank7_neg  & col_mux_neg);
    assign match[8]  = |(bank8_neg  & col_mux_neg);
    assign match[9]  = |(bank9_neg  & col_mux_neg);
    assign match[10] = |(bank10_neg & col_mux_neg);
    assign match[11] = |(bank11_neg & col_mux_neg);
    assign match[12] = |(bank12_neg & col_mux_neg);
    assign match[13] = |(bank13_neg & col_mux_neg);
    assign match[14] = |(bank14_neg & col_mux_neg);
    assign match[15] = |(bank15_neg & col_mux_neg);

    assign add0  = mac_en_neg ? (bank0_neg  & {8{data_in_neg[0]}})  : {7'd0,{match[0]}};
    assign add1  = mac_en_neg ? (bank1_neg  & {8{data_in_neg[1]}})  : {7'd0,{match[1]}};
    assign add2  = mac_en_neg ? (bank2_neg  & {8{data_in_neg[2]}})  : {7'd0,{match[2]}};
    assign add3  = mac_en_neg ? (bank3_neg  & {8{data_in_neg[3]}})  : {7'd0,{match[3]}};
    assign add4  = mac_en_neg ? (bank4_neg  & {8{data_in_neg[4]}})  : {7'd0,{match[4]}};
    assign add5  = mac_en_neg ? (bank5_neg  & {8{data_in_neg[5]}})  : {7'd0,{match[5]}};
    assign add6  = mac_en_neg ? (bank6_neg  & {8{data_in_neg[6]}})  : {7'd0,{match[6]}};
    assign add7  = mac_en_neg ? (bank7_neg  & {8{data_in_neg[7]}})  : {7'd0,{match[7]}};
    assign add8  = mac_en_neg ? (bank8_neg  & {8{data_in_neg[8]}})  : {7'd0,{match[8]}};
    assign add9  = mac_en_neg ? (bank9_neg  & {8{data_in_neg[9]}})  : {7'd0,{match[9]}};
    assign add10 = mac_en_neg ? (bank10_neg & {8{data_in_neg[10]}}) : {7'd0,{match[10]}};
    assign add11 = mac_en_neg ? (bank11_neg & {8{data_in_neg[11]}}) : {7'd0,{match[11]}};
    assign add12 = mac_en_neg ? (bank12_neg & {8{data_in_neg[12]}}) : {7'd0,{match[12]}};
    assign add13 = mac_en_neg ? (bank13_neg & {8{data_in_neg[13]}}) : {7'd0,{match[13]}};
    assign add14 = mac_en_neg ? (bank14_neg & {8{data_in_neg[14]}}) : {7'd0,{match[14]}};
    assign add15 = mac_en_neg ? (bank15_neg & {8{data_in_neg[15]}}) : {7'd0,{match[15]}};
endmodule
