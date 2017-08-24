module STAC (input 
	     TMS,
	     TCLK,
	     TRESETN,
	     WSI,
	     output 
	     WSO);

   wire 	    CaptureDR;
   wire 	    ShiftDR;
   wire 	    UpdateDR;
   wire 	    CaptureIR;
   wire 	    ShiftIR;
   wire 	    UpdateIR;
		 
   wire 	    en1;
   wire 	    en2;
   wire 	    si1_mux;
   wire 	    si2_mux;
   wire [7:0] 	    ir_po;

	
   fsm fsm(.TMS(TMS),
	   .TDI(WSI),
	   .TRSTN(TRESETN),
	   .TCLK(TCLK),
	   .CaptureDR(CaptureDR),
	   .ShiftDR(ShiftDR),
	   .UpdateDR(UpdateDR),
	   .CaptureIR(CaptureIR),
	   .ShiftIR(ShiftIR),
	   .UpdateIR(UpdateIR)
	   );

   dec dec1(.x(ir_po),
	   .EN1(en1),
	   .EN2(en2)
	    );
	  

   mux mux1( .SO1(si1_mux),
	     .SO2(si2_mux),
	     .e(ir_po),
	     .WSO(WSO)
	     );
  
   IR ir1( .CaptureIR(CaptureIR),
	   .ShiftIR(ShiftIR),
	   .UpdateIR(UpdateIR), 
	   .TRESETN(TRESETN),
	   .TCLK(TCLK),          
	   .SI(WSI), 
	   .PO(ir_po)
	   );
   
   TDR #(17,45)tdr1(.CaptureDR(CaptureDR), //turn 45 to hexadecimal
	.ShiftDR(ShiftDR),
	.UpdateDR(UpdateDR),
	.Enable(en1),
	.TRESETN(TRESETN),
	.TCLK(TCLK), 
	.SI(WSI),
	.SO(si1_mux)
	);
   
   TDR #(33,77) tdr2(.CaptureDR(CaptureDR), // turn 77 to hexadecimal
	.ShiftDR(ShiftDR),
	.UpdateDR(UpdateDR),
	.Enable(en2),
	.TRESETN(TRESETN),
	.TCLK(TCLK), 
	.SI(WSI),
	.SO(si2_mux)
	);

endmodule // STAC
