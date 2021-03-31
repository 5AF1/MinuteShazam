pkg load signal;
sp = 4;
################Stereo#####################
[x fs] = audioread('Si29.wav');
################Mono#####################
xm = x(:,1);

if size(x)(2) == 2
  xm = xm + x(:,2);
  xm = xm ./ 2;
end
subplot(sp,1,1);
plot(xm)
#############Lowpass filter########################
fc = 5000; % Cut-off frequency (Hz)
order = 5; % Filter order

[b,a] = butter(order,2*fc/fs);
filtered_data = filter(b,a,xm);

subplot(sp,1,2);
plot(filtered_data);
##############Down Sample#######################
down4 = downsample(filtered_data, 4);
fs4 = fs/4;

subplot(sp,1,3);
plot(down4);
###################Hamming#############################
ham = hamming(length(down4),"symmetric");
hammed = ham .* down4;

subplot(sp,1,4);
plot(hammed);
#######################FFT################################
freq = fft(hammed);
##########################################################
media = audioplayer (x,fs);
play(media);pause(length(x)/fs);
media = audioplayer (xm,fs);
play(media);pause(length(xm)/fs);
media = audioplayer (filtered_data,fs);
play(media);pause(length(filtered_data)/fs);
media = audioplayer (down4,fs4);
play(media);pause(length(down4)/fs4);
media = audioplayer (hammed,fs4);
play(media);pause(length(hammed)/fs4);