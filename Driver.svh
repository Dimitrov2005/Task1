class Driver extends uvm_driver #(Transaction);
   
   `uvm_component_utils(Driver)
     virtual iface viface;
   int 	     i;
   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction; // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase) ;
     
   endfunction // build_phase

   task run_phase(uvm_phase phase);
       Transaction tr;
      forever
	begin
	   wait (viface.TRESETN)
	     seq_item_port.get_next_item(tr);
	   //+++++++++++++ SHIFT INTO IR THE ADDRESS OF 1-ST TDR++++++++++++++++++++ //
	   if(tr.ADDR == 8'h45)  
	     begin
		$display(" addr %h",tr.ADDR);
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)
		  for(i=0;i<=7;i++) 
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 viface.WSI<=tr.ADDR[i];
		       $display("%h",tr.ADDR[i]);
		    end
		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		//--------------- SHIFT INTO IR THE ADDRESS OF 1-ST TDR  --------------------//
		
		//++++++++++++++ SHIFT DATA INTO 1-ST TDR ++++++++++++++++++++++++//
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)
		  for(i=0;i<16;i++)
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 viface.WSI<=tr.WSI[i];
		    end
		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		$display("%b",tr.WSI[16:0]);
		// -------------------- SHIFT DATA INTO 1-ST TDR -------------------- //
	     end // if (tr.ADDR == 8'h45)

	   
	   //--------------- SHIFT INTO IR THE ADDRESS OF 2-ND TDR --------------------//
	   else if (tr.ADDR==8'h77)
	     begin 
		$display(" addr %h",tr.ADDR);
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)
		  for(i=0;i<=7;i++) 
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 viface.WSI<=tr.ADDR[i];
		       $display("%h",tr.ADDR[i]);
		    end
		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		$display("%b",tr.WSI[32:0]);	 
		//--------------- SHIFT INTO IR THE ADDRESS OF 2-nd TDR  --------------------//
		
		//++++++++++++++ SHIFT DATA INTO 2-nd TDR ++++++++++++++++++++++++//
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)
		  for(i=0;i<16;i++)
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 viface.WSI<=tr.WSI[i];
		    end
		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		$display("%b",tr.WSI[16:0]);
		// -------------------- SHIFT DATA INTO 2-nd TDR -------------------- //
	     end // if (tr.ADDR==8'h77)
	   
	   seq_item_port.item_done();
	end //
   endtask // run_phase
endclass // Driver