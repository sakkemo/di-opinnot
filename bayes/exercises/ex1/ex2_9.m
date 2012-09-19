%   Author: Jarno Vanhatalo <jarno.vanhatalo@tkk.fi>
%   Last modified: 2007-09-11 11:58:58 EEST

%
% This is a template file for the exercise 2.9&2.17 in the 
% course S-114.2601 Introduction to Bayesian Modeling


% This exercise is kind of warming up on plotting probablity 
% densities, using the Matlab and using the latex for documentation.
% Fill in the empty lines below and copy those parts in the document.

% First we begin with the part a) of exercise 2.9.

% Set the mean and standard deviation and compute the 
% parameters of Beta distribution, alfa, beta. Characteristics 
% of the Beta distribution are discussed on pages 576-577, 581-582.  
mu = 0.6;
sigma = 0.3; 
alfa = 
beta = 

% Then create a vector of theta values and evaluate the 
% probability density on those values of theta
theta = 0:0.01:1;
p_prior = betapdf(theta, alfa, beta);

% Plot the answer
figure(1)
plot(theta, p_prior)
title('prior for \theta')
xlabel('\theta')
ylabel('prior probability p(\theta)')

% Now you can save the figure and add it in your report. However, 
% this way the figure will be too large in size and you have to decrease 
% it. If you do this with the latex commands or in the MSword, for example, 
% the font size and the linewidth of the figure will be too small.
%
% If you are using the latex template, you can follow the instructions 
% at the very end of this document to create a figure of right size for 
% the report. This is optinal, but usefull if you want to learn mere about 
% Matlab.
%
% Then the part b) of exercise 2.9

% Evaluate the posterior parameters and fill in the empty lines below
%
% The data
n = 1000;
y = 650;
alfa_post = 
beta_post = 
mean_post =       % the posterior mean
sigma_post =       % the posterior mean

% Plot the answer
p_posterior = betapdf(theta, alfa_post, beta_post);
figure(2)
plot(theta, [p_prior ; p_posterior])
title('prior and posterior for \theta')
xlabel('\theta')
ylabel('prior probability p(\theta)')
legend('prior', 'posterior')

% In order to complete the exercise evaluate and plot the posterior 
% for different priors as told in the instructions

% Part 2.17 of the exercise.

% For part a) see 
help betacdf
% For part b) evaluate the posterior parameters and use betacdf

% ---------------------------------------------------------------------
% Optional lines for printing the figures for latex template:
%
% The figures will be printed  as encapsulated postscript,
% which can then be converted into pdf format. The below lines show the 
% procedure only for the two first figures in 2.9. You can make all the 
% other figures in the same manner

% The prior figure
% First we create a figure object and set some parameters for it.
figure(1)
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',8)
set(gcf,'DefaultTextFontSize',8)
set(gcf,'DefaultLineLineWidth',2)

% here we plot the figure and set the title and axes labels
plot(theta, p_prior)
title('prior for \theta')
xlabel('\theta')
ylabel('prior probability p(\theta)')

% Finally we set the size of the figure and print it as a postscript
set(gcf,'pos',[13.6    10   6  6])   % this line sets the figure in size of 6cm x 6cm
set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',get(gcf,'pos')) % this line sets the borders of the figure in size of 6cm x 6cm
print -depsc2 fig_ex29prior  % this line prints the figure in the current 
                        % Matlab working directory with name fig_ex29.eps


% The posterior figure
figure(2)
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',8)
set(gcf,'DefaultTextFontSize',8)
set(gcf,'DefaultLineLineWidth',2)

plot(theta, [p_prior ; p_posterior])
title('prior and posterior for \theta')
xlabel('\theta')
ylabel('prior probability p(\theta)')
l1 = legend('prior', 'posterior');

set(gcf,'pos',[13.6    10   6  6])       % this line sets the figure in size of 6cm x 6cm
set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',get(gcf,'pos'))       % this line sets the borders of the figure in size of 6cm x 6cm
set(l1,'Position', [0.21 0.75 0.4 0.1])  % this line sets the legend on right position
print -depsc2 fig_ex29posterior          % this line prints the figure

% In order to add the figure in the report copy the fig_ex29.eps in unix 
% directory and run a commands 'epstopdf fig_ex29prior.eps' and 
% 'epstopdf fig_ex29posterior.eps'. Then add the following lines in your
% latex code
% 
%\begin{figure}
%  \begin{center}
%    \subfigure[Add here a subfigure caption]{
%      \label{fig_29prior}
%      \includegraphics[]{fig_ex29prior}
%    }
%    ~
%    \subfigure[Add here a subfigure caption]{
%      \label{fig_29posterior}
%      \includegraphics[]{fig_ex29posterior}
%    }
%    \caption{Add here a caption text}\label{fig_29}
% \end{center}
%\end{figure}
%
% and run 'pdflatex name_of_your_report'
