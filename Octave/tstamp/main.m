#load package
pkg load signal;

####Load data
[x fs] = audioread('The 8539 Book.wav');
[h fs] = audioread('Si29.wav');

#play
media = audioplayer (x,fs);
%play(media);pause(length(x)/fs);

###Preprocessing
h = flip(h,1);

##Mono convertion
x = to_mono(x);
h = to_mono(h);
##Lowpass filter
fc = 5000; order = 6;
x = lowpass(x,fs,fc,order);
h = lowpass(h,fs,fc,order);
##Down Sample
factor = 4;
dx = downsample(x, factor);
dh = downsample(h, factor);
dfs = fs/factor;
##Zero padding
n = length(dx);
m = length(dh);
dx = pad(dx, m+n-1);
dh = pad(dh, m+n-1);
##Hamming Window
dx = dx .* hamming(length(dx));
dh = dh .* hamming(length(dh));

###FFT
X = fft(dx);
H = fft(dh);

Y = X .* H;

y = real(ifft(Y));
y = y(1:m+n-1,:);

n = length(y);
n = [0:n-1];
plot(n,y);
xlabel('Sample Number');ylabel('Amptitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Corelation')
###
[value, peak] = max(y);

start = (peak-m)/dfs;
st_sec = floor(mod(start,60));
start = floor(start/60);

fin = (peak-1)/dfs;
fi_sec = ceil(mod(fin,60))+1;
fin = floor(fin/60);

ss = strcat("\nStarts at: ",num2str(start),':',num2str(st_sec));
ss = strcat(ss,"\nEnds at: ",num2str(fin),':',num2str(fi_sec))
###