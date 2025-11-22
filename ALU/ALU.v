// ===========================================================
//  ALU for RISC-V32I Processor
// ===========================================================

`timescale 1ns / 1ps

module alu #(
    parameter XLEN = 32
)(
    input  wire [XLEN-1:0] a,        // Operando A
    input  wire [XLEN-1:0] b,        // Operando B
    input  wire [3:0]      alu_ctrl, // Señal de control de la ALU
    output reg  [XLEN-1:0] result,   // Resultado de la operación
    output wire            zero      // Flag: resultado == 0
);

    // Señales internas
    wire signed [XLEN-1:0] a_signed = a;
    wire signed [XLEN-1:0] b_signed = b;

    // Lógica combinacional
    always @(*) begin
        case (alu_ctrl)
            2'b00: result = a + b;                            // ADD
            2'b01: result = a & b;                            // AND
            2'b10: result = a ^ b;                            // XOR
            2'b11: result = a_signed >>> b[4:0];              // SRA (aritmético)
            default: result = 32'd0;                            // NOP / por defecto
        endcase
    end

    // Bandera de cero
    assign zero = (result == 0);

endmodule
