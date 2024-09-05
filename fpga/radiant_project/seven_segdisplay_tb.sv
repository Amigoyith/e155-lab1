`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module sevenseg_tb();
 // Set up test signals
 logic clk, reset;
 logic [3:0] s;
 logic [6:0] seg, seg_expected;
 logic [31:0] vectornum, errors;
 logic [10:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]

 // Instantiate the device under test
 seven_segdisplay dut( .clk(clk),.reset(reset), .s(s),.seg(seg));

 // Generate clock signal with a period of 10 timesteps.
 always
   begin
     clk = 1; #5;
     clk = 0; #5;
   end
  
    initial begin
        // Initialize test vectors manually
testvectors[0] = 11'b00000000001;
testvectors[1] = 11'b00011001111;
testvectors[2] = 11'b00100010010;
testvectors[3] = 11'b00110000110;
testvectors[4] = 11'b01001001100; 
testvectors[5] = 11'b01010100100;
testvectors[6] = 11'b01100100000;
testvectors[7] = 11'b01110001111;
testvectors[8] = 11'b10000000000;
testvectors[9] = 11'b10010000100;
testvectors[10] = 11'b10100001000;
testvectors[11] = 11'b10111100000;
testvectors[12] = 11'b11000110001;
testvectors[13] = 11'b11011000010;
testvectors[14] = 11'b11100110000;
testvectors[15] = 11'b11110111000;
testvectors[15] = 11'b11110111000;
     vectornum = 0; errors = 0;
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {s, seg_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("sevenseg_tb.vcd");
   $dumpvars(0, sevenseg_tb);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~reset) // skip during reset
       begin
         if (seg != seg_expected)
           begin
             $display("Error: inputs: s=%b", s);
             $display(" outputs: seg=%b (%b expected)", seg, seg_expected);
             errors = errors + 1;
           end

      
       vectornum = vectornum + 1;
      
       if (testvectors[vectornum] === 11'bx)
         begin
           $display("%d tests completed with %d errors.", vectornum, errors);
           $finish;
         end
     end
   end
endmodule