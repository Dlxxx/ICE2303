module alu (a,b,aluc,s,z, flag_small);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   output flag_small;
   reg flag_small;
   wire z;
//   wire [31:0] s;
//   assign  s = (aluc == 4'b0000)? a + b: 
//               (aluc == 4'b1000)? a - b:
//               (aluc == 4'b0111)? a & b: 
//               //�߼���&& �߼���|| �������ǰ�λ��� ��λ֮��λ�����䣬�߼��Ļ����ֻ��1һ��0 or 1
//               (aluc == 4'b0110)? a | b:
//               (aluc == 4'b0100)? a ^ b:
//               (aluc == 4'b0010)? b    :
//               (aluc == 4'b0001)? a<<b :
//               (aluc == 4'b0101)? a>>b : //logic
//               (aluc == 4'b1101)? ({32{a[31]}}<<(~b[4:0])) | (a>>b[4:0]):
//               //(aluc == 4'b1011)?  
//               0;
 reg [31:0]s;
 reg [31:0]x;
 reg [5:0]i ;
 
 always@(*) begin
    if(aluc==4'b0000) s = a + b;
    else if(aluc == 4'b1000) s = a - b;
    else if(aluc == 4'b0111) s = a & b;
    else if(aluc == 4'b0110) s = a | b;
    else if(aluc == 4'b0100) s = a ^ b;
    else if(aluc == 4'b0010) s = b;
    else if(aluc == 4'b0001) s = a << b;
    else if(aluc == 4'b0101) s = a >> b;
    else if(aluc == 4'b1101) s = ({32{a[31]}}<<(~b[4:0])) | (a>>b[4:0]);
    else if(aluc == 4'b1011) 
            begin 
                s = a-b;
               if(s[31]==1) begin
                 flag_small = 1;
               end
               else begin
                    flag_small = 0;
                    end
            end
end

  assign z = (s == 0); 
       
endmodule 