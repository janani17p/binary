Write synthesizable Verilog-2001 code for a module named `binary_to_bcd_converter`.

Requirements:
- Module name: `binary_to_bcd_converter`
- Input port: `binary_input` (5-bit, [4:0])
- Output port: `bcd` (8-bit reg, [7:0])
- Use the “double dabble” (shift-add-3) algorithm in the correct order:
  1. For each bit of the input (starting from MSB to LSB):
     a) If any BCD nibble >= 5, add 3 to that nibble.
     b) Then shift left by 1 and insert the next input bit into the least-significant bit of the ones nibble.
- The output `bcd[7:4]` should be the tens digit, `bcd[3:0]` should be the ones digit.
- The design must be purely combinational (`always @*`).
- Do not rename the ports. Keep them exactly `binary_input` and `bcd`.

End of prompt.
