//Verilog HDL for "CIM_macro", "verilog_onebit_stimulus" "functional"


module onebit_stimulus (
    output reg preb, w_en, write_bit, sampleb,
    output reg SAE, WL, WLB
);

    // Main stimulus sequence
    initial begin
    // reset
    write_bit = 0;

    w_en = 0;
    WL   = 0;
    WLB  = 0;

    preb = 0;
    sampleb = 1;
    SAE  = 0;
    // write 1
    #10
    write_bit = 1;

    w_en = 1;
    WL   = 1;
    WLB  = 1;

    preb = 1;
    sampleb = 1;
    SAE  = 0;
    
    // read 1(Q)
        // precharge
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
        // sample
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 1;
        WLB  = 0;

        preb = 1;
        sampleb = 0;
        SAE  = 0;
        // sense amplify
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 1;
        sampleb = 1;
        SAE  = 1;
        // reset
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
    // read 0(QB)
        // precharge
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
        // sample
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 1;

        preb = 1;
        sampleb = 0;
        SAE  = 0;
        // sense amplify
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 1;
        sampleb = 1;
        SAE  = 1;
        // reset
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
    
    // read Q with another timing
        // precharge
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
        // sample and sa
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 1;
        WLB  = 0;

        preb = 1;
        sampleb = 0;
        SAE  = 1;
        // reset
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
	// read QB with another timing
        // precharge
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
        // sample and sa
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 1;

        preb = 1;
        sampleb = 0;
        SAE  = 1;
        // reset
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;

	// read Q=1 with new timing
		// pre
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
        // sample
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 1;

        preb = 1;
        sampleb = 0;
        SAE  = 0;
        // sample, sa
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 1;

        preb = 1;
        sampleb = 0;
        SAE  = 1;
		// sa
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 1;
        sampleb = 1;
        SAE  = 1;
		// reset
        #10
        write_bit = 1;

        w_en = 0;
        WL   = 0;
        WLB  = 0;

        preb = 0;
        sampleb = 1;
        SAE  = 0;
    end
endmodule