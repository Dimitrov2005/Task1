class Transaction extends uvm_sequence_item;
   `uvm_object_utils(Transaction);

   rand bit[32:0] WSI;
   rand logic [7:0] ADDR;
   logic WSO;

   function new(string name ="");
      super.new(name);
   endfunction // new

endclass // Transaction
