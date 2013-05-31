%%
rng(123)
N = 100;
T = 1000; q = 2;
% measurement noise:
r = .5;
% Generate the signal and noisy measurements:
s = cumsum([0, normrnd(0, sqrt(q),1,T-1)]);

x = 1:T;
y = s + normrnd(0, sqrt(r), 1, T);
figure(1); plot(x,s, x,y,'.k')

%K = zeros(1, N);
H = 1;
A = 1;

% Measurement noise variance R is the unknown parameter:
R = [0.1, zeros(1, N-1)];
d = 1e-4;
i = 2;
while i < N && (i == 2 || abs(R(i-1)-R(i-2)) > d);
    %% E-step
    % Filtering:
    m = [0 zeros(1, T-1)];
    P = [1, ones(1, T-1)];
    for k = 2:T
        % Prediction:
        m_ = A*m(k-1);
        P_ = A*P(k-1)*A' + q; % = P(k-1) + q
        % Update
        S = H*P_*H' + R(i-1); % = P(k-1) + q + r
        K = P_*H'/S; % = (P(k-q) + q)/(P(k-1) + q + r)
        m(k) = m_ + K*(y(k) -H*m_); % = (1-K)*m + K*y(k)
        P(k) = P_ - K*S*K'; % = P(k-1) + q - K^2*(P(k-1) + q + r)
    end
    %figure(2); plot(x,s, x,m,'-', x,y,'.k')
    
    ms = m;
    Ps = [zeros(1,T-1), P(T)];
    %figure(3); hold off; plot(x,s,x,ms,'-')
    %hold on;
    
    % Smoothing (RTS):
    for k = T-1:-1:1
        m_ = m(k);
        P_ = P(k) + q;
        ms(k) = m(k) + P(k)/P_*(ms(k+1)-m_);
        Ps(k) = P(k) + (P(k)/P_)^2*(Ps(k+1)-P_);
        %plot(x,s,x(k:k+1),ms(k:k+1),'r')
        %hold off; plot(x,s,x,ms)
        %pause(10/N)
    end
    
    % Calculating the matrices needed for Q-distribution
    Sigma = 1/T*sum((Ps + ms.^2));
    B = 1/T*(y*ms');
    D = 1/T*(y*y');
    %% M-step
    R(i) = D - H*B' - B*H' + H*Sigma*H';
    i = i+1;
end