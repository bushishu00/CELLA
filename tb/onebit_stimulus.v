module onebit_stimulus (
    output reg preb, w_en, write_bit,
    output reg SAE, WL, WLB
);

    // Main stimulus sequence
    initial begin
        // Initialize
        preb = 0;
        w_en = 0;
        SAE  = 0;
        WL   = 0;
        WLB  = 0;
        write_bit = 0;
        //write 0
        #10
        WL=1;
        WLB=1;
        preb = 1;      
        w_en = 1;
        //read Q
        #10 
        WL=0;
        WLB=0;
        w_en = 0;
        preb = 0;
        #10 
        WL=1;
        WLB=0;
        preb = 1;
        SAE  = 1;
        //read QB
        #10 
        WL=0;
        WLB=0;
        w_en = 0;
        preb = 0;
        #10 
        WL=0;
        WLB=1;
        preb = 1;
        SAE  = 1;
        //write 1
        #10
        WL=1;
        WLB=1;
        w_en = 1;
        write_bit = 1;
        preb = 1;
        //read Q
        #10 
        WL=0;
        WLB=0;
        w_en = 0;
        preb = 0;
        #10 
        WL=1;
        WLB=0;
        preb = 1;
        SAE  = 1;
        //read QB
        #10 
        WL=0;
        WLB=0;
        w_en = 0;
        preb = 0;
        #10 
        WL=0;
        WLB=1;
        preb = 1;
        SAE  = 1;

    end
endmodule