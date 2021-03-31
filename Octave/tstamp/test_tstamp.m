[x fs] = audioread('Si2929.wav');

[h fs] = audioread('Si29.wav');

n = length(x);
m = length(h);

x_mono = zeros(rows(x), 1);
h_mono = zeros(rows(h), 1);

if (columns(x) == 2)
  for i = 1:rows(x),
    x_mono(i,1) = (x(i,1) + x(i,2))/2;
  end;
end;

if (columns(h) == 2)
  for i = 1:rows(h),
    h_mono(i,1) = (h(i,1) + h(i,2))/2;
  end;
end;
disp('Hello_1');

%media = audioplayer (X,fs);
%play(media);pause(length(x)/fs);

n_fft = 2**ceil(log2(n));
X = fft(x_mono, n_fft);

m_fft = 2**ceil(log2(m));
H = fft(h_mono, m_fft);

disp('Hello');
N = length(X)
M = length(H)

MSE = zeros(N-M+1, 1);

disp('Hello_2');

%MSE
for k = 1:N-M+1,
  start_ind_H = 1;
  
  for i = k:k+M-1,
    MSE(k,1) += (real(X(i,1) - H(start_ind_H,1))).^2;
    start_ind_H += 1;
    #disp('Hello_in');
  end;
  
  MSE(k,1) = MSE(k,1)/M;
  disp(k);
end;

##plot(MSE);
