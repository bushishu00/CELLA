module array_stimulus (
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
        forever #5 clk = ~clk;
    end

    initial begin
        // 复位序列
        rst_n = 0;
        op_code = 2'b11;
        addr = 9'd0;
        data_bank = 16'd0;
        data_in = 16'd0;
        #10;
        rst_n = 1;

        // ===== 写入模式测试 (01) =====
        // 写入bank0 row0 = 0xFF (11111111)
        op_code = 2'b01;
        addr = 9'd0;     // bank=0, row=0, col=0 (忽略col)
        data_bank = 16'h00FF;
        data_in = 16'h0000;
        #20; // 等待2个周期

        // 写入bank1 row1 = 0x00 (00000000)
        op_code = 2'b01;
        addr = 9'd10;    // bank=0, row=1 (addr=10 -> 000001010 -> bank=0, row=01)
        data_bank = 16'h0000;
        #20;

        // 写入bank2 row2 = 0xAA (10101010)
        op_code = 2'b01;
        addr = 9'd20;    // bank=0, row=2 (addr=20 -> 000010100 -> bank=0, row=10)
        data_bank = 16'h00AA;
        #20;

        // 写入bank3 row3 = 0x55 (01010101)
        op_code = 2'b01;
        addr = 9'd30;    // bank=0, row=3 (addr=30 -> 000011110 -> bank=0, row=11)
        data_bank = 16'h0055;
        #20;

        // 写入bank15 row3 (边界测试) - addr=15*16+3=243
        op_code = 2'b01;
        addr = 9'd243;   // bank=15 (1111), row=3 (11), col=0
        data_bank = 16'h00AA;
        #20;

        // ===== 读取模式测试 (00) =====
        // 测试1: bank0 row0, 无取反, data_in[0]=1 -> 0xFF
        op_code = 2'b00;
        addr = 9'd0;     // row0
        data_bank = 16'h0000; // 无取反
        data_in = 16'h0001; // data_in[0]=1
        #20;

        // 测试2: bank0 row0, 取反 (data_bank[0]=1), data_in[0]=1 -> 0x00
        op_code = 2'b00;
        addr = 9'd0;
        data_bank = 16'h0001; // bank0取反
        data_in = 16'h0001;
        #20;

        // 测试3: bank0 row0, 取反, data_in[0]=0 -> 0x00 (全0)
        op_code = 2'b00;
        addr = 9'd0;
        data_bank = 16'h0001;
        data_in = 16'h0000; // data_in[0]=0
        #20;

        // 测试4: bank1 row1, 取反 (data_bank[1]=1), data_in[0]=1 -> 0xFF (0x00取反)
        op_code = 2'b00;
        addr = 9'd10;    // bank0 row1 (addr=10)
        data_bank = 16'h0002; // bank1取反
        data_in = 16'h0001;
        #20;

        // 测试5: bank2 row2, 无取反, data_in[0]=1 -> 0xAA
        op_code = 2'b00;
        addr = 9'd20;
        data_bank = 16'h0000;
        data_in = 16'h0001;
        #20;

        // 测试6: bank3 row3, 取反 (data_bank[3]=1), data_in[0]=1 -> 0xAA (0x55取反)
        op_code = 2'b00;
        addr = 9'd30;
        data_bank = 16'h0008; // bank3取反
        data_in = 16'h0001;
        #20;

        // 测试7: 多Bank同时取反 (bank0 & bank3)
        op_code = 2'b00;
        addr = 9'd0;     // 读bank0 row0
        data_bank = 16'h0009; // bank0 & bank3取反 (0b1001)
        data_in = 16'h0001;
        #20;

        // 测试8: 行边界 (row3) - bank15 row3
        op_code = 2'b00;
        addr = 9'd243;   // bank15 row3
        data_bank = 16'h0000;
        data_in = 16'h0001;
        #20;

        // ===== 搜索模式测试 (10) =====
        // 测试9: 列0, query=0 (0000), data_in[0]=1 -> bank1~15匹配 (0x0000), bank0不匹配
        op_code = 2'b10;
        addr = 9'd0;     // col0 (addr[2:0]=0)
        data_bank = 16'h0000; // query=0
        data_in = 16'h0001; // data_in[0]=1
        #20;

        // 测试10: 列0, query=8 (1000), data_in[0]=1 -> 仅bank0匹配 (bank0 col0=1000)
        op_code = 2'b10;
        addr = 9'd0;
        data_bank = 16'h0008; // query=8
        data_in = 16'h0001;
        #20;

        // 测试11: 列7, query=0 (0000), data_in[0]=1 -> bank0不匹配 (col7=1000), 其他匹配
        op_code = 2'b10;
        addr = 9'd7;     // col7 (addr[2:0]=7)
        data_bank = 16'h0000;
        data_in = 16'h0001;
        #20;

        // 测试12: 搜索, data_in[0]=0 -> 结果全0
        op_code = 2'b10;
        addr = 9'd0;
        data_bank = 16'h0000;
        data_in = 16'h0000; // data_in[0]=0
        #20;

        // ===== 边界与异常测试 =====
        // 测试13: 无效opcode (11) - 无操作
        op_code = 2'b11;
        addr = 9'd0;
        data_bank = 16'h0000;
        data_in = 16'h0000;
        #20;

        // 测试14: 地址越界 (addr=255) - 无效 (bank=15, row=3, col=7)
        op_code = 2'b01;
        addr = 9'd255;   // 0b111111111
        data_bank = 16'h00FF;
        #20;

        // 测试15: data_bank高12位无效 (query=0)
        op_code = 2'b10;
        addr = 9'd0;
        data_bank = 16'hFF00; // 低4位=0, 高12位=FF
        data_in = 16'h0001;
        #20;
    end

endmodule