// SRAM Bank Control Signal Generator
// Supports MAC mode (diff) and CAM mode (single-ended)
module Sbank_ctrl (
    input clk,
    input rst_n,
    input w_en,      // write enable (high active)
    input mac_en,    // 1: MAC mode (diff), 0: CAM mode (single-ended)

    output reg [7:0] preb,      // precharge enable (active low)
    output reg [7:0] sampleb,   // WL enable (active low, i.e., sampleb=0 => WL=1)
    output reg [7:0] sa_en     // sense amplifier enable (high active)
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