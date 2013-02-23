%% DEMO: Signal energy, frames and silence
%
% Consider an audio signal x[n] which is several 
% seconds long. Fourier analysis requires that
% the signal is stationary. Therefore we divide
% the signal into small frames or windows, whose
% length is typically 10 ms .. 100 ms. We assume
% that in that frame the signal is stationary.
%
% Analyzing signal x[n] in small frames/windows
% is a key element in audio/speech signal processing.
%
% In this demo we will compute signal energy
% in small frames or windows. Energy can be 
% used as a feature for analyzing signal.
%
% Energy for L-length signal x:
%
% $E = \sum_{i=0}^{L-1} (x_i)^2$
%
%
% In the end, you can try to remove silent parts of the
% signal in the beginning and end. Do not remove "normal"
% silent parts in the signal (how?).

% T-61.3015 DSP, Jukka Parviainen, 1.3.2011 / 22.3.2010 / 11.3.2008

%% Read audio file
% You can read in any audio file (speech, music, ...)
audiofile = 'M3018.wav';
[x, fT] = wavread(audiofile);
soundsc(x, fT);

%% Stereo -> Mono
% If stereo sound, x is matrix with two columns.
% Now we want to be sure that there's only one column.
if (size(x, 2) == 2)
  x = x(:,1);
  disp('NOTE! Only left channel');
end;

%% Plot the waveform
t  = [0 : length(x)-1]/fT;
figure(1); clf;
plot(t, x);
grid on;
xlabel('time (s)');
title(['Signal x[n] -- ' audiofile]);
xMax = max(x);    % needed for later use

%% Compute energy
% Frame/window length L in samples.
% Energy components are saved in E.
% There is one value for each frame.
L    = 1024;
Lsec = L/fT;
disp(['Window/frame size L = ' num2str(L) ' = ' num2str(Lsec) 's']);
E = zeros(ceil(length(x)/L),1);
ind  = 0;
for k = 1 : L : length(x)-L
  ind = ind+1;
  E(ind) = sum(x(k:k+L-1).^2)/L;
end;

%% Plot energy curve
% We draw the energy curve with red color ([R G B])
% in the same figure with waveform. Therefore
% we first scale energy. 
ScE = xMax*E/max(E); 
figure(1); hold on;
nSE = length(ScE);
p   = plot([Lsec/2 : Lsec : nSE*Lsec], ScE,'o-');
set(p, 'LineWidth', 2, 'Color', [1 0 0]); 
legend({'Signal x[n]','Scaled frame energy'});

%% BREAKPOINT #1
% 
% - How many samples are there in the signal x? 'whos'
% - How many frames are there? 'whos'
% - What can be seen about red curve?
% - How does variable 'ind' correspond to index numbers of the 
%   sequence x[n] with variable 'x'?

