module IR(input 
	   CaptureIR,
	   ShiftIR,
	   UpdateIR,
	   TRESETN,
	   TCLK,          
	   SI,          //Serial input
	   output
	  [7:0] PO           //parralel output
	   );
   

   reg [7:0] serialReg,parallelReg;
  
   always @(posedge TCLK or negedge TRESETN)
     if(~TRESETN)
       serialReg<='b0;
     else if(ShiftIR)
       serialReg<={SI,serialReg[7:1]};
     else if(CaptureIR)
       serialReg[7:0]<=8'h77;
     else 
       serialReg<=serialReg;
   
   
   always @(posedge TCLK or negedge TRESETN)
     if(~TRESETN)
       parallelReg<='b0;
     else if (UpdateIR)
       parallelReg<=serialReg;
     else 
       parallelReg<=parallelReg;

   
   assign SO=serialReg[7];
   assign PO=parallelReg;
   
   
endmodule
