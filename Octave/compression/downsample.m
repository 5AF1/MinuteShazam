function [dx,dfs] = downsample(x, fs = 44100, factor = 2)
  factor = floor(factor);
  if mod(length(x),factor) != 0
    a = floor(length(x)/factor);
    x = x(1:a*factor,:);
  endif
  
  dx = zeros(floor(length(x)/factor),size(x)(2));
  
  for i = 1:length(dx)
    dx(i) = max(x((i-1)*factor+1:i*factor));
  endfor
  dfs = fs / factor;
  
endfunction