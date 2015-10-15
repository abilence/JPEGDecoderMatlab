function [dc dc_mat]=define_dc_huffman_table(fid,length)
%DEFINE_DC_HUFFMAN_TABLE returns a huffman table for dc coefficients.
%The table has three fields - 1)category 2)length of the code 3)code word
%First, we enter the length field values in the table,then, we enter the
%category values and lastly we create the code word for each of the previous 
%entry.The first two fields are generated by reading data from the image 
%file while the code word for the corresponding entries in the first two 
%fields is actually calculated.The coding for dc_huffman_table and
%dc_huffman_table is quite similar.

len_counter=3;

j=1;temp_var1=0;
for x=1:16
   value=fread(fid,1);len_counter=len_counter+1;
   temp_var1=temp_var1+value;
   dc_mat(x,1)=temp_var1+1;
   if x~=16
       dc_mat(x,2)=fread(fid,1);fseek(fid,-1,'cof');
   else
       dc_mat(x,2)=0;
   end
   for i=1:value
      dc(j).length=x;j=j+1;
   end
end


for i=1:12
   dc(i).category=fread(fid,1);len_counter=len_counter+1;
end


dc(1).code='00';
for i=2:12
   if (dc(i).length) > (dc(i-1).length)
     prec=dc(i-1).length;
     prec=prec+1;
     temp1=bin2dec(dc(i-1).code);
     temp1=temp1+1;
     temp1=temp1*2;
     temp2=dec2bin(temp1,prec);
   else
     prec=dc(i-1).length;
     temp1=bin2dec(dc(i-1).code);
     temp1=temp1+1;
     temp2=dec2bin(temp1,prec);
   end
   dc(i).code=temp2;
end

if len_counter~=length
    fread(fid,1);
    len_counter=len_counter+1;
end    

end
