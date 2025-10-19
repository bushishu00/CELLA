// SRAM Bank Control Signal Generator
// Supports MAC mode (diff) and CAM mode (single-ended)
module sram_bank_ctrl (
    input        clk,
    input        rst_n,
    input        w_en,      // write enable (high active)
    input        mac_en,    // 1: MAC mode (diff), 0: CAM mode (single-ended)

    output reg   preb,      // precharge enable (active low)
    output reg   sampleb,   // WL enable (active low, i.e., sampleb=0 => WL=1)
    output reg   sa_en,     // sense amplifier enable (high active)
    output reg   diff,      // SA input config: diff mode
    output reg   diffb      // SA input config: complementary
);

// Internal pipeline registers
reg w_en_d, mac_en_d;

// Pipeline: capture command at cycle start
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        w_en_d  <= 1'b0;
        mac_en_d <= 1'b0;
    end else begin
        w_en_d   <= w_en;
        mac_en_d <= mac_en;
    end
end

// Combinational control logic (for current cycle actions)
wire is_write = w_en_d;
wire is_read  = ~w_en_d;  // assuming CS is always asserted (simplified)

// Mode configuration for SA
always @(*) begin
    if (mac_en_d) begin
        // MAC mode: differential input
        diff  = 1'b1;
        diffb = 1'b0;
    end else begin
        // CAM mode: single-ended (e.g., force diffb high or disable)
        diff  = 1'b1;
        diffb = 1'b1;  // or 1'b0 depending on your SA design
    end
end

// Timing control: single-cycle operation
// We use the fact that in cycle N:
// - At clk↑: command is latched
// - During cycle N: precharge OFF, WL ON, SA ON
// - At next clk↑: restore precharge, turn off SA/WL

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        preb     <= 1'b0;   // precharge active (low)
        sampleb  <= 1'b1;   // WL off
        sa_en    <= 1'b0;
    end else begin
        // Default: precharge active, everything off
        preb  <= 1'b0;   // precharge ON (active low)
        sampleb <= 1'b1; // WL OFF
        sa_en <= 1'b0;

        if (is_write) begin
            // Write cycle
            preb     <= 1'b1;     // disable precharge
            sampleb  <= 1'b0;     // enable WL (active low)
            // SA should be OFF during write
            sa_en    <= 1'b0;
        end else if (is_read) begin
            // Read cycle
            preb     <= 1'b1;     // disable precharge
            sampleb  <= 1'b0;     // enable WL
            sa_en    <= 1'b1;     // enable SA
        end
        // else: idle, precharge remains on
    end
end

endmodule