module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   wire z;
   wire [31:0] s;
   assign  s = (aluc == 4'b0000)? a + b: 
               (aluc == 4'b1000)? a - b:
               (aluc == 4'b0111)? a & b: 
               //逻辑与&& 逻辑或|| 在这里是按位与或 按位之后位数不变，逻辑的话结果只是1一个0 or 1
               (aluc == 4'b0110)? a | b:
               (aluc == 4'b0100)? a ^ b:
               (aluc == 4'b0010)? b    :
               (aluc == 4'b0001)? a<<b :
               (aluc == 4'b0101)? a>>b : //logic
               (aluc == 4'b1101)? ({32{a[31]}}<<(~b[4:0])) | (a>>b[4:0]):
               //(aluc == 4'b1011)?  
               0;
// reg [31:0]s;
// reg [31:0]x;
// reg [5:0]i ;
 
// always@(*) begin
//    if(aluc==4'b0000) s = a + b;
//    else if(aluc == 4'b1000) s = a - b;
//    else if(aluc == 4'b0111) s = a & b;
//    else if(aluc == 4'b0110) s = a | b;
//    else if(aluc == 4'b0100) s = a ^ b;
////    begin
////                s = 0;
////                x = a ^ b;
////                for(i = 1; i<=32; i = i+1) begin 
////                        if(x & 1'b1)
////                        begin 
////                            s = s + 1;
////                        end
////                        x = x >> 1;
////                    end

////    end
//    else if(aluc == 4'b0010) s = b;
//    else if(aluc == 4'b0001) s = a << b;
//    else if(aluc == 4'b0101) s = a >> b;
//    else if(aluc == 4'b1101) s = ({32{a[31]}}<<(~b[4:0])) | (a>>b[4:0]);
//    else if(aluc == 4'b1011) 
//            begin 
//                s = 0;
//                x = a ^ b;
//                for(i = 1; i<=32; i = i+1) begin 
//                        if(x & 1'b1)
//                        begin 
//                            s = s + 1;
//                        end
//                        x = x >> 1;
//                    end
//            end
//end

  assign z = (s == 0); 
       
endmodule 