S = fft(sig2.data);
fT=fs;

figure(1)
plot(linspace(-fT/2, fT/2, length(S)), fftshift(abs(S)))
xlim([-fT/2, fT/2])
xlabel('Frequency [Hz]')
ylabel('Magnitude')
title('Magnitude spectrum')

fc = 11900;
x_demod = sig2.data .* cos(2*pi*fc/fT*[1:length(sig2.data)]');
soundsc(x_demod,fT);

%%
S = fft(sig3.data);
fT=fs;

figure(1)
plot(linspace(-fT/2, fT/2, length(S)), fftshift(abs(S)))
xlim([-fT/2, fT/2])
xlabel('Frequency [Hz]')
ylabel('Magnitude')
title('Magnitude spectrum')

fc = 11900;
x_demod = sig3.data .* cos(2*pi*fc/fT*[1:length(sig3.data)]');
soundsc(x_demod,fT);