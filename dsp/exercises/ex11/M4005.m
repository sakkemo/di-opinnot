%% M4005.m, FIR filter design

%% Read in demo signal
[x, fT] = wavread('M4005.wav');
% soundsc(x, fT);

figure(1); clf;
spectrogram(x, 512, 256, 512, fT, 'yaxis');
% specgram(x, 512, fT, 512, 256);           % GNU Octave
colorbar;

%% Filter specifications
fT;                             % from the signal!
F   = [     2500 3000   3800 4300        ];  % cut-off frequencies
A   = [  1            0               1  ];  % amplifications
DEV = [ 0.08          0.1           0.08  ];  % deviations
figure(2); clf;
speksitFIR(F, A, DEV, fT);
xlabel('Frequency (Hz)'); ylabel('|H(e^{j \omega})|');
title('FIR bandstop filter');
grid on;

%% Filter order 
[N,Fo,Ao,W] = firpmord(F,A,DEV,fT);

%% Filter coefficients
% Transfer function H(z) = B(z)/A(z)
B   = firpm(N,Fo,Ao,W);
A   = 1;                   % FIR: no feedback <=> A(z) == 1

%% Compute and plot the amplitude response
[H, wF] = freqz(B, A, 512, fT);
figure(2); hold on;
plot(wF, abs(H));
grid on;

%% Plot the phase response
figure(3); clf;
plot(wF, unwrap(angle(H)));
grid on;
%phasez(B, A, 512, fT);
title('Phase response \angle H(e^{j \omega})');

%% Group-delay of the filter
% -(d/dw) <H(e^jw)
figure(4); clf;
grpdelay(B, A, 512, fT);
grid on;
title('Group delay \tau(e^{j \omega})');

%% Pole-zero plot
figure(5); clf;
zplane(B, A)

%% Filter demo signal
y  = filter(B, A, x);

%% Output spectrogram
figure(6); clf;
spectrogram(y, 512, 256, 512, fT, 'yaxis');
% specgram(y, 512, fT, 512, 256);           % GNU Octave
colorbar;

%% Listen to filtered signal
soundsc(y, fT);

%% Magnitude response in decibels
% Compare to IIR specifications given in dB scale.
figure(7); clf;
magdB = 20*log10(abs(H));                 % |H|_max > 1
% magdB = 20*log10(abs(H)/max(abs(H)));   % |H|_max == 1
plot(wF, magdB);
grid on;
xlabel('Frequency (Hz)');
title('Magnitude response in decibels');
ylabel('dB');
