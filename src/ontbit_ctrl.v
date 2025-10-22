module onebit_generator (
    input clk,
    input w_en,
    output reg preb,
    output reg sampleb,
    output reg sa_en,
    output reg write_bit,
    output reg WL,
    output reg WLB
);
    // Internal registers
    reg w_en_d;

    // Pipeline: capture command at cycle start
    always @(posedge clk) begin
        w_en_d <= w_en;
    end

    // Combinational control logic
    wire is_write = w_en_d;
    wire is_read  = ~w_en_d;  // assuming CS is always asserted (simplified)

    // Timing control: single-cycle operation
    always @(posedge clk) begin
        // Default: precharge active, everything off
        preb     <= 1'b0;   // precharge ON (active low)
        sampleb  <= 1'b1;   // WL OFF
        sa_en    <= 1'b0;
        write_bit <= 1'b0;
        WL       <= 1'b0;
        WLB      <= 1'b0;

        if (is_write) begin
            // Write cycle
            preb     <= 1'b1;     // disable precharge
            sampleb  <= 1'b0;     // enable WL (active low)
            write_bit <= 1'b1;    // indicate write operation
            WL       <= 1'b1;     // WL high
            WLB      <= 1'b0;     // WLB low
            // SA should be OFF during write
            sa_en    <= 1'b0;
        end else if (is_read) begin
            // Read cycle
            preb     <= 1'b1;     // disable precharge
            sampleb  <= 1'b0;     // enable WL
            sa_en    <= 1'b1;     // enable SA
            WL       <= 1'b1;     // WL high
            WLB      <= 1'b0;     // WLB low
        end
    end
endmodule