[x, fT] = wavread('avs1.wav');
soundsc(x, fT);
h = [0.46 -0.67 1.16 -0.67 0.46];
y = conv(h,x);
soundsc(y, fT);


w = 0:pi/256/pi;


xlim([0, fT/2])
spectrogram(x,512,256,512,fT, 'yaxis')
title('original signal')
spectrogram(y,512,256,512,fT, 'yaxis')

x = [1 0 1 1 1 9 8 9 9 9 9 2 1 1 1 0 1] % input sequence: [low high low]
h = [1 -2 1] % impulse response h[n]
y = conv(h, x) % output sequence y = h (*) x
figure(1); clf;
subplot(2,1,1); stem(x);
subplot(2,1,2); stem(y);
figure(2); clf; freqz(h, 1);

%% d
[x,fT] = wavread('kiisseli.wav')
N = 0.5*fT
