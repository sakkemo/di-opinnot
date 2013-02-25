%% Complex-valued function
% Matlab 1 / Problem 4
% Examine function
%
% $$H(\omega) = 1 - 1.176 e^{ -j \omega} + e^{ -j 2 \omega}$$
%
%% (a) Compute values
w = [0 : pi/1024 : pi]'; % omega values, now as a column vector
H = 1 - 1.176*exp(-1i*w) + exp(-1i*2*w); % H(omega)
%% (b) Plotting in (x,y)
figure(1); clf; % open/activate Fig. 1, and clear it
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',8)
set(gcf,'DefaultTextFontSize',8)
set(gcf,'DefaultLineLineWidth',2)
set(gcf,'pos',[-2    10   6  6])   % this line sets the figure in size of 6cm x 6cm
set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',get(gcf,'pos')) % this line sets the borders of the figure in size of 6cm x 6cm
x = real(H);% help real
y = imag(H);% help imag
plot(x,y)
xlabel('x'); ylabel('y');
title('H in complex plane');
grid on;
axis equal % useful or not ???

%% (c) Plotting r = |H| as a function of w
figure('visible','off'); clf; % open/activate Fig. 2, and clear it
r = abs(H);
set(gcf,'DefaultLineLineWidth',1.5)
set(gcf,'DefaultAxesFontSize',8)
set(gcf,'DefaultTextFontSize',8)
set(gcf,'units','centimeters');
set(gcf,'paperunits', get(gcf,'units'))
set(gcf,'PaperSize', [10 10])
set(gcf,'PaperPosition',[0 0 10 10]) % this line sets the borders of the figure in size of 6cm x 6cm
set(gcf,'Position',[0 0   10  10])   % this line sets the figure in size of 6cm x 6cm
plot(w,r, 'col','r')
xlabel('\omega')
ylabel('\mid H(\omega)\mid')
ti = get(gca,'TightInset');
set(gca, 'Position',[ti(1) ti(2) 1-ti(1)-ti(3) 1-ti(2)-ti(4)])






%set(gcf,'PaperPosition', get(gcf,'pos'))
%set(gcf,'PaperPosition',[0 0 10+ti(1)+ti(3) 10+ti(2)+ti(4)]) % this line sets the borders of the figure in size of 6cm x 6cm


print -dpdf -r300 121_amplitudivaste  % this line prints the figure in the current 

    %% (d) Plotting theta = <H as a function of w
figure(3); clf; % open/activate Fig. 3, and clear it
theta = angle(H)% angle
plot(w, theta)
%% Show all values at screen
disp([' w x y |H| <H']);
disp([w x y r theta]);