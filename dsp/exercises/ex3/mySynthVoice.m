function [x, fT] = mySynthVoice(f, A, p, lenS, d)
% MYSYNTHVOICE syntetisoi signaalin SUM_i A_i cos(2pi f_i t + p_i),
%  (soittaa sen) ja piirt‰‰ kolme visualisointia: aaltomuodon,
%  spektrin ja spektrogrammin. Sis‰lt‰‰ option signaalin 
%  vaimentamiseen 'fade-out'.
%
% Ohjelma soittaa ‰‰nen vain jos mit‰‰n ulostulomuuttujia (x, fT)
%  ei ole m‰‰ritelty
%
% K‰yttˆ:
%    [x, fT] = mySynthVoice(f, A, p, lensS, d)
% jossa A, p, lensS ja d valinnaisia:
%     f        (1 x n)-vektori sis‰lt‰en sinusoidien taajuusarvot
%     [A]      (1 x n)-vektori sis‰lt‰en sinusoidien vahvistukset,
%                oletusarvona ones(1,n) eli yht‰ vahvat
%     [p]      (1 x n)-vektori sis‰lt‰en sinusoidien vaihe-erot,
%                oletusarvona zeros(1,n) eli ei vaihe-eroja
%     [lenS]   signaalin pituus sekunneissa,
%                oletusarvona 1 sekunti
%     [d]      lis‰vipu: lukuarvo 1: lis‰‰ vaimennuksen 'damp' 
%     [x]      (1 x k) syntetisoidun signaalin arvot, k=lenS*fT
%     [fT]     syntetisoidun signaalin n‰ytteenottotaajuus
%
% Signaalin n‰ytteenottotaajuus on fT = 16000 Hz, joka on kovakoodattu
%  t‰m‰ funktion alkuun (jossa sit‰ voi halutessaan muuttaa).
% Signaalin pituus on lenS = 1 s, joka on kovakoodattu
%  t‰m‰ funktion alkuun (jossa sit‰ voi halutessaan muuttaa).
%
% Nuottien Hertz-m‰‰r‰t (A4 440 Hz), esim.
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
%
% Esimerkki:
%   % Esim #1: sekunnin pitk‰n 100 Hz:in ‰‰ni, kuuntele!
%   mySynthVoice(100);
%
%   % Esim #2: sekunnin pitk‰ harmoninen A4-‰‰ni (440 Hz), kuuntele!
%   mySynthVoice(440*[1 2 3 4], [1 0.6 0.3 0.2], randn(1,4));
%
%   % Esim #3: kolmisointu C-E-G vaimennuksen kera.
%   % HUOM! Ei soita, koska ulosargumentit m‰‰r‰tty:
%   [xC, fT] = mySynthVoice(261.63*[1 2 3 4], [1 0.5 0.4 0.3], ...
%           randn(1,4), 2, 1);
%   xE = mySynthVoice(329.63*[1 2 3 4], [1 0.5 0.4 0.3], ...
%           randn(1,4), 1.9, 1);
%   xG = mySynthVoice(392*[1 2 3 4], [1 0.5 0.4 0.3], ...
%           randn(1,4), 1.8, 1);
%   lenC   = length(xC);
%   lenE   = length(xE);
%   lenG   = length(xG);
%   x  = xC + [zeros(1,lenC-lenE) xE] + [zeros(1,lenC-lenG) xG];
%   soundsc(x, fT);
%   t  = [1 : lenC]/fT;
%   figure(101); clf; plot(t, x);
%   figure(103); clf; spectrogram(x, 256, 128, 256, fT, 'yaxis');
%
% T-61.2010 / Jukka Parviainen, 10.11.2010

%% Alkuarvot ja argumenttien tarkistus

% N‰ytteenottotaajuus. Kuinka monta n‰ytett‰ yhden sekunnin
% aikana soitetaa. Digitaalisesta signaalista voidaan havaita
% taajuuksia fT/2:een asti. Sallitut arvot: 8000 <= fT <= 48000.
fT = 16000;  

% Ikkunoiden numerot
fig1 = 102;
fig2 = 103;
fig3 = 104;
fig4 = 101;

% Zoomauksen plot(t, x) rajat (fig1).
% Arvot: (alku) 0 <= alkuT <= loppuT <= 1 (loppu)
alkuT  = 0.10;
loppuT = 0.15;

% FFT:n pistem‰‰r‰ (fig2)
NFFT   = 1024;

% Spektrogrammin FFT-m‰‰r‰ (fig3)
SFFT   = 512;

% Tarkistetaan argumentit
if (nargin < 1)
    error('Anna ainakin taajuusvektori f. "help mySynthVoice"');
else
    if (prod(size(f)) ~= length(f))
        error('f t‰ytyy olla vektori, ei matriisi. "help mySynthVoice"');
    end;
    if (size(f,1) > 1)
        % pakotetaan vaakavektoriksi
        f = f';         
    end;
    if (any(f >= fT/2))
        % varoitetaan laskostumisesta
        warning('Taajuuksissa f on joitakin yli puolen n‰ytteenottotaajuuden =>');
        warning('Aiheutuu vierastumista (aliasing)');
    end;
end;

if (nargin < 5)
    d = 0;
else
    if (~isa(d, 'double'))
        % Jos annettu merkkijono tms, niin muutetaan luvuksi 0
        warning('Muuttuja d asettu arvoksi 0. "help mySynthVoice"');
        d = 0;
    end;
end;
if (nargin < 4)
    % Pituus sekunneissa. N‰ytteiden m‰‰r‰ on lenS*fT
    lenS = 1;    
end;
if (nargin < 3)
    % Vaihe-erot
    p = zeros(size(f));
else
    if (size(p, 1) > 1)
        % pakotetaan vaakavektoriksi
        p = p';
    end;
    if (length(p) ~= length(f))
        error('Vektorit p ja f tulee olla saman kokoiset. "help mySynthVoice"');
    end;
end;
if (nargin < 2)
    % Amplitudit
    A = ones(size(f));
else
    if (size(A, 1) > 1)
        % pakotetaan vaakavektoriksi
        A = A';
    end;
    if (length(A) ~= length(f))
        error('Vektorit A ja f tulee olla saman kokoiset. "help mySynthVoice"');
    end;
end;

%% Syntetisoidaan perussignaali

lenT = round(lenS * fT);
t    = [1 : lenT]/fT;
pM   = repmat(p', 1, lenT);
x    = A * cos(2*pi*f'*t + pM);

%% Vaimennetaan tarvittaessa

if (d == 1)
    dump = exp(-5*[1:lenT]/lenT);
    x    = x .* dump;
end;

%% Visualisoidaan aaltomuoto

figure(fig1); clf;
alkuI  = round(alkuT * fT);
loppuI = round(loppuT * fT);
%plot(t(alkuI:loppuI), x(alkuI:loppuI));
plot(t, x);
axis([alkuT loppuT min(x) max(x)]);
grid on;
xlabel('aika t (s)');
ylabel('x(t)');
title(['Signaalin aaltomuoto x(t) (pala kohdasta ' num2str(alkuT) ' .. ' num2str(loppuT) ' s)']);

%% Visualisoidaan spektri

figure(fig2); clf;
alkuI  = round(alkuT * fT);
loppuI = round(loppuT * fT);
xF  = fft(x(alkuI:loppuI), NFFT);
mag = 20*log10(abs(xF)/max(abs(xF)));
w   = fT*[0:NFFT-1]/NFFT;
plot(w, mag);
axis([0 fT/2 min(mag) max(mag)]);
grid on;
xlabel('taajuus f (Hz)');
ylabel('dB');
title(['Signaalin spektri (taajuusresoluutio \Delta f = ' num2str(fT/NFFT) ' Hz)']); 

%% Visualisoidaan spektrogrammi

figure(fig3); clf;
spectrogram(x, SFFT, SFFT/2, SFFT, fT, 'yaxis');
xlabel('aika (s)');
ylabel('taajuus (Hz)');
zlabel('voimakkuus (dB)');
title(['Signaalin spektrogrammi (z-akselin v‰ri dB)']);
colorbar;
% colorbar('property','value');


%% Visualisoidaan koko aaltomuoto

figure(fig4); clf;
plot(t, x);
grid on;
xlabel('aika t (s)');
ylabel('x(t)');
title(['Signaalin aaltomuoto x(t)']);

%% Kuunnellaan

if (nargout == 0)
    soundsc(x, fT);
end;
