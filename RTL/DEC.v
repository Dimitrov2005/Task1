module dec(input 
	   [7:0]x, // 
	   output reg
	   EN1,
	   EN2,
	   EN3,
	   EN4
	   );

   always @(x)
     if(x==8'h45) // address of TDR1 in binary
       begin
	  EN1=1;
	  EN2=0;
	  EN3=0;
	  EN4=0;
       end
     else if (x==8'h77) // address of TDR2
       begin
	  EN1=0;
	  EN2=1;
	  EN3=0;
	  EN4=0;
       end 
     else if (x==8'h54) // address of TDR2
       begin
	  EN1=0;
	  EN2=0;
	  EN3=1;
	  EN4=0;
       end
    else if (x==8'h55) // address of TDR2
       begin
	  EN1=0;
	  EN2=0;
	  EN3=0;
	  EN4=1;
       end
     else
       begin
	  EN1=0;
	  EN2=0;
	  EN3=0;
	  EN4=0;
       end
   
endmodule // dec