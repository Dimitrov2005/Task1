module ClkGater(
		input
		clk,
		en,
		output reg
		clk_out
		);
   reg 			  en_out;
   always@(en or clk)
     begin
     if(~clk)
       en_out=en;
     end
   assign clk_out=en_out&&clk;
       
endmodule // ClkGater
