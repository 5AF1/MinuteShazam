%%%Load%%%
[x fs] = audioread('underwater2.wav');
media = audioplayer (x,fs);
#play(media);pause(length(x)/fs);

%Constants
p = input("Enter compression percentage: ")

n = length(x);
N = 2**ceil(log2(n));
f = -.5:1/(N-1):.5;
n = [0:n-1];

tomono = input("Keep the track stereo50 or mono? (Mono = 1)(Steroe = 0): ")

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
subplot(2,3,1);
plot(n,x);
xlabel('Sample Number');ylabel('Amptitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Time Domain')

subplot(2,3,4);
plot(f,abs(X));
xlabel('Frequency');ylabel('Magnitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Frequency Domain')

subplot(2,3,2);
plot(n,xr);
xlabel('Sample Number');ylabel('Amptitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Compressed Time Domain')

subplot(2,3,5);
plot(f,abs(Xr));
xlabel('Frequency');ylabel('Magnitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Compressed Frequency Domain')

subplot(2,3,3);
plot(1:length(dx),dx);
xlabel('Reduced Sample');ylabel('Amptitude');
set(gca, "linewidth", 2, "fontsize", 18)
title('Down sampled Time Domain')
#}#
