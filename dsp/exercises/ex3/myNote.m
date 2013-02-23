function myNote(taajuus, kesto)
% MYNOTE soittaa signaalin, jonka pituus on 'kesto' sekuntia
%  ja korkeus 'taajuus' Hertziä. Käytetään hyväksi toista
%  funktiota mySynthVoice.m
%
% Käyttö:
%  myNote(taajuus, kesto)
%
% Demo, Jukka Parviainen, 20111012

% Keksi itse harmoniset monikerrat ja niiden suhteelliset
% voimakkuudet:

harmoniset = [1 3 5 7 9 11 13];
voimakkuudet = [0.8 1 0.7 0.3 0.2 0.15 0.3];
%harmoniset = [1 2 3 4 5 6 7];
%voimakkuudet = [0.8 1 0.7 0.3 0.2 0.15 0.3];
harmoniset = [1 2 3 4 5 6 7];
voimakkuudet = [1 0.3 0.2 0.35 0.65 0.81 0.7];

% Vaihesiirto ei vaikuta kovin paljoa ääneen:
vaiheet = randn(size(harmoniset));
%vaiheet = pi/2 * ones(size(harmoniset));

% Tuotetaan lukujono
[x, fT]  = mySynthVoice(taajuus*harmoniset, ...
        voimakkuudet, vaiheet, kesto, 1);
soundsc(x, fT);
