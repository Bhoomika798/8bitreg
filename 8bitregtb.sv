`timescale 1ns/1ps

module tb_reg8;

    logic       clk;
    logic       reset;
    logic       clear;
    logic       load;
    logic [7:0] D;
    logic [7:0] Q;

    // Instantiate the 8-bit register
    reg8 dut (
        .clk   (clk),
        .reset (reset),
        .clear (clear),
        .load  (load),
        .D     (D),
        .Q     (Q)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin

        // Initial values
        clk   = 0;
        reset = 0;
        clear = 0;
        load  = 0;
        D     = 8'h00;

        // Test 1: Reset
        #10;
        reset = 1;
        clear = 0;
        load  = 0;
        D     = 8'h00;

        // Test 2: Load A5
        #10;
        reset = 0;
        clear = 0;
        load  = 1;
        D     = 8'hA5;

        // Test 3: Load 3C
        #10;
        D = 8'h3C;

        // Test 4: Hold
        #10;
        load = 0;
        D = 8'hF0;

        // Test 5: Clear
        #10;
        clear = 1;
        load = 0;
        D = 8'hF0;

        // Test 6: Load 55
        #10;
        clear = 0;
        load = 1;
        D = 8'h55;

        // Test 7: Clear + Load
        // Clear has higher priority, so Q should become 00
        #10;
        clear = 1;
        load = 1;
        D = 8'hAA;

        // Test 8: Reset + Load
        // Reset has higher priority, so Q should become 00
        #10;
        reset = 1;
        clear = 0;
        load = 1;
        D = 8'hFF;

        // Test 9: Reset + Clear + Load
        // Reset has highest priority
        #10;
        reset = 1;
        clear = 1;
        load = 1;
        D = 8'h77;

        // Test 10: Load 12
        #10;
        reset = 0;
        clear = 0;
        load = 1;
        D = 8'h12;

        #10;

        $finish;
    end

    // Display values
    initial begin
        $monitor("Time=%0t | Reset=%b Clear=%b Load=%b D=%h | Q=%h",
                 $time, reset, clear, load, D, Q);
    end

endmodule