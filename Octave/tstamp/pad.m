function [x] = pad(x,n)
  
  po2 = 2**ceil(log2(n));
  
  x = [x;zeros(po2-size(x)(1),size(x)(2))];  
  
endfunction