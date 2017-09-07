class Driver extends uvm_driver #(Transaction);
   
   `uvm_component_utils(Driver)
     virtual iface viface;
   int 	     i;
   bit 	     WSI[];

   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction; // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase) ;
     
   endfunction // build_phase

   task run_phase(uvm_phase phase);
       Transaction tr;	
      @(negedge viface.TCLK) viface.TMS<=1;//TLR->IDLE
      @(negedge viface.TCLK)	viface.TMS<=0;
      forever
	begin
	   wait (viface.TRESETN)
	     seq_item_port.get_next_item(tr);
	   //+++++++++++++ SHIFT INTO IR THE ADDRESS OF 1-ST TDR++++++++++++++++++++ //

  
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=1;
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK)
		  for(i=0;i<=7;i++) 
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 viface.WSI<=tr.ADDR[i];
		    end
		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		//--------------- SHIFT INTO IR THE ADDRESS OF 1-ST TDR  --------------------//
		
		//++++++++++++++ SHIFT DATA INTO 1-ST TDR ++++++++++++++++++++++++//
		 
		@(negedge viface.TCLK)	viface.TMS<=0;
		@(negedge viface.TCLK) 
		

		  for(i=0;i<(tr.WSI.size());i++)
		    begin
		       viface.TMS<=0;
		       @(negedge viface.TCLK)
			 
			 viface.WSI<=tr.WSI[i];
		    end

		viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=1;
		@(negedge viface.TCLK) viface.TMS<=0;
		// -------------------- SHIFT DATA INTO 1-ST TDR -------------------- //


	   
	  
	   seq_item_port.item_done();
	end //
   endtask // run_phase
endclass // Driver