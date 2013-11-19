%% Importing images
orig = double(imread('T-61_5100_city_orig_2.png'))/255;
lines = double(imread('T-61_5100_city_lines.png'))/255;

subplot(1,2,1)
imshow(orig)
title('Original image')
subplot(1,2,2)
imshow(lines)
title('Image with an interference pattern')


%% MSEs
mse_orig = meansqr(orig-lines)

%% Finding optimal values for the spatial model
% delta1 = phase at beginning
% delta2 = phase at end
% A = amplitude of sine
% A2 = background level
delta=0; delta2=0; A=1; A2=1;
for i=1:10
    delta = linspace(0, 10, 100);
    errors = [];
    for i=1:length(delta)
        errors = [errors meansqr(orig-(lines - ...
        repmat(A2 + A*sin(linspace(0+delta(i), 15*2*pi+delta2, 450))', 1,310)))];
    end
    plot(delta, errors)
    drawnow()
    [val, id] = min(errors);
    delta = delta(id);
    
    
    delta2 = linspace(0, 7, 100);
    errors = [];
    for i=1:length(delta2)
        errors = [errors meansqr(orig-(lines - ...
        repmat(A2 + A*sin(linspace(0+delta, 15*2*pi+delta2(i), 450))', 1,310)))];
    end
    % plot(delta2, errors)
    [val, id] = min(errors);
    delta2 = delta2(id);
    
    A = linspace(0,1, 100);
    errors = [];
    for i=1:length(A)
        errors = [errors meansqr(orig-(lines - ...
        repmat(A2 + A(i)*sin(linspace(0+delta, 15*2*pi+delta2, 450))', 1,310)))];
    end
    % plot(A, errors)
    [val, id] = min(errors);
    A= A(id);
    
    A2 = linspace(-1,1,100);
    errors = [];
    for i=1:length(A2)
        errors = [errors meansqr(orig-(lines - ...
        repmat(A2(i) + A*sin(linspace(0+delta, 15*2*pi+delta2, 450))', 1,310)))];
    end
    % plot(A2, errors)
    [val, id] = min(errors);
    A2= A2(id);
end
%%
imwrite(lines- repmat(A2 + A*sin(linspace(0+delta, 15*2*pi+delta2, 450))',...
    1,310), 'spatial_filtered.png', 'png')
imwrite(orig-(lines - ...
    repmat(A2 + A*sin(linspace(0+delta, 15*2*pi+delta2, 450))', 1,310)),...
    'spatial_diff.png', 'png')

mse_spatial = meansqr(orig-(lines - ...
    repmat(A2 + A*sin(linspace(0+delta, 15*2*pi+delta2, 450))', 1,310)))


%% Frequency domain filtering

cf=fftshift(fft2(lines));
fl = log(1+abs(cf));
fm = max(fl(:));
imwrite(im2uint8(fl/fm), 'fft.png', 'png')

% cf(:,156)=0;
cf(242,156)=0;
cf(210,156)=0;

fl = log(1+abs(cf));
fm = max(fl(:));
imwrite(im2uint8(fl/fm), 'fft_removed.png', 'png')

cfi = ifft2(cf);
fa=abs(cfi);
fm=max(fa(:));
filtered = fa/fm;
mse_fft = meansqr(orig-filtered)
imwrite(filtered, 'fft_filtered.png', 'png')
imwrite(orig-filtered, 'fft_diff.png', 'png')

