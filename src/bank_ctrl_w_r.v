
module bank_ctrl (
    input clk,
    input rst_n,
    input w_en,      
    input r_en,
    output reg preb,    
    output reg w_drv,  
    output reg sampleb,   
    output reg sa_en 
);

    parameter [3:0] PRE    = 4'b0001;
    parameter [3:0] WRITE  = 4'b0010;
    parameter [3:0] SENSE1 = 4'b0100;
    parameter [3:0] SENSE2 = 4'b1000;

    reg [3:0] state, next_state;

    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= PRE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            PRE: begin // TODO: process w_en=1 and r_en=1
                if (w_en)
                    next_state = WRITE;
                else if (r_en)
                    next_state = SENSE1;
                else
                    next_state = PRE;
            end
            WRITE: begin
                // Write lasts 1 cycle, then back to PRE
                next_state = PRE;
            end
            SENSE1: begin
                // After disabling precharge, go to SA enable
                next_state = SENSE2;
            end
            SENSE2: begin
                // SA lasts 1 cycle, then back to PRE
                next_state = PRE;
            end
            default: next_state = PRE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            PRE: begin
                preb    = 1'b0;  // enable precharge (active low)
                w_drv   = 1'b0;  // disable write driver
                sampleb = 1'b1;  // disconnect SA
                sa_en   = 1'b0;  // disable SA
            end
            WRITE: begin
                preb    = 1'b1;  // disable precharge
                w_drv   = 1'b1;  // enable write driver
                sampleb = 1'b1;  // keep SA disconnected
                sa_en   = 1'b0;
            end
            SENSE1: begin
                preb    = 1'b1;  // disable precharge (bitlines discharge)
                w_drv   = 1'b0;  // disable write driver
                sampleb = 1'b0;  // SA still off
                sa_en   = 1'b0;
            end
            SENSE2: begin
                preb    = 1'b1;  // keep precharge off
                w_drv   = 1'b0;  // disable write driver
                sampleb = 1'b1;  // connect BL/BLB to SA
                sa_en   = 1'b1;  // enable SA
            end
            default: begin
                preb    = 1'b0;
                w_drv   = 1'b0;
                sampleb = 1'b1;
                sa_en   = 1'b0;
            end
        endcase
    end

endmodule