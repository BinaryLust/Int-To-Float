

module subZerosDetector(
    input   logic  [3:0]  value,
    output  logic  [1:0]  zeros,  // this zero count is only valid if the allZeros line isn't set.
    output  logic         allZeros
    );


    always_comb begin
        casex(value)
            4'b1???: begin allZeros = 1'b0; zeros = 2'd0; end
            4'b01??: begin allZeros = 1'b0; zeros = 2'd1; end
            4'b001?: begin allZeros = 1'b0; zeros = 2'd2; end
            4'b0001: begin allZeros = 1'b0; zeros = 2'd3; end
            4'b0000: begin allZeros = 1'b1; zeros = 2'd0; end
        endcase
    end


endmodule

