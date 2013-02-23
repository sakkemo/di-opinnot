%% DEMO_aani.m
% T-61.2010 Datasta tietoon 
% T-61.3015 Digitaalinen signaalink‰sittely ja suodatus
% Demo ƒ‰ni
%
% Jukka Parviainen, parvi@tkk.fi, 201011110

%% Syntetisoidaan ‰‰ni‰ valmiilla funktiolla mySynthVoice
%
% Katso argumenttien merkitys "help mySynthVoice"
% tai/ja aja alla olevat valmiit esimerkit.
%
% Funktiolla mySynthVoice voi helposti luoda harmonisia
% ‰‰ni‰, joissa signaalin taajuudet ovat jonkun perustaajuuden
% monikertoja.
%
% Mit‰ enemm‰n sinikomponentteja on esityksess‰, sit‰
% "monimutkaisemman" signaalin se pystyy esitt‰m‰‰n.
% Toisin p‰in: jos signaalin spektri koostuu muutamista
% piikeist‰, se koostuu silloin muutamasta sinist‰ ja 
% on yleens‰ "varsin jaksollisen" oloinen. Jaksollisuus
% riippuu ennen kaikkea sinikomponenttien taajuuksien
% monikerroista (harmonisuudesta).

%% Avautuvat ikkunat Fig 101, 102, 103, 104
%
% Ikkuna 101: koko signaalin aaltomuoto.
%   T‰m‰ usein vain "sinist‰", koska n‰ytteit‰ niin paljon.
%   Jos mukana vaimennus, niin t‰m‰ n‰kyy ns. verhok‰yr‰st‰.
%   Voit katsoa signaalin sis‰‰n valitsemalla ikkunan yl‰osasta
%   suurennuslasin, menem‰ll‰ ikkunan valkoiselle osalle,
%   vet‰m‰ll‰ kapea laatikko (pid‰ vasen hiiri pohjassa).
%
% Ikkuna 102: zoomaus ajan suhteen. 
%   T‰st‰ tod.n‰k. n‰kyy jo aaltomuoto.
%  


%% Esimerkki #1: sekunnin pitk‰n 100 Hz:in ‰‰ni
%
%$$x = cos(2*pi*100*t/16000)$$
%
% jossa fT = 16000 Hz on n‰ytteenottotaajuus. Yksi puhdas
% sinisignaali taajuudella f = 100 Hz. Voi olla, ettei kuulu
% huonoista kuulokkeista; nosta t‰llˆin taajuutta.
%
mySynthVoice(100);

%% Esimerkki #2: sekunnin pitk‰n ‰‰ni koostuen nelj‰st‰ sinist‰
%
%$$x = sum_i A_i * cos(2*pi*f_i*t/16000)$$
%
% jossa f_1 = 400 Hz, f_2 = 700 Hz, f_3 = 840 Hz, f_4 = 1020 Hz,
% ja vastaavat voimakkuudet A_i = {1, 1, 1, 0.5}
%
mySynthVoice([400 700 840 1020], [1 1 1 0.5]);

%% Esimerkki #3: sekunnin pitk‰ harmoninen A4-‰‰ni (440 Hz)
%
%$$x = 1*cos(2*pi*440*t/fT + p1) + 0.6*cos(2*pi*880*t/fT + p2) + ...$$
%
% Mukana 440 Hz, 880 Hz, 1320 Hz, 1760 Hz eri vahvuuksilla.
% Pituus oletusarvon 1 sekunti.
mySynthVoice(440*[1 2 3 4], [1 0.6 0.3 0.2], randn(1,4));

%% Esimerkki #4: 2 sekuntia pitk‰ vaimeneva harmoninen A4-‰‰ni (440 Hz)
%
%$$x = 1*cos(2*pi*440*t/fT + p1) + 1*cos(2*pi*1320*t/fT + p2) + ...$$
%
% Mukana 440 Hz, 1320 Hz, 2200 Hz, 3080 Hz samoilla vahvuuksilla
% ja ilman vaihe-eroja.
mySynthVoice(440*[1 3 5 7], ones(1,4), zeros(1,4), 2, 1);

%% Esimerkki #5: kolmisointu C-E-G
%
% Luodaan kolme eri ‰‰nin‰ytett‰ x_i ja summataan ne yhteen.
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

% Painetaan ensin C, sitten E ja lopuksi G pienill‰ viiveill‰
[xC, fT] = mySynthVoice(261.63*[1 3 5 7], [1 0.5 0.4 0.3], ...
    randn(1,4), 2, 1);
xE = mySynthVoice(329.63*[1 3 5 7], [1 0.5 0.4 0.3], ...
    randn(1,4), 1.9, 1);
xG = mySynthVoice(392*[1 3 5 7], [1 0.5 0.4 0.3], ...
    randn(1,4), 1.8, 1);

lenC   = length(xC);
lenE   = length(xE);
lenG   = length(xG);

% Yhdistet‰‰n ykdeksi ‰‰neksi
x  = xC + [zeros(1,lenC-lenE) xE] + [zeros(1,lenC-lenG) xG];

% Kuunnellaan
soundsc(x, fT);

% Piirret‰‰n
t  = [1 : lenC]/fT;
figure(1); clf; plot(t, x);
figure(2); clf; spectrogram(x, 256, 128, 256, fT, 'yaxis');

% Kirjoitetaan ‰‰nitiedostoon
% wavwrite(0.9*x/max(abs(x)), fT, 8, 'sointu_dCEG.wav');

