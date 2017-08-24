class Driver extends uvm_driver #(Transaction);
   
   `uvm_component_utils(Driver)
     virtual iface viface;

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
	   @(negedge viface.TCLK)
	     
	     begin
		viface.TMS<=tr.TMS;
		viface.WSI<=tr.WSI;
		tr.WSO<=viface.WSO;
	     end
	   
	   seq_item_port.item_done();
	end //
   endtask // run_phase
endclass // Driver