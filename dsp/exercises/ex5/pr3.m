x = imread('cameraman.tif');
imagesc(x); colormap('Gray')
h = ones(3)/9;
y = conv2(h,x);
imagesc(y); colormap('Gray')
