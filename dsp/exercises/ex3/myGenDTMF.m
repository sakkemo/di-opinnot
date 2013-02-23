function y = myGenDTMF(seq)
% MYGENDTMF tuottaa lukujonon DTMF-‰‰nt‰, kun annettuna
% merkkijono "seq", joka voi sis‰lt‰‰ numeroita 0,...,9 tai
% tyhj‰n merkin (v‰lilyˆnti). 
%
% Kukin numero tai merkki kest‰‰ 50 ms.
% N‰ytteenottotaajuus on 8000 Hz.
%
% DTMF-signaalit koostuvat kahden sinikomponentin summasta
%   tmp = cos(2*pi*f1*t) + cos(2*pi*f2*t)
% jossa taajuudet f1 = {697, 770, 852, 941} ovat 
% alataajuuksia ja f2 = {1209, 1336, 1477} yl‰taajuudet:
%
%	        1209 Hz 	1336 Hz 	1477 Hz
%   697 Hz 	1 	        2 	        3   	
%   770 Hz 	4 	        5         	6 
%   852 Hz 	7 	        8 	        9
%   941 Hz 	         	0 	        
%
% Lis‰tietoja, esim. 
% http://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling
%
% K‰yttˆ:
%  puhnumero = '050 581 0518'
%  y  = myGenDTMF(puhnumero);
%  soundsc(y, 8000);
%  figure(1); plot(y); xlabel('vektorin indeksinumerot');
%  figure(2); spectrogram(y, 256, 128, 256, 8000, 'yaxis');
%  % Octave: figure(2); specgram(y, 256, 8000, 256, 128);
%

% Teht‰v‰nanto ja pohja myGenDTMF.m.
% T-61.3015, harjoitusteht‰v‰, 13.1.2012 / 2.2.2011
% Jukka Parviainen, jukka.parviainen@aalto.fi

fT  = 8000;              % n‰ytteenottotaajuus
n   = [1 : 0.12*fT];          % aika-akselin indeksiarvot
N   = max(n);                 % 0.12 sekuntia vastaava indeksim‰‰r‰
T   = 0.01*fT;                % 0.01 sekuntia vastaava tyhjyys
y   = zeros(N*length(seq)+T*length(seq),1); % alustetaan jono nollaksi
tmp = zeros(N,1);             % yht‰ ‰‰nt‰ vastaava apuvektori
k   = 1;                      % y-vektorin indeksi 

for i = [1 : length(seq)]
    switch seq(i),
        case '1', 
            fprintf(1,'Numero 1\n');
            % generoi n‰pp‰innumeroa 1 vastaava ‰‰ni kahden sinin summana
            tmp = cos(2*pi*1209/fT*n) + cos(2*pi*697/fT*n);
            % x = A * cos(w*n);
        case '2',
            fprintf(1,'Numero 2\n');
            tmp = cos(2*pi*1336/fT*n) + cos(2*pi*697/fT*n);
        case '3',
            fprintf(1,'Numero 3\n');
            tmp = cos(2*pi*1477/fT*n) + cos(2*pi*697/fT*n);    % loput numerot ja toteutus
        case '4',
            fprintf(1,'Numero 4\n');
            tmp = cos(2*pi*1209/fT*n) + cos(2*pi*770/fT*n);
        case '5',
            fprintf(1,'Numero 5\n');
            tmp = cos(2*pi*1336/fT*n) + cos(2*pi*770/fT*n);
        case '6',
            fprintf(1,'Numero 6\n');
            tmp = cos(2*pi*1447/fT*n) + cos(2*pi*770/fT*n);
        case '7',
            fprintf(1,'Numero 7\n');
            tmp = cos(2*pi*1209/fT*n) + cos(2*pi*852/fT*n);
        case '8',
            fprintf(1,'Numero 8\n');
            tmp = cos(2*pi*1336/fT*n) + cos(2*pi*852/fT*n);
        case '9',
            fprintf(1,'Numero 9\n');
            tmp = cos(2*pi*1477/fT*n) + cos(2*pi*852/fT*n);
        case '0',
            fprintf(1,'Numero 0\n');
            tmp = cos(2*pi*1336/fT*n) + cos(2*pi*941/fT*n);
                  
        case ' ',
            fprintf(1,'Hiljaisuus\n');
            tmp = zeros(N,1);
        otherwise,
            fprintf(1,'Tunnistamaton merkki; ei tehda mitaan\n');
    end;
    % Aseta ‰‰nip‰tk‰ y-vektoriin oikealle kohtaa:
    y(k+T : k+T+N-1) = tmp;
    % Kasvata y-vektorin indeksiarvoa
    k = k + N + T;
end;
        
        
