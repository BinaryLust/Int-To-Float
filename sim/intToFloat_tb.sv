`timescale 1ns / 100ps

`define pZero   32'b0_00000000_00000000000000000000000 // positive zero
`define nZero   32'b1_00000000_00000000000000000000000 // negative zero
`define pInf    32'b0_11111111_00000000000000000000000 // positive infinity
`define nInf    32'b1_11111111_00000000000000000000000 // negative infinity
`define sNaN    32'b0_11111111_01000000000000000000000 // signaling not a number
`define qNaN    32'b0_11111111_10000000000000000000000 // quiet not a number
`define pDenorm 32'b0_00000000_00000000000000000000001 // positive smallest denormalized number
`define nDenorm 32'b1_00000000_00000000000000000000001 // negative smallest denormalized number


module intToFloat_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic        clk;
    logic        reset;
    logic [31:0] a;


    // output wires
    logic [31:0] result;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    intToFloat
    dut(
        .clk,
        .reset,
        .a,
        .result
    );


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer            seed               = 1942247;
    integer            errors             = 0;
    shortreal          floatResult;
    shortreal          expectedResult;
    logic      [31:0]  bitsExpectedResult;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset = 1'b0;
        a     = 32'd0;
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        // set the random seed
        $urandom(seed);

        // reset the system
        hardwareReset();

        // run the constrained random test
        repeat(3000000) begin
           @(posedge clk)
           a                  = randInt();

           @(negedge clk)
           floatResult        = $bitstoshortreal(result);
           expectedResult     = shortreal'(signed'(a));
           bitsExpectedResult = $shortrealtobits(expectedResult);

           if(result != bitsExpectedResult) begin
               $warning("Result Miss Match on: %d got: %.9g expected: %.9g",
                   a,
                   floatResult,
                   $bitstoshortreal(bitsExpectedResult)
               );
               $display("binary  got      - sign: %b exponent: %b fraction: %b\nbinary  expected - sign: %b exponent: %b fraction: %b",
                         result[31],             result[30:23],             result[22:0],
                         bitsExpectedResult[31], bitsExpectedResult[30:23], bitsExpectedResult[22:0],
               );
               $display("decimal got      - sign: %b exponent: %d fraction: %d\ndecimal expected - sign: %b exponent: %d fraction: %d\n",
                         result[31],             result[30:23],             result[22:0],
                         bitsExpectedResult[31], bitsExpectedResult[30:23], bitsExpectedResult[22:0],
               );
               errors++;
           end
        end

        $display("Total Errors: %d", errors);

        $stop;
    end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardwareReset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0;
    endtask


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* functions                                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    function logic [31:0] randInt();
        logic  [4:0]   r;

        r = $random();

        case(r)
            5'd0:    begin // return smallest postive number
                            randInt = 32'd0;
                     end
            5'd1:    begin // return smallest negative number
                            randInt = 32'hffffffff;
                     end
            5'd2:    begin // return largest positive number
                            randInt = 32'h7fffffff;
                     end
            5'd3:    begin // return largest negative number
                            randInt = 32'h80000000;
                     end
            default: randInt = $urandom;
        endcase
    endfunction


endmodule

