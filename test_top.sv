module top;
  import uvm_pkg::*;
  import pack_all::*;  
`include "uvm_macros.svh"
 
   bit TCLK,TRESETN;  
   iface iface1(TCLK,TRESETN);
   virtual iface viface=iface1;

   STAC stc(.TMS(iface.TMS),
	    .TCLK(iface.TCLK),
	    .TRESETN(iface.TRESETN),
	    .WSI(iface.WSI),
	    .WSO(iface.WSO));
	    
   initial
     begin
	TCLK=0;
	TRESETN=1;
	#1ps TRESETN=0;
	#5ps TRESETN=1;
	
     end
  
 always #5ps TCLK=~TCLK;

   initial 
     begin
	uvm_config_db #(virtual iface)::set  (null,"","viface",viface);
	run_test("test");	
	#1000ps $finish();
     end
endmodule:top