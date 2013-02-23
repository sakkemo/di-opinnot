%% M2065 Analysis of MA2 filter

%% Read or create a vector x
[x, fT] = wavread('kiisseli.wav');
n       = [ 1 : length(x) ];
y       = myMA2(x);             % calls function myMA2 with x

%% Signals in time-domain
figure(41); clf;
plot(n, x, 'b', n, y, 'k-.');
xlabel('time indices n');
grid on;
legend({'Original','Filtered'});

%% Filter analysis, see [T4] and/or Matlab #1: H(w) = 2 - exp(-j*w)
w  = [0 : pi/256 : pi];
H  = 0.5 * (1 + exp(-j*w));     % frequency response 
r  = abs(H);                    % amplitude response
figure(42); clf;
plot(w, r);
xlabel('norm. angular frequency \omega'); 
ylabel('|H(e^{j \omega})|');
grid on;

%% Listen to original:
soundsc(x, fT)
%% Listen to filtered:
soundsc(y, fT)
%% Listen to difference:
soundsc(x-y, fT)