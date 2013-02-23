length = 0.5; %seconds
ft = 16000; % Hz
f = 440; % Hz

n = 0:length*ft;
A = 2;
w = 2*pi*f/ft;

x = A * cos(w*n);
figure(1); clf;
stem(n(1:50),x(1:50));
%axis([-0.5 10.5 -2.2 2.2])

soundsc(x,ft);

%%