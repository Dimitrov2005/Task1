class Sequence extends uvm_sequence#(Transaction);
   `uvm_object_utils(Sequence)
     // addr1=8'h45,17bit size RW
     // addr2=8'h77;33 bit size R
      
int num=1;
      
     Transaction tr; 
   
      function new(string name="");
	 super.new(name);
      endfunction // new

      task body ();
	 repeat(num)
	   begin
	      tr=new("tr");
		 start_item(tr);
	      
	      assert(tr.randomize() with {tr.ADDR dist {8'h45:/50,
							8'h77:/50};
					  })
                 else `uvm_fatal("FE","Fatal Error During Randomization");
		 finish_item(tr);
	       
	   end
      endtask // body
   endclass // Sequence
