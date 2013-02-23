function y = myMA(x, N)
% MYMA2 computes two-point averaging filter, ‘‘moving average’’
% Usage: [y] = myMA2(x);

x = x(:);
y = zeros(length(x),1);
x = [zeros(N-1,1); x];

for i=1:length(y)
    for m = 0:N-1
        y(i) = y(i) + x(i+m);
    end
end
y = y/N;
end