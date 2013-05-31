%% DEMO: 2D ideal filtering in frequency domain, M4003.m
%
%
% Jukka Parviainen, 18.3.2011

%% Read a picture into Matlab
I  = imread('cameraman.tif');   % type 'uint8' = unsigned integer 8bit
I                               % values of matrix I
NN = size(I);                   % size is (NN(1) rows, NN(2) cols); 
N  = size(I, 1);                % size(N,1) == #rows

%% Show the picture
figure(1); clf; 
imshow(I); 
axis on;
title('Original cameraman.tif');

%% Compute 2D-DFT and plot spectrum
Id = double(I);                 % convert to 'double' type
IF = fft2(Id);                  % 2-D discrete Fourier transform
figure(4); clf; 
imagesc(20*log10(abs(IF)));        % axis 0..2pi, 0..2pi like in Figure (c)
%imagesc(20*log10(abs(fftshift(IF)))); % shifted like in Figure (d)
colormap(gray);                 % grayscale
colorbar
axis equal                      % interval of x and y equal

%% Filter mask of an ideal lowpass filter
wc = 0.05*pi;                    % cut-off frequency wc, 0 < wc < pi
M  = round(wc*N/(2*pi));        % corresponding index, (M/N) == (wc/2pi)
filterMask = zeros(size(I));    % initialize to zeros
filterMask(1:M,          1:M)         = 1;  % left-top corner, 
filterMask(end-M+2:end,  1:M)         = 1;  % left-bottom corner, ...
filterMask(end-M+2:end,  end-M+2:end) = 1; 
filterMask(1:M,          end-M+2:end) = 1; 
filterMask = abs(filterMask-1); % high-pass
figure(5); clf;
mesh(filterMask); colorbar;
mesh(fftshift(filterMask)); colorbar  % shifted like in Figure (d)
%colormap(gray);                % grayscale

%% 2-D ideal filtering
IFfilt = IF .* filterMask;      % ideal filtering in transform domain
figure(6); clf; 
imagesc(20*log10(abs(IFfilt))); 
%imagesc(log10(abs(fftshift(IFfilt)))); % shifted like in Figure (d)
colormap(gray);
colorbar;

%% Inverse 2D-DFT and plot figure
Ifiltered = real(ifft2(IFfilt));  % may contain small complex values
figure(3); clf; 
imshow(Ifiltered, [min(Ifiltered(:)) max(Ifiltered(:))]); 
axis on;
title('Filtered cameraman.tif');

%% Filter mask in spatial xy-domain ("impulse response")
filterMSpatial = real(ifft2(filterMask));
figure(2); clf;
mesh(fftshift(filterMSpatial)); 
%colormap(gray);
%imagesc(log10(abs(fftshift(filterMSpatial))))

