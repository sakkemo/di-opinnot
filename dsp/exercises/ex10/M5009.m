%% Effects of finite wordlength
% Structures of filters: 
%  - Direct form I 
%  - Second order systems (SOS)
%
% Jukka Parviainen, parvi@tkk.fi, 2011 / 7.4.2006

% An error occurs in Line 18 -> help tf2sos

%% Quantization
B = [0.5806   -1.8325    2.6023   -1.8325    0.5806]; 
A = [1.0000   -2.3933    2.5562   -1.4889    0.4302];
%% (a) Original filter with infinite wordlength
figure(1), clf; zplane(B, A)       % pole-zero-plot
figure(2), clf; freqz(B, A)        % amplitude response
figure(3), clf; impz(B, A)         % impulse response
%% (b) Compute coefficients of SOS, "help tf2sos"
[SOS, G] = tf2sos(..);    % convert to second-order-systems values
                          % in Figure
%% (c) Quantize
% Download a2dR.m from course web site
Qbits = 8;               % number of bits, drop this downwards to 1
QBdf  = a2dR(B, Qbits);   % quantize direct form (DF) coefficients
QAdf  = a2dR(A, Qbits);   % -''-
QSOS  = a2dR(SOS, Qbits); % quantize SOS coefficients
QG    = a2dR(G, Qbits);   % -''-
[QBs,QAs] = sos2tf(QSOS,QG);  % back from SOS to direct form
                          % compare QBAdf <-> QBAs with zplane & freqz
% Visualize the results
figure(4); clf; zplane(QBs,QAs); title(['SOS, #bits=' num2str(Qbits)]);
figure(5); clf; zplane(QBdf,QAdf); title(['DF, #bits=' num2str(Qbits)]);
figure(6); clf; freqz(QBs,QAs); title(['SOS, #bits=' num2str(Qbits)]);
figure(7); clf; freqz(QBdf,QAdf); title(['DF, #bits=' num2str(Qbits)]);

