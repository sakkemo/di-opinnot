[x, fT] = wavread('helsinkiin_2178');
soundsc(x, fT);
N=1024;
V=256;

m = 1; % column index for images iF and iC

for k = (1 : (N-V) : length(x)-N)
tmp = x(k : k+N-1);
xF = fft(tmp);
xC = ifft(log(xF));
iF(:,m) = abs(xF(1:N/2));
iC(:,m) = real(xC(1:N/2)); % real part of first half of xC components
m = m+1;
end
printsetup();
imagesc(iF);
colormap(gray);
colorbar
printfig('png', '122_spektri')

printsetup();
imagesc(iC);
colormap(gray);
colorbar
printfig('png', '122_cepstri')
