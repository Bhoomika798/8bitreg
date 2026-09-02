 module reg8 (
    input  logic       clk,
    input  logic       reset,
    input  logic       clear,
    input  logic       load,
    input  logic [7:0] D,
    output logic [7:0] Q
);

always @(posedge clk) begin
    if (reset)
        Q <= 8'h00;
    else if (clear)
        Q <= 8'h00;
    else if (load)
        Q <= D;
end

endmodule