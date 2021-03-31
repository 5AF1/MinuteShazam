%%%Load%%%
[x fs] = audioread('underwater2.wav');
media = audioplayer (x,fs);
#play(media);pause(length(x)/fs);

%Constants
p = 50;
n = length(x);
N = 2**ceil(log2(n));
f = -.5:1/(N-1):.5;
n = [0:n-1];
tomono = 1;

%Main function
if tomono == 1
  x = to_mono(x);
end   

[xr,X,Xr] = compression(x,p);

[dx, dfs] = downsample(xr, fs, 100/(100-p));
%save
reduced = audioplayer (dx,dfs);
#play(reduced);pause(length(dx)/dfs);
audiowrite(strcat(num2str(p),'%.wav'),dx,dfs);

%%%plotting%%%
#
subplot(2,2,1);
plot(n,x);
xlabel('Sample Number');ylabel('Amptitude');
subplot(2,2,2);
plot(f,abs(X));
xlabel('Frequency');ylabel('Magnitude');
subplot(2,2,3);
plot(n,xr);
xlabel('Sample Number');ylabel('Amptitude');
subplot(2,2,4);
plot(f,abs(Xr));
xlabel('Frequency');ylabel('Magnitude');
subplot(2,2,3);
pause(15);
plot(1:length(dx),dx);
xlabel('Reduced Sample');ylabel('Amptitude');
#}#
