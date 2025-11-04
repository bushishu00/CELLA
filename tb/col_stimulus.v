module col_stimulus (
    output reg preb, w_en, write_bit, SAE,
    output reg [3:0] WL, WLB
);

    // Main stimulus sequence
    initial begin
        // reset
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 0;
        //write 0@0001
        #10
        preb = 1;
        w_en = 1;
        SAE  = 0;
        WL   = 4'b0001;
        WLB  = 4'b0001;
        write_bit = 0;
        //precharge
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 0;
        //read 0@0001
        #10
        preb = 1;
        w_en = 0;
        SAE  = 1;
        WL   = 4'b0001;
        WLB  = 4'b0000;
        write_bit = 0;
        //precharge
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 0;
        //read 1@0001
        #10
        preb = 1;
        w_en = 0;
        SAE  = 1;
        WL   = 4'b0000;
        WLB  = 4'b0001;
        write_bit = 0;

        // reset
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 0;
        //write 0@0010
        #10
        preb = 1;
        w_en = 1;
        SAE  = 0;
        WL   = 4'b0010;
        WLB  = 4'b0010;
        write_bit = 1;
        //precharge
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 1;
        //read 1@0010
        #10
        preb = 1;
        w_en = 0;
        SAE  = 1;
        WL   = 4'b0010;
        WLB  = 4'b0000;
        write_bit = 1;
        //precharge
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 1;
        //read 0@0010
        #10
        preb = 1;
        w_en = 0;
        SAE  = 1;
        WL   = 4'b0000;
        WLB  = 4'b0010;
        write_bit = 1;
        //precharge
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 4'b0000;
        WLB  = 4'b0000;
        write_bit = 1;
        //read 0@0001
        #10
        preb = 1;
        w_en = 0;
        SAE  = 1;
        WL   = 4'b0010;
        WLB  = 4'b0000;
        write_bit = 1;
        // reset
        #10
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 0;
        WLB  = 0;
        write_bit = 0;
        
    end
endmodule