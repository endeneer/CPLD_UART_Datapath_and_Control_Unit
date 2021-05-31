module hex_display(
    input  [3:0] i_hex,
    output reg [6:0] o_segment
    );
	//o_segment[6] is A
	//o_segment[0] is G
	always @(i_hex)
		begin
			case (i_hex)
				  4'b0000 : o_segment <= 7'h7E; //0
				  4'b0001 : o_segment <= 7'h30; //1
				  4'b0010 : o_segment <= 7'h6D; //2
				  4'b0011 : o_segment <= 7'h79; //3
				  4'b0100 : o_segment <= 7'h33; //4      
				  4'b0101 : o_segment <= 7'h5B; //5
				  4'b0110 : o_segment <= 7'h5F; //6
				  4'b0111 : o_segment <= 7'h70; //7
				  4'b1000 : o_segment <= 7'h7F; //8
				  4'b1001 : o_segment <= 7'h7B; //9
				  4'b1010 : o_segment <= 7'h77; //A
				  4'b1011 : o_segment <= 7'h1F; //B
				  4'b1100 : o_segment <= 7'h4E; //C
				  4'b1101 : o_segment <= 7'h3D; //D
				  4'b1110 : o_segment <= 7'h4F; //E
				  4'b1111 : o_segment <= 7'h47; //F
			endcase
		end

endmodule
