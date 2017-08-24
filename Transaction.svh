class Transaction extends uvm_sequence_item;
   `uvm_object_utils(Transaction);

   rand logic TMS,WSI;
   logic WSO;

   function new(string name ="");
      super.new(name);
   endfunction // new

endclass // Transaction
