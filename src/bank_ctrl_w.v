
module bank_ctrl (
    input clk,
    input rst_n,
    input w_en,      
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
            PRE: begin 
                next_state = w_en ? WRITE : SENSE1;
            end
            WRITE: begin
                next_state = w_en ? WRITE : PRE;
            end
            SENSE1: begin
                // After disabling precharge, go to SA enable
                next_state = SENSE2;
            end
            SENSE2: begin
                // SA lasts 1 cycle, then back to PRE
                next_state = w_en ? WRITE : PRE;
            end
            default: next_state = PRE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            PRE: begin
                preb    = 1'b0;  
                w_drv   = 1'b0;  
                sampleb = 1'b1;  
                sa_en   = 1'b0;  
            end
            WRITE: begin
                preb    = 1'b1;  
                w_drv   = 1'b1;  
                sampleb = 1'b1;  
                sa_en   = 1'b0;
            end
            SENSE1: begin
                preb    = 1'b1;  
                w_drv   = 1'b0;  
                sampleb = 1'b0;  
                sa_en   = 1'b0;
            end
            SENSE2: begin
                preb    = 1'b1;  
                w_drv   = 1'b0;  
                sampleb = 1'b1;  
                sa_en   = 1'b1;  
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