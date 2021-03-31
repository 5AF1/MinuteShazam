function [mono] = to_mono(x)
  
  mono = x(:,1);

  if size(x)(2) == 2
    mono = mono + x(:,2);
    mono = mono ./ 2;
  end 
  
endfunction