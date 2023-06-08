module sc_cpu (clock,resetn,inst,mem,pc,wmem,aluout,data);
   input [31:0] inst,mem;
   input clock,resetn;
   output [31:0] pc,aluout,data;
   output wmem;
  
   wire [31:0]   p4,branchpc,jalrpc,npc,immediate;
   wire [31:0]   ra,rb,regf_din;//regfile output a,b, input data
   wire [31:0]   alua,alub,alu_mem;
   wire [3:0]    aluc;
   wire [1:0]    pcsource;// 00 normal; 01 beq,bne;10 jalr;11 jal
   wire          zero,wmem,wreg,m2reg,aluimm,sext,i_lui,i_sw,shift;
  //pc register unit ,dff32
  dff32 ip (npc,clock,resetn,pc);  // define a D-register for PC
  
  //immedate data extent unit ,   immext
  immext ImmGen(inst, sext, i_lui, i_sw, shift, pcsource, immediate);// generate ext immediate,

  //register file,   mux2x32 , regfile
   mux2x32 muxRegf_din(alu_mem, p4, pcsource[1], regf_din);
   regfile rf(inst[19:15], inst[24:20], regf_din, inst[11:7], wreg, clock, resetn, ra, rb);
   assign data = rb;
    
  //control unit ,sc_cu
  sc_cu cu (inst,zero,wmem,wreg,m2reg,aluc,aluimm,pcsource,sext,i_lui,i_sw,shift);

  //alu unit   , mux2x32,alu
  mux2x32 muxAlub(rb, immediate, aluimm, alub);
  alu ALU(ra, alub, aluc, aluout, zero);

  //next pc generate ,   cla32 ,mux4x32
  cla32 pcplus4(pc, 32'd4, 32'd0, p4);// pc+4 - 00
  cla32 calBranchpc(pc, immediate, 32'd0, branchpc); //for beq bne-01 jal-11
  cla32 calJalrpc(ra, immediate, 32'd0, jalrpc);// jalr 10
  mux4x32 nextPc(p4, branchpc, jalrpc, branchpc, pcsource, npc);
   
  //write back register file,   mux2x32 
  mux2x32 muxWBreg(aluout, mem, m2reg, alu_mem);

   endmodule