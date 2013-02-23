%% myMelody.m
%
% Demo, Jukka Parviainen, 20111012
%
%% Nuottien Hertz-m‰‰r‰t (A4 440 Hz), esim.
%  http://www.phy.mtu.edu/~suits/notefreqs.html
%   C4	261.63
%   C#4/Db4	277.18
%   D4	293.66
%   D#4/Eb4	311.13
%   E4	329.63
%   F4	349.23
%   F#4/Gb4	369.99       ...
%   G4	392.00           = 440*2^(-2/12)
%   G#4/Ab4	415.30       = 440*2^(-1/12)
%   A4	440.00           = 440*2^(0)
%   A#4/Bb4	466.16       = 440*2^(1/12)
%   B4	493.88           = 440*2^(2/12)
%   C5	523.25           ...

myNote(261.6, 0.25);
pause(0.06);
myNote(261.6, 0.25);
pause(0.06);
myNote(261.6, 0.25);
pause(0.06);
myNote(329.6, 0.25);
pause(0.06);

myNote(293.7, 0.25);
pause(0.06);
myNote(293.7, 0.25);
pause(0.06);
myNote(293.7, 0.25);
pause(0.06);
myNote(349.2, 0.25);
pause(0.06);

myNote(329.6, 0.25);
pause(0.06);
myNote(329.6, 0.25);
pause(0.06);
myNote(293.7, 0.25);
pause(0.06);
myNote(293.7, 0.25);
pause(0.06);
myNote(261.6, 0.5);
