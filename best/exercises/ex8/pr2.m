%%
rng(123)
N = 100;
T = 1000; q = 2;
% measurement noise:
r = 5;
% Generate the signal and noisy measurements:
s = cumsum([0, normrnd(0, sqrt(q),1,T-1)]);

x = 1:T;
y = s + normrnd(0, sqrt(r), 1, T);
figure(1); plot(x,s, x,y,'.k')

%K = zeros(1, N);
H = 1;
A = 1;

% Measurement noise variance R is the unknown parameter:
%R = [1, zeros(1, N-1)];
R = 100;
d = 1e-4;
i = 2;

%%
% Filtering:
m = [0 zeros(1, T-1)];
P = [1, ones(1, T-1)];
for k = 2:T
    % Prediction:
    m_ = A*m(k-1);
    P_ = A*P(k-1)*A' + q; % = P(k-1) + q
    % Update
    S = H*P_*H' + R; % = P(k-1) + q + r
    K = P_*H'/S; % = (P(k-q) + q)/(P(k-1) + q + r)
    m(k) = m_ + K*(y(k) -H*m_); % = (1-K)*m + K*y(k)
    P(k) = P_ - K*S*K'; % = P(k-1) + q - K^2*(P(k-1) + q + r)
    
    % Parameter derivatives
    dS = 1;
    dK = P_*H'/S*dS/S;
    dm = dK*(y(k) -H*m_);
    dP = dK*S*K'-K*dS*K'-K*S*dK;
    
    dEF = 
end
