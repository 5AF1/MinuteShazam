function [xr,X,Xr] = compression(x,p)
  n = length(x);
  x = pad(x, length(x));
  N = length(x);
  %Fast Fourier Transform
  X = fft(x);
  %Shift for proper orientation
  X = fftshift(X);
  %Reduced Frequency domain output
  Xr = zeros(size(x));
  Xr(int32(N*((p/100)/2))+1 : int32(N*(1-(p/100)/2)),:) = X(int32(N*((p/100)/2))+1 : int32(N*(1-(p/100)/2)),:);
  %real component of IFFT
  xr = ifft(fftshift(Xr));
  %plot(real(xr));
  xr = real(xr)(1:n,:);
  
endfunction