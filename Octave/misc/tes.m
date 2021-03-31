x = [1 2 3 5 4 7 7]
h = [3 5 4]

n = length(x);
m = length(h);

h = flip(h);

y = conv(x,h)

x = [x zeros(1,2**ceil(log2(m+n-1))-n)];
h = [h zeros(1,2**ceil(log2(m+n-1))-m)];

X = fft(x);
H = fft(h);

Y = X .* H;

y2 = ifft(Y)


