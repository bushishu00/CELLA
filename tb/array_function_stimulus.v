module array_function_stimulus (
    output reg         clk,
    output reg         rst_n,
    output reg  [1:0]  op_code,
    output reg  [8:0]  addr,
    output reg  [15:0] data_bank,
    output reg  [15:0] data_in
);

    // 时钟生成 (10ns周期)
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        // 复位序列
        rst_n = 0;
        op_code = 2'b11;
        addr = 9'd0;
        data_bank = 16'd0;
        data_in = 16'd0;
        #2;
        rst_n = 1;

        // ===== 写入模式测试 (01) =====
        // 写入b0r0 = 0xFF (11111111)
        op_code = 2'b01;
        addr = 9'b0000_00_000;     // bank=0, row=0, col=0 (忽略col)
        data_bank = 16'h00FF;
        data_in = 16'h0000;
        #2; // 等待2个周期

        // 写入b0r1，col地址应该不影响写入
        op_code = 2'b01;
        addr = 9'b0000_01_011;  
        data_bank = 16'h003F;
        #2;

        // 写入b0r2，data高位不影响
        op_code = 2'b01;
        addr = 9'b0000_10_011;  
        data_bank = 16'hFC76;
        #2;
        // 写入b0r3
        op_code = 2'b01;
        addr = 9'b0000_11_000;  
        data_bank = 16'h00AA;
        #2;

        // 写入b14r3 = 0xAA (10101010)
        op_code = 2'b01;
        addr = 9'b1110_11_000;    
        data_bank = 16'h0055;
        #2;

        // 写入b14r0 = 0x55
        op_code = 2'b01;
        addr = 9'b1110_00_000;    
        data_bank = 16'h00F4;
        #2;

        // ===== 读取模式测试 (00) =====
        // 读取r0，取反b1，测试b0b14没有影响，
        op_code = 2'b00;
        addr = 9'b0000_00_000;     // row0
        data_bank = 16'h0002; // 无取反
        data_in = 16'h0001; // data_in[0]=1
        #2;

        // 读取r1，取反b0，扰乱地址无影响
        op_code = 2'b00;
        addr = 9'b0110_01_110;
        data_bank = 16'h0001;
        data_in = 16'h0001;
        #2;

        // 读取r3，同时取反b0b14
        op_code = 2'b00;
        addr = 9'b0000_11_000;
        data_bank = 16'h4001;
        data_in = 16'h0000; 
        #2;

        // ===== 搜索模式测试 (10) =====
        // 搜索c0，1111
        op_code = 2'b10;
        addr = 9'b0000_00_000;    
        data_bank = 16'h000F; // query=1111
        data_in = 16'h0000; 
        #2;
        // 搜索c2，1111，bank和row地址不影响
        op_code = 2'b10;
        addr = 9'b0110_01_010;    
        data_bank = 16'h000F; // query=1111
        data_in = 16'h0000; 
        #2;

    end

endmodule