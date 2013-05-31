%% a)
N = 100; q = 2;
% measurement noise:
r = 5;
% Generate the signal and noisy measurements:
s = cumsum([0, normrnd(0, sqrt(q),1,N-1)]);

x = 1:N;
y = s + normrnd(0, sqrt(r), 1, N);
figure(1); plot(x,s, x,y,'.k')

% Filtering:
m = [0 zeros(1, N-1)];
P = [1, ones(1, N-1)];
%K = zeros(1, N);
H = 1;
A = 1;

for k = 2:N
    % Prediction:
    m_ = A*m(k-1);
    P_ = A*P(k-1)*A' + q; % = P(k-1) + q
    % Update
    S = H*P_*H' + r; % = P(k-1) + q + r
    K = P_*H'/S; % = (P(k-q) + q)/(P(k-1) + q + r)
    m(k) = m_ + K*(y(k) -H*m_); % = (1-K)*m + K*y(k)
    P(k) = P_ - K*S*K'; % = P(k-1) + q - K^2*(P(k-1) + q + r)
end
figure(2); plot(x,s, x,m,'-', x,y,'.k')

ms = m;
Ps = [zeros(1,N-1), P(N)];
figure(3); hold off; plot(x,s,x,ms,'-')
hold on;

% Smoothing:
for k = N-1:-1:1
    m_ = m(k);
    P_ = P(k) + q;
    ms(k) = m(k) + P(k)/P_*(ms(k+1)-m_);
    Ps(k) = P(k) + (P(k)/P_)^2*(Ps(k+1)-P_);
    %plot(x,s,x(k:k+1),ms(k:k+1),'r')
    hold off; plot(x,s,x,ms)
    pause(10/N)
end
MSE1 = sum((m-s).^2)
MSE2 = sum((ms-s).^2)

%% b)
% RTS smoother -- discrete
% Select a finite interval in the state space, say, x  [10,10] and discretize
% it evenly to N subintervals (e.g. N = 1000). Using a suitable numerical
% approximation to the integrals in the Bayesian filtering equations, imple-
% ment a finite grid approximation to the Bayesian filter for the Gaussian
% random walk. Verify that the result is practically the same as of the
% Kalman filter above.

md = m;
Pd = [zeros(1,N-1), P(N)];
n = 1000;
a = min(y)-3;
b = max(y)+3;
t = linspace(a,b,n);
[tx, ty] = meshgrid(linspace(a,b,n));
p_dyn = normpdf(tx, ty, sqrt(q));
p_ = normpdf(t,m(N),P(N));


for k = N-1:-1:1
    p = sum(p_dyn.*repmat(p_',1,n)./repmat(normpdf(t,m(k),sqrt(P(k)+q))',1,n));
    % times the filtering distribution
    p = p.*normpdf(t,m(k),sqrt(P(k)));
    p = p/sum(p);
    p_ = p;
    md(k) = t*p';
    Pd(k) = (t-md(k)).^2*p';
end
figure(4); plot(x,s,x,ms,'-',x,md,'--r')
%% c) 
% Filtering:
m = [0 zeros(1, N-1)];
Pstat = P(N);
%K = zeros(1, N);
H = 1;
A = 1;

for k = 2:N
    % Prediction:
    m_ = A*m(k-1);
    P_ = A*Pstat*A' + q; % = P(k-1) + q
    % Update
    S = H*P_*H' + r; % = P(k-1) + q + r
    K = P_*H'/S; % = (P(k-q) + q)/(P(k-1) + q + r)
    m(k) = m_ + K*(y(k) -H*m_); % = (1-K)*m + K*y(k)
end
mstat = m;

% Smoothing:
for k = N-1:-1:1
    m_ = m(k);
    P_ = Pstat + q;
    mstat(k) = m(k) + Pstat/P_*(mstat(k+1)-m_);
    %plot(x,s,x(k:k+1),ms(k:k+1),'r')
end
figure(5); plot(x,s,x,ms,'-',x,mstat,'--r', 'Linewidth',1)
