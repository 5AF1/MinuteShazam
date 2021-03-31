function [filtered_data] = lowpass(x, fs = 44100, fc = 5000, order = 5)
  
  [b,a] = butter(order,2*fc/fs);
  filtered_data = filter(b,a,x);
  
endfunction