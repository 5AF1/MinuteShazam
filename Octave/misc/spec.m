pkg load signal

[x fs] = audioread('pia60.wav');

## test of automatic plot
[S, f, t] = specgram(x);
specgram(x);