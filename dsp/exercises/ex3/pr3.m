N=100;
x=randn(N,1);

ind=1;
for k=1:1:N-10
    E(ind) = sum(abs(x(k:k+10)).^2);
    ind=ind+1;
end

figure
plot(x)
hold on
plot(1:1:N-10, E)