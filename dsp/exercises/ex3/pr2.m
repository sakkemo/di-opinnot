%% M2061.m Analyzing signal kiisseli.wav

%% TASK a --> Read and listen to the signal
[x, fT, nbits] = wavread('kiisseli.wav'); % download the file!
fT % sampling frequency in Hertz
nbits % number of bits for a single value x[i] 2^nbits
M = length(x) % length of x[n]

%% x[n] is nothing but numbers!
x % all samples! % control-c to stop
x(1), x(M) % x[0], x[M-1], first and last value
soundsc(x, fT); % x[n] -> audiocard D/A -> headset

%% Play with numbers I
soundsc(x.*linspace(1,0,M)', fT); % linearly spaced from 1 to 0

%% Play with numbers II
soundsc(x, 0.6*fT);

%% Play with numbers III
soundsc(flipud(x), fT); % ud == up-down

%% Plot the signal waveform in time domain
M = length(x);
t = [ 0 : M-1 ] / fT; % time-axis in sec; if index numbers: t=[1:M];
figure(11); clf; % open/activate Figure No 1, clean it
plot(t, x);
grid on;
xlabel('time (sec)'); title('/kiisseli/');

%% Frequency domain
xF = fft(x); % Discrete Fourier transform of signal x, [0,2pi)
MF = length(xF); % ... should be M == MF in this case
mag = 20*log10(abs(xF)); % in decibels [10*log10(abs(xF).^2)]; if in LINEAR SCALE: mag = abs(xF)
w = fT * [0 : (MF-1)]/MF; % frequency axis in Hertz [0,fT)
figure(12); clf;
plot(w, mag); % DFT-spectrum -- usefulness?!?
grid on;
xlabel('frequency (Hz)'); ylabel('dB'); title('DFT of /kiisseli/');
axis([0 fT/2 min(mag) max(mag)]); % zoom only frequencies from 0 to 0.5 fT

%% Window function 'hamming'
figure(13); clf;
stem(hamming(512));

%% TASK b --> Spectrum for /i/
ind1 = 0.4*fT; % ** FIND a correct INDEX NUMBER for /i/
x_i = x(ind1:ind1+1000); % crop a small part of /i/ from /kiisseli/
figure(14); clf; % ** PLOT signal /i/ in time-domain
plot((ind1:ind1+1000)/fT, x_i)
x_iw = x_i .* hamming(length(x_i));
figure(15); clf; % ** PLOT windowed signal /i/ in time-domain
plot((ind1:ind1+1000)/fT, x_iw)
% ** COMPUTE spectrum for windowed /i/
figure(16); clf; % ** PLOT spectrum of win'ed /i/ in frequency-domain
xF_iw = fft(x_iw);
MF_iw = length(xF_iw);
mag_iw = 20*log10(abs(xF_iw));
w_iw = fT * [0:(MF_iw-1)]/MF_iw;
plot(w_iw, mag_iw)
grid on;
xlabel('frequency (Hz)'); ylabel('dB'); title('DFT of /ii/');
axis([0 fT/2 min(mag_iw) max(mag_iw)]); % zoom only frequencies from 0 to 0.5 fT

%% TASK c --> Time-frequency-domain: short-time Fourier-transform STFT
figure(17); clf;
spectrogram(x, 512, 256, 512, fT, 'yaxis'); % spectrogram
title('Spectrogram of /kiisseli/');
colorbar; % adds a colorbar: color <=> value

%% If you need to print a grayscale document, then change palette
colormap(gray); % probably better if grayscale printing
colormap(bone)
colorbar; % adds a colorbar: gray value <=> value