%% Generate data

  % Lock random seed
  randn('state',123);

  % Define parameters
  steps = 100;  % Number of time steps
  q     = 0.01^2; % Process noise spectral density
  r     = 0.02;  % Measurement noise variance

  f=@(x) x - 0.01*sin(x);
  F=@(x) 1 - 0.01*cos(x);
  h=@(x) 0.5*sin(2*x);
  H=@(x) cos(2*x);

  % This is the true initial value
  x0 = 1;

  % Simulate data
  X = zeros(1,steps);  % The true signal
  Y = zeros(1,steps);  % Measurements
  T = 1:steps;         % Time
  X(1) = x0;
  for k=1:steps-1
    Y(k) = h(X(k)) + sqrt(r)*randn;
    X(k+1) = f(X(k)) + sqrt(q)*randn;
  end
  Y(steps) = f(X(steps)) + sqrt(q)*randn;

  % Visualize
  figure; clf;
    plot(T,X(1,:),'--',T,Y,'o');
    legend('True signal','Measurements');
    xlabel('Time step'); title('\bf Simulated data')
    
  % Report and pause
  fprintf('This is the simulated data. Press enter.\n');
  pause;

  
%% EKF

  EST1 = zeros(1,steps);
  P1 = zeros(1, steps);
  EST1(1) = x0
  P1(1) = q;
  for k=2:steps
    m_ = f(EST1(k-1));
    P_ = F(EST1(k-1))^2*P1(k-1)+q;
    % update
    v = Y(k)-h(m_);
    S = H(m_)^2*P_+r;
    K = P_*H(m_)/S;
    EST1(k) = m_+K*v;
    P1(k) = P_-K^2*S;
  end

  % Visualize results
  figure; clf;
  
  % Compute error
  err1 = sqrt(sum((X-EST1).^2,2)/numel(X))
  %err1 = sqrt(sum((X(:)-EST1(:)).^2)/numel(X))
  %err1 = rmse(X,EST1)
  
  % Report and pause
  fprintf('This is the base line estimate. Press enter.\n');
  pause
  
  
%% SLF
  
  Ef=@(m,p)m-0.01*sin(m)*exp(-1*p/2);
  Efdx=@(m,p)p-0.01*cos(m)*p*exp(-p/2);
  Eh=@(m,p)0.5*sin(2*m)*exp(-2*p);
  Ehdx=@(m,p)cos(2*m)*p*exp(-2*p);

  EST2 = zeros(1,steps);
  P2 = zeros(1, steps);
  EST2(1) = x0
  P2(1) = q;

  for k=2:steps
    % prediction
    m_= Ef(EST2(k-1),P2(k-1));
    P_ = Efdx(EST2(k-1),P2(k-1))^2/P2(k-1)+q;
    % update
    v = Y(k)-Eh(m_,P_);
    S = Ehdx(m_,P_)^2/P_+r;
    K = Ehdx(m_,P_)/S;
    EST2(k) = m_+K*v;
    P2(k) = P_-K^2*S;
  end

  err2 = sqrt(sum((X-EST2).^2,2)/numel(X))

  % Visualize results
  figure; clf
  
  plot(1:steps, Y,'.k', 1:steps, X, 1:steps, EST1, 1:steps, EST2, '--')
  legend('Meas.','True','EKF','SLF');
  xlabel('t');
  ylabel('m_k');
%%
% Smoothing:

%% 
% ERTS
mss = zeros(1,steps);
Pss = mss;
m_s = EST1(:,end);
P_s = P1(:,end);
mss(:,end) = m_s;
Pss(:,end) = P_s;


for k=steps-1:-1:1
    m = EST1(k);
    P = P1(k);
    % prediction
    m_ = f(m);
    P_ = F(m)^2*P+q;
    % update
    G = P*F(m)/P_;
    m_s = m + G*(m_s-m_);
    P_s = P + G*(P_s-P_)*G';
    mss(k) = m_s;
    Pss(k) = P_s;
end
R(8) = rmse(s(x),mss);
ms_erts = mss;
plot(1:steps, X, 1:steps, EST1, 1:steps, ms_erts, 'r--')

% SL RTS
mss = zeros(1,steps);
Pss = mss;
m_s = EST2(:,end);
P_s = P2(:,end);
mss(:,end) = m_s;
Pss(:,end) = P_s;
for k=steps-1:-1:1
    m = EST2(k);
    P = P2(k);
    % prediction
    m_= Ef(m,P);
    P_ = Efdx(m,P)^2/P+q;
    % update
    G = Efdx(m,P)/P_;
    m_s = m + G*(m_s-m_);
    P_s = P + G*(P_s-P_)*G';
    mss(k) = m_s;
    Pss(k) = P_s;
end
plot(1:steps, X, 1:steps, EST1, 1:steps, ms_erts, 'r--', 1:steps,mss,'k-.')
