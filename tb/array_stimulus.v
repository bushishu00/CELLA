module array_stimulus (
    output reg         clk,
    output reg         rst_n,

    output reg  [1:0]  op_code,
    output reg  [8:0]  addr,

    output reg  [15:0] data_bank,
    output reg  [15:0] data_in
);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5ns high, 5ns low
    end

    initial begin
        rst_n = 0;
        #3;
        rst_n = 1;

        // write
        op_code = 2'b01;
        addr = 9'd0;
        data_bank = 16'h00FF;
        data_in = 16'h0000;
        // read
        #10;
        op_code = 2'b00;
        addr = 9'd0;
        data_bank = 16'h0000;
        data_in = 16'h00FF;
        // read, shoule be same
        #10;
        op_code = 2'b00;
        addr = 9'd2;
        data_bank = 16'h0000;
        data_in = 16'h00FF;
        // write
        #10;
        op_code = 2'b01;
        addr = 9'd1;
        data_bank = 16'h00AA;
        data_in = 16'h0000;
        // read
        #10;
        op_code = 2'b00;
        addr = 9'd1;
        data_bank = 16'h0000;
        data_in = 16'h00FF;
        // search
        #10;
        op_code = 2'b10;
        addr = 9'd0;
        data_bank = 16'h0001;
        data_in = 16'h00FF;
        
    end

endmodule