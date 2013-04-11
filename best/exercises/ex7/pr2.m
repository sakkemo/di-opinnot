%% RTS smoother for resonator
%% Generate data

  % Lock random seed
  randn('state',123);

  % Substitute Simo's 'gauss_rnd', where m is the mean and S the covariance
  gauss_rnd = @(m,S) m + chol(S)'*randn(size(m));
  
  % Define parameters
  steps = 100;  % Number of time steps
  w     = 0.5;  % Angular velocity
  q     = 0.01; % Process noise spectral density
  r     = 0.1;  % Measurement noise variance

  % This is the transition matrix
  A = [cos(w)    sin(w)/w; 
       -w*sin(w) cos(w)];

  % This is the process noise covariance
  Q = [0.5*q*(w-cos(w)*sin(w))/w^3 0.5*q*sin(w)^2/w^2;
       0.5*q*sin(w)^2/w^2          0.5*q*(w+cos(w)*sin(w))/w];

  % This is the true initial value
  x0 = [0;0.1]; 

  % Simulate data
  X = zeros(2,steps);  % The true signal
  Y = zeros(1,steps);  % Measurements
  T = 1:steps;         % Time
  x = x0;
  for k=1:steps
    x = gauss_rnd(A*x,Q);
    y = gauss_rnd(x(1),r);
    X(:,k) = x;
    Y(:,k) = y;
  end

  % Visualize
  figure; clf;
    plot(T,X(1,:),'--',T,Y,'o');
    legend('True signal','Measurements');
    xlabel('Time step'); title('\bf Simulated data')
    
  % Report and pause
  fprintf('This is the simulated data. Press enter.\n');
  pause;

  
%% Baseline solution

  % Baseline solution. The estimates
  % of x_k are stored as columns of
  % the matrix EST1.
  
  % Calculate baseline estimate
  m1 = [0;1];  % Initialize first step with a guess
  EST1 = zeros(2,steps);
  for k=1:steps
    m1(2) = Y(k)-m1(1);
    m1(1) = Y(k);
    EST1(:,k) = m1;
  end

  % Visualize results
  figure; clf;
  
  % Plot the signal and its estimate
  subplot(2,1,1);
    plot(T,X(1,:),'--',T,EST1(1,:),'-',T,Y,'o');
    legend('True signal','Estimated signal','Measurements');
    xlabel('Time step'); title('\bf Baseline solution')
  
  % Plot the derivative and its estimate
  subplot(2,1,2);
    plot(T,X(2,:),'--',T,EST1(2,:),'-');
    legend('True derivative','Estimated derivative');
    xlabel('Time step')

  % Compute error
  err1 = sqrt(sum((X-EST1).^2,2)/numel(X))
  %err1 = sqrt(sum((X(:)-EST1(:)).^2)/numel(X))
  %err1 = rmse(X,EST1)
  
  % Report and pause
  fprintf('This is the base line estimate. Press enter.\n');
  pause
  
  
%% Kalman filter
  
  % Kalman filter solution. The estimates
  % of x_k are stored as columns of
  % the matrix EST2.

  m2 = [0;.5];  % Initialize first step
  P2 = eye(2); % Some uncertanty in covariance
  P2s = zeros(2,2,steps);
  EST2 = zeros(2,steps); % Allocate space for results
  H = [1 0];
  Ks = zeros(2,10);

  % Run Kalman filter
  for k=1:steps
    m_km1 = A*m2;
    P_km1 = A*P2*A' + Q;
    % Replace these with the Kalman filter equations
    K = P_km1*H'/(H*P_km1*H'+r);
    v = (Y(k)-H*m_km1);
    S = (P_km1(1,1)+r);
    m2 = m_km1 + K*v;
    P2 = P_km1-K*S*K';
    if k>steps-10
        Ks(:,steps-10+k) = K;
    end

    %warning('You should add the Kalman filtering equations.')
    
    % Store the results
    P2s(:,:,k) = P2;
    EST2(:,k) = m2;
  end

  % Visualize results
  figure; clf
  
  % Plot the signal and its estimate
  subplot(2,1,1);
    plot(T,X(1,:),'--',T,EST2(1,:),'-',T,Y,'o');
    legend('True signal','Estimated signal','Measurements');
    xlabel('Time step'); title('\bf Kalman filter')
  
  % Plot the derivative and its estimate
  subplot(2,1,2);
    plot(T,X(2,:),'--',T,EST2(2,:),'-');
    legend('True derivative','Estimated derivative');
    xlabel('Time step')

  % Compute error
  %err2 = rmse(X,EST2)
  err2 = sqrt(sum((X-EST2).^2,2)/numel(X))

  % Report and pause
  fprintf('This will be the KF estimate. Press enter.\n');
  pause;


%% Stationary Kalman filter solution

  % The estimates of x_k are stored as columns of
  % the matrix EST3.

  m3 = [0;1];  % Initialize first step
  P3 = eye(2); % Some uncertanty in covariance  
  K  = Ks(:,end);  % Store the stationary gain here  
  EST3 = zeros(2,steps); % Allocate space for results

  for k=1:steps
    % Replace these with the stationary Kalman filter equations
    % Replace these with the Kalman filter equations

    m_km1 = A*m3;
    v = (Y(k)-H*m_km1);
    m3 = m_km1 + K*v;

    warning('You should add the Kalman filtering equations.')
    
    % Store the results
    EST3(:,k) = m3;
  end

  % Visualize results
  figure; clf
  
  % Plot the signal and its estimate
  subplot(2,1,1);
    plot(T,X(1,:),'--',T,EST3(1,:),'-',T,Y,'o');
    legend('True signal','Estimated signal','Measurements');
    xlabel('Time step'); ; title('\bf Stationary Kalman filter')
  
  % Plot the derivative and its estimate
  subplot(2,1,2);
    plot(T,X(2,:),'--',T,EST3(2,:),'-');
    legend('True derivative','Estimated derivative');
    xlabel('Time step')
 
  % Compute error
  %err3 = rmse(X,EST3)
  err3 = sqrt(sum((X-EST3).^2,2)/numel(X))

  % Report and pause
  fprintf('This will be the SKF estimate. Press enter.\n');

%% Smoothing

  Ps = P2s; % Kalman filter results 
  ms = EST2; % Kalman filter results
 
  % Plot the signal and its estimate
  subplot(2,1,1);
    plot(T,X(1,:),'--',T,EST2(1,:),'-');
    legend('True signal','Estimated signal');
    xlabel('Time step'); ; title('\bf Kalman filter')
  
  % Plot the derivative and its estimate
  subplot(2,1,2);
    plot(T,X(2,:),'--',T,EST2(2,:),'-');
    legend('True derivative','Estimated derivative');
    xlabel('Time step')
    

    for k=steps-1:-1:1
        m_ = A*EST2(:,k);
        P_ = A*P2s(:,:,k)*A' + Q;
        G = P2s(:,:,k)*A/P_;
        
        ms(:,k) = EST2(:,k) + G*(ms(:,k+1)-m_);
        Ps(:,:,k) = P2s(:,:,k) + G*(Ps(:,:,k+1)-P_)*G';
        
    end
    
    %%
          hold off;
         % Plot the signal and its estimate
         subplot(2,1,1);
         plot(T,X(1,:),'--',T,ms(1,:),'-');
         legend('True signal','Estimated signal');
         xlabel('Time step'); ; title('\bf Kalman filter')
        
        % Plot the derivative and its estimate
        subplot(2,1,2);
        plot(T,X(2,:),'--',T,ms(2,:),'-');
        legend('True derivative','Estimated derivative');
        xlabel('Time step')
        
  