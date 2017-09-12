module mux21(
	   input
	   select,
	   in0,
	   in1,
	   output reg
	   out
	   );
   
   always @(select or in1 or in0)
     case(select)
       1'b1 : out=in0;
       1'b0 : out=in1;
       default:out=1'bx;
     endcase
endmodule // mux
