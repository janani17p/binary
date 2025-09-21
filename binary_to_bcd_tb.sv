module binary_to_bcd_converter (
    input wire [4:0] binary_input, // 5-bit binary input
    output reg [7:0] bcd_output     // 8-bit BCD output (4 bits for tens, 4 bits for ones)
);

// Internal registers for BCD representation
reg [3:0] bcd_tens; // Tens place
reg [3:0] bcd_ones; // Ones place
integer i; // Loop variable

always @* begin
    // Initialize BCD values to 0
    bcd_tens = 4'b0000;
    bcd_ones = 4'b0000;

    // Convert binary to BCD using double-dabble algorithm
    for (i = 0; i < 5; i = i + 1) begin
        // Shift left the BCD digits to make room for the next binary bit
        if (bcd_tens >= 5)
            bcd_tens = bcd_tens + 4'b0011; // Add 3 to tens place if necessary

        if (bcd_ones >= 5)
            bcd_ones = bcd_ones + 4'b0011; // Add 3 to ones place if necessary

        // Shift BCD values left to add a new binary bit
        {bcd_tens, bcd_ones} = {bcd_tens, bcd_ones} << 1;

        // Add the next bit of the binary input
        bcd_ones[0] = binary_input[4 - i]; // Add the next bit of the binary input
    end

    // Combine BCD places into the final output
    bcd_output = {bcd_tens, bcd_ones};
end

endmodule

module tb;

reg [4:0] binary_input;
wire [7:0] bcd_output;

binary_to_bcd_converter uut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
);

integer i;
reg [4:0] test_binary;
reg [7:0] expected_bcd;

initial begin
    $display("Testing Binary-to-BCD Converter...");

    for (i = 0; i < 32; i++) begin
        test_binary = i;
        binary_input = test_binary;

        // Calculate expected BCD output
        expected_bcd[3:0] = test_binary % 10;
        expected_bcd[7:4] = test_binary / 10;

        #10; // Wait for the results

        if (bcd_output !== expected_bcd) begin
            $display("Error: Test case %0d failed. Expected BCD: 8'b%0b, Got: 8'b%0b",
                     test_binary, expected_bcd, bcd_output);
            $finish;
        end
    end

    $display("All test cases passed!");
    $finish;
end

reg vcd_clk;
initial begin
    $dumpfile("my_design.vcd");
    $dumpvars(0, tb);
end

always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units

endmodule
