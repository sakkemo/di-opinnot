[x, fT] = wavread('knallipiip.wav');
soundsc(x, fT);
figure(18);
spectrogram(x, 512, 256, 512, fT, 'yaxis'); colorbar;
y = zeros(size(x));
for k = (3 : length(x))
y(k) = x(k) - 1.176*x(k-1) + x(k-2);
end;
%%
figure(19);
spectrogram(y, 512, 256, 512, fT, 'yaxis'); colorbar;
% 2.4/8/2