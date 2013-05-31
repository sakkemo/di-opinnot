[x, fT] = wavread('T-61_3015_knallipiip.wav');
soundsc(x, fT);
printsetup([10 10])
spectrogram(x, 512, 256, 512, fT, 'yaxis'); colorbar;
printfig('png', '121_spektri')
y = zeros(size(x));
for k = (3 : length(x))
y(k) = x(k) - 1.176*x(k-1) + x(k-2);
end;
%%
printsetup([10 10])
spectrogram(y, 512, 256, 512, fT, 'yaxis'); colorbar;
printfig('png', '121_spektri2')