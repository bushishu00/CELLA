`timescale 1ns / 1ps
module array_ctrl_tb;

    // Clock & control
    reg clk;
    reg rst_n;

    // Inputs
    reg [1:0]  op_code;
    reg [8:0]  addr;
    reg [15:0] data_bank;
    reg [15:0] data_in;

    // Outputs
    wire       mac_en;
    wire [15:0] data_op;
    wire [15:0] bank_mux;
    wire       w_en;
    wire [15:0] data_and;
    wire [7:0]  col_mux;

    // DUT instantiation
    array_ctrl u_dut (
        .clk(clk),
        .rst_n(rst_n),
        .op_code(op_code),
        .addr_bank(addr[8:5]),
        .addr_col(addr[2:0]),
        .data_bank(data_bank),
        .data_in(data_in),

        .mac_en(mac_en),
        .data_op(data_op),
        .bank_mux(bank_mux),
        .w_en(w_en),
        .data_and(data_and),
        .col_mux(col_mux)
    );

    // Generate clk (4ns period => 2ns high, 2ns low)
    initial begin
        clk = 0;
        forever #2 clk = ~clk;  // 4ns period
    end


    // Test stimulus
    initial begin
// 复位序列
        rst_n = 0;
        op_code = 2'b11;
        addr = 9'd0;
        data_bank = 16'd0;
        data_in = 16'd0;
        #6;
        rst_n = 1;

// ===== 写入权重 =====
        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0000_00_000;     // bank=0, row=0
        data_bank = 16'h0000;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0000_01_000;     // bank=0, row=1
        data_bank = 16'h0001;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0000_10_000;     // bank=0, row=2
        data_bank = 16'h0002;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0000_11_000;     // bank=0, row=3
        data_bank = 16'h0003;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0001_00_000;     // bank=1, row=0
        data_bank = 16'h0001;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0001_01_000;     // bank=1, row=1
        data_bank = 16'h0002;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0001_10_000;     // bank=1, row=2
        data_bank = 16'h0003;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0001_11_000;     // bank=1, row=3
        data_bank = 16'h0004;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0010_00_000;     // bank=2, row=0
        data_bank = 16'h0002;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0010_01_000;     // bank=2, row=1
        data_bank = 16'h0003;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0010_10_000;     // bank=2, row=2
        data_bank = 16'h0004;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0010_11_000;     // bank=2, row=3
        data_bank = 16'h0005;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0011_00_000;     // bank=3, row=0
        data_bank = 16'h0003;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0011_01_000;     // bank=3, row=1
        data_bank = 16'h0004;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0011_10_000;     // bank=3, row=2
        data_bank = 16'h0005;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0011_11_000;     // bank=3, row=3
        data_bank = 16'h0006;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0100_00_000;     // bank=4, row=0
        data_bank = 16'h0004;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0100_01_000;     // bank=4, row=1
        data_bank = 16'h0005;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0100_10_000;     // bank=4, row=2
        data_bank = 16'h0006;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0100_11_000;     // bank=4, row=3
        data_bank = 16'h0007;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0101_00_000;     // bank=5, row=0
        data_bank = 16'h0005;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0101_01_000;     // bank=5, row=1
        data_bank = 16'h0006;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0101_10_000;     // bank=5, row=2
        data_bank = 16'h0007;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0101_11_000;     // bank=5, row=3
        data_bank = 16'h0008;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0110_00_000;     // bank=6, row=0
        data_bank = 16'h0006;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0110_01_000;     // bank=6, row=1
        data_bank = 16'h0007;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0110_10_000;     // bank=6, row=2
        data_bank = 16'h0008;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0110_11_000;     // bank=6, row=3
        data_bank = 16'h0009;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0111_00_000;     // bank=7, row=0
        data_bank = 16'h0007;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0111_01_000;     // bank=7, row=1
        data_bank = 16'h0008;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0111_10_000;     // bank=7, row=2
        data_bank = 16'h0009;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b0111_11_000;     // bank=7, row=3
        data_bank = 16'h000A;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1000_00_000;     // bank=8, row=0
        data_bank = 16'h0008;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1000_01_000;     // bank=8, row=1
        data_bank = 16'h0009;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1000_10_000;     // bank=8, row=2
        data_bank = 16'h000A;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1000_11_000;     // bank=8, row=3
        data_bank = 16'h000B;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1001_00_000;     // bank=9, row=0
        data_bank = 16'h0009;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1001_01_000;     // bank=9, row=1
        data_bank = 16'h000A;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1001_10_000;     // bank=9, row=2
        data_bank = 16'h000B;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1001_11_000;     // bank=9, row=3
        data_bank = 16'h000C;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1010_00_000;     // bank=10, row=0
        data_bank = 16'h000A;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1010_01_000;     // bank=10, row=1
        data_bank = 16'h000B;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1010_10_000;     // bank=10, row=2
        data_bank = 16'h000C;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1010_11_000;     // bank=10, row=3
        data_bank = 16'h000D;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1011_00_000;     // bank=11, row=0
        data_bank = 16'h000B;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1011_01_000;     // bank=11, row=1
        data_bank = 16'h000C;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1011_10_000;     // bank=11, row=2
        data_bank = 16'h000D;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1011_11_000;     // bank=11, row=3
        data_bank = 16'h000E;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1100_00_000;     // bank=12, row=0
        data_bank = 16'h000C;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1100_01_000;     // bank=12, row=1
        data_bank = 16'h000D;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1100_10_000;     // bank=12, row=2
        data_bank = 16'h000E;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1100_11_000;     // bank=12, row=3
        data_bank = 16'h000F;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1101_00_000;     // bank=13, row=0
        data_bank = 16'h000D;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1101_01_000;     // bank=13, row=1
        data_bank = 16'h000E;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1101_10_000;     // bank=13, row=2
        data_bank = 16'h000F;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1101_11_000;     // bank=13, row=3
        data_bank = 16'h0010;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1110_00_000;     // bank=14, row=0
        data_bank = 16'h000E;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1110_01_000;     // bank=14, row=1
        data_bank = 16'h000F;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1110_10_000;     // bank=14, row=2
        data_bank = 16'h0010;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1110_11_000;     // bank=14, row=3
        data_bank = 16'h0011;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1111_00_000;     // bank=15, row=0
        data_bank = 16'h000F;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1111_01_000;     // bank=15, row=1
        data_bank = 16'h0010;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1111_10_000;     // bank=15, row=2
        data_bank = 16'h0011;
        #4;

        op_code = 2'b01;
        data_in = 16'h0000;
        addr = 9'b1111_11_000;     // bank=15, row=3
        data_bank = 16'h0012;
        #4;

// ===== MAC =====
        op_code = 2'b00;
        addr = 9'b0000_00_000;
        data_bank = 16'h0000;
        data_in = 16'hFFFF;
        #4;
        op_code = 2'b00;
        addr = 9'b0000_00_000;
        data_bank = 16'h0000;
        data_in = 16'hF0FF;
        #4;
        op_code = 2'b00;
        addr = 9'b0000_01_000;
        data_bank = 16'h0000;
        data_in = 16'hFFFF;
        #4;
        op_code = 2'b00;
        addr = 9'b0000_00_000;
        data_bank = 16'h0010;
        data_in = 16'hFFFF;
        #4;
// ===== CAM =====
        op_code = 2'b10;
        addr = 9'b0000_00_000;
        data_bank = 16'h000F;
        data_in = 16'hFFFF;
        #10;
        $finish;
    end
endmodule