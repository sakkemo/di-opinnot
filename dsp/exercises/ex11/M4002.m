%% M4002.m, IIR filter design

%% Read and listen to the signal
filename = 'avs1.wav';
[x, fT]  = wavread(filename);
t  = [0 : length(x)-1]/fT;   % time axis
%soundsc(x, fT);

%% Draw waveform and spectrogram
figure(1); clf;
plot(t,x);                   
xlabel('time (s)');

figure(2); clf;              
spectrogram(x, 512, 256, 512, fT, 'yaxis');
% specgram(x, 512, fT, 512, 256);           % GNU Octave
colorbar;

%% (i) Determine specifications
% Here are real frequencies (Hz)
fT;                          % sampling frequency of signal & system
fp  = 1800;                  % passband cut-off frequency
fs  = 2000;                  % stopband cut-off frequency
% Now normalize fp-->Wp, fs-->Ws
%
%  |---|--|--------|---------------|
%  0  1.8 2.0     5.5            11.025 kHz
%  0  fp  fs     fT/2             fT  Hz
%  0  Wp  Ws       1               2
%
%  fp/Wp == fT/2 --> Wp = ...
%  fs/Ws == fT/2 --> Ws = ...
Wp  = 2*fp/fT;        % WRITE A CORRECT EQUATION for normalized passband cut-off
Ws  = 2*fs/fT;        % WRITE A CORRECT EQUATION for normalized stopband cut-off
% Ripple values:
Rp  = 2;         % WRITE A CORRECT VALUE for max. ripple in passband
Rs  = 40;        % WRITE A CORRECT VALUE for min. attenuation in stopband
figure(3); clf;
speksitIIR(Wp, Ws, Rp, Rs, '', fT); % draw the specs!
grid on; xlabel('Hz'); ylabel('dB'); title('|H(e^{j \omega})|^2');

%% (ii), (iii) Estimate filter order, help ellipord
[N, Wn] = ellipord(Wp,Ws,Rp,Rs);    % ADD CORRECT VARIABLES

%% (iv) Compute filter coefficients, help ellip
[B, A] = ellip(N,Rp,Rs,Wp);          % ADD CORRECT VARIABLES
max([length(B) length(A)])-1 % order of the filter
figure(4); clf;
zplane(B, A);                % pole-zero plot

%% (v) Check if specifications are fulfilled
[H, w] = freqz(B, A, 512, fT);
magdB  = 20*log10(abs(H)/max(abs(H))); % squared magnitude in dB
figure(3); hold on;          % draw into the same figure No. 1
plot(w, magdB);              % amplitude response in decibels

%% (vi) Use the filter and test it
y  = filter(B, A, x);        % apply X -> H(z) -> Y

%% Analyze the input and output signal
figure(1); hold on;
py = plot(t, y);
set(py, 'Color', [1 0 0], 'LineStyle', '-.', 'LineWidth', 2);
legend({'Original', 'Filtered'});

figure(5), clf;
spectrogram(y, 512, 256, 512, fT, 'yaxis');
% specgram(y, 512, fT, 512, 256);           % GNU Octave
colorbar;

%% Listen to original signal
soundsc(x, fT);              % original signal
%% Listen to filtered signal
soundsc(y, fT);              % filtered signal
%%
tf2latex(B,A)