function y = myMA2(x)
% MYMA2 computes two-point averaging filter, ‘‘moving average’’
% Usage: [y] = myMA2(x);

y = zeros(length(x),1);
x = [0; x];
for i=1:length(x)-1
    y(i) = 0.5*(x(i+1) + x(i));
end
end