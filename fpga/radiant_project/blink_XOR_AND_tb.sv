`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module blink_XOR_AND_tb();
 // Set up test signals
 logic clk, reset, counter, int_osc;
 logic [3:0] s;
 logic [2:0] led, led_expected;
 logic [31:0] vectornum, errors;
 logic [10:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]

 // Instantiate the device under test
 blink_XOR_AND dut(.clk(clk), .reset(reset), .s(s),.led(led));

 // Generate clock signal with a period of 10 timesteps.
 always
   begin
     clk = 1; #5;
     clk = 0; #5;
   end
  
    initial begin
        // Initialize test vectors manually
force dut.led[2] = 1'b1;
testvectors[0] = 7'b0000100;
testvectors[1] = 7'b1010101;
testvectors[2] = 7'b0101101;
testvectors[3] = 7'b1111110;

     vectornum = 0; errors = 0;
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {s, led_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("blink_XOR_AND_testbranch.vcd");
   $dumpvars(0, blink_XOR_AND_testbranch);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~reset) // skip during reset
       begin
         if (led != led_expected)
           begin
             $display("Error: inputs: s=%b", s);
             $display(" outputs: led=%b (%b expected)", led, led_expected);
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