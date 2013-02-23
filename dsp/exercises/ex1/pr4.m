%% Complex-valued function
% Matlab 1 / Problem 4
% Examine function
%
% $$H(\omega) = 1 - 1.176 e^{ -j \omega} + e^{ -j 2 \omega}$$
%
%% (a) Compute values
w = [0 : pi/256 : pi]'; % omega values, now as a column vector
H = 1 - 1.176*exp(-1i*w) + exp(-1i*2*w); % H(omega)
%% (b) Plotting in (x,y)
figure(1); clf; % open/activate Fig. 1, and clear it
x = real(H)% help real
y = imag(H)% help imag
plot(x,y)
xlabel('x'); ylabel('y');
title('H in complex plane');
grid on;
axis equal % useful or not ???
%% (c) Plotting r = |H| as a function of w
figure(2); clf; % open/activate Fig. 2, and clear it
r = abs(H)
plot(w,r)
    %% (d) Plotting theta = <H as a function of w
figure(3); clf; % open/activate Fig. 3, and clear it
theta = angle(H)% angle
plot(w, theta)
%% Show all values at screen
disp([' w x y |H| <H']);
disp([w x y r theta]);