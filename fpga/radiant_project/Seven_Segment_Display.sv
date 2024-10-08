module seven_segdisplay(
input logic reset,
input logic [3:0] s,
output logic [6:0] seg
);

logic [11:0] counter;


		 
	 // Counter
   always_ff @(posedge reset) begin
    if(reset)  
                    counter <= 0;
     else            
                    counter <= counter + 1;
   end
   

always_comb begin 
   case(s)
		4'b0000 : seg	= 7'b0000001; // display 0
		4'b0001 : seg= 7'b1001111; // display 1
		4'b0010 : seg= 7'b0010010; // display 2
		4'b0011 : seg= 7'b0000110; // display 3
		4'b0100 : seg= 7'b1001100; // display 4
		4'b0101 : seg= 7'b0100100; // display 5
		4'b0110 : seg= 7'b0100000; // display 6
		4'b0111 : seg= 7'b0001111; // display 7
		4'b1000 : seg= 7'b0000000; // display 8
		4'b1001 : seg= 7'b0000100; // display 9
		4'b1010 : seg = 7'b0001000; // display A
		4'b1011 : seg = 7'b1100000; // display b
		4'b1100 : seg = 7'b0110001; // display C
		4'b1101 : seg = 7'b1000010; //display d
		4'b1110 : seg = 7'b0110000; // display E
		4'b1111 : seg = 7'b0111000; // display F
		default: seg = 7'b1111111; // display nothing 
endcase

end

  endmodule