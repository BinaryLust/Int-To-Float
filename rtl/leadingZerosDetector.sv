

module leadingZerosDetector(
    input   logic  [31:0]  value,
    output  logic  [5:0]   zeros
    );


    logic  [7:0][1:0]  zeroGroup;
    logic  [7:0]       allZeros;


    always_comb begin
        casex(allZeros)
            8'b10??_????: zeros = 6'd4  + zeroGroup[6];
            8'b110?_????: zeros = 6'd8  + zeroGroup[5];
            8'b1110_????: zeros = 6'd12 + zeroGroup[4];
            8'b1111_0???: zeros = 6'd16 + zeroGroup[3];
            8'b1111_10??: zeros = 6'd20 + zeroGroup[2];
            8'b1111_110?: zeros = 6'd24 + zeroGroup[1];
            8'b1111_1110: zeros = 6'd28 + zeroGroup[0];
            8'b1111_1111: zeros = 6'd32;
            default:      zeros = 6'd0  + zeroGroup[7];
        endcase
    end


    subZerosDetector
    subZerosDetector0(
        .value       (value[3:0]),
        .zeros       (zeroGroup[0]),
        .allZeros    (allZeros[0])
    );


    subZerosDetector
    subZerosDetector1(
        .value       (value[7:4]),
        .zeros       (zeroGroup[1]),
        .allZeros    (allZeros[1])
    );


    subZerosDetector
    subZerosDetector2(
        .value       (value[11:8]),
        .zeros       (zeroGroup[2]),
        .allZeros    (allZeros[2])
    );


    subZerosDetector
    subZerosDetector3(
        .value       (value[15:12]),
        .zeros       (zeroGroup[3]),
        .allZeros    (allZeros[3])
    );


    subZerosDetector
    subZerosDetector4(
        .value       (value[19:16]),
        .zeros       (zeroGroup[4]),
        .allZeros    (allZeros[4])
    );


    subZerosDetector
    subZerosDetector5(
        .value       (value[23:20]),
        .zeros       (zeroGroup[5]),
        .allZeros    (allZeros[5])
    );


    subZerosDetector
    subZerosDetector6(
        .value       (value[27:24]),
        .zeros       (zeroGroup[6]),
        .allZeros    (allZeros[6])
    );


    subZerosDetector
    subZerosDetector7(
        .value       (value[31:28]),
        .zeros       (zeroGroup[7]),
        .allZeros    (allZeros[7])
    );


endmodule

