module blink_XOR_AND(
input wire clk,
input wire reset,
input wire [3:0] s,
output wire [2:0] led
);

//logic int_osc;
logic [11:0] counter;

  // Internal low-speed oscillator
 //  LSOSC 
       // lf_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));
		 
	 // Counter
   always_ff @(posedge clk, posedge reset) begin
     if(reset == 0)  
		 counter <= 0;
     else            
		 counter <= counter + 1;
   end
   
  
  
assign led[0] = s[0] ^ s[1];
assign led[1] = s[2] & s[3];
assign led[2] = counter[11];

endmodule