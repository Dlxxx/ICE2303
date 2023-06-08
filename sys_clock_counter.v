module sys_clock_counter (clk,clrn,q);
   input  clk,clrn;
   output [31:0] q;
   reg [31:0]    q;
   always @ (negedge clrn or posedge clk)
      if (clrn == 0) begin
           //q <=0;
         q <= 0;
      end else begin
          q <= q + 32'b1;
      end
endmodule