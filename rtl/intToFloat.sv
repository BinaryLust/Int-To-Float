
// start with a 32 bit signed integer
// get the absolute value of it but store the sign for later use.
// the initial exponent value is 2 ^ 30.
// we left shift this until the leading 1 is in bit 24 of the mantissa.
// we subtract the shift count from the exponent.
// the trailing 6-7 bits of the number are used for rounding.


module intToFloat(
    input   logic          clk,
    input   logic          reset,
    input   logic  [31:0]  a,

    output  logic  [31:0]  result
    );


    logic          zero;


    logic  [31:0]  absValue;


    logic  [7:0]   immExponent;
    logic  [31:0]  immFraction;


    logic  [5:0]   leadingZeros;


    logic  [7:0]   roundedExponent;
    logic  [24:0]  roundedFraction;


    logic  [7:0]   normalizedExponent;
    logic  [24:0]  normalizedFraction;


    //logic          resultSign;


    logic          fractionLSB;
    logic          roundBit;
    logic          stickyBit;


    always_comb begin
        zero        = a == 32'b0;

        absValue    = (a[31]) ? -a : a;

        immExponent = (8'd127 + 8'd31) - leadingZeros;
        immFraction = absValue << leadingZeros;

        // result rounding
        fractionLSB        =  immFraction[8]; // the least significant bit of the fraction, it is used for rounding to the nearest even
        roundBit           =  immFraction[7];
        stickyBit          = |immFraction[6:0];

        roundedExponent    =  immExponent;

        casex({fractionLSB, roundBit, stickyBit})
            3'b?00,
            3'b?01,
            3'b010: roundedFraction = immFraction[31:8];

            3'b110,
            3'b?11: roundedFraction = immFraction[31:8] + 25'd1;
        endcase

        // post rounding normalization
        normalizedFraction = (roundedFraction[24]) ? roundedFraction >> 1   : roundedFraction;
        normalizedExponent = (roundedFraction[24]) ? roundedExponent + 8'd1 : roundedExponent;

        if(zero)
            result = {1'b0, 8'd0, 23'd0}; // special case for zero
        else
            result = {a[31], normalizedExponent, normalizedFraction[22:0]};
    end


    leadingZerosDetector
    leadingZerosDetector(
        .value    (absValue),
        .zeros    (leadingZeros)
    );


endmodule

