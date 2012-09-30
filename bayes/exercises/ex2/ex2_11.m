%   Author: Jarno Vanhatalo <jarno.vanhatalo@tkk.fi>
%   Last modified: 2007-09-11 15:51:06 EEST

%
% This is a template file for the exercise 2.11 in the 
% course S-114.2601 Introduction to Bayesian Modeling

% ---------
% 2.11 a)
% ---------
% Set the large integer, the grid and the data
m = 1000;                  % Try here different sizes of m. What happens? Why?
theta = 0:(100/m):100;
y = [43 44 45 46.5 47.5]';

% Write below the code for evaluating the posterior 'p_post'. 
% First evaluate the unnormalized posterior and then normalize it
% This takes approximately 5-8 lines of code
likelihood = prod(1./(1+(repmat(y,1,m+1)-repmat(theta,length(y),1)).^2),1);
p_post = likelihood/sum(likelihood);

% Here we plot the normalized posterior and check the normalization 
figure(1)
plot(theta, p_post)
100/m*sum(p_post)   % This line should return 1, if the normalization is correct

% ---------
% 2.11 b)
% ---------
% Form a vector of cumulative density function values (cdf) and draw
% 1000 samples from it. This requires approximately 4-6 lines of code
cdf = cumsum(p_post);
sample = zeros(1000,1);
for i=1:1000
    r=rand(1);
    index = find(cdf>r,1,'first');
    sample(i)=theta(index);
end

% Plot the histogram
figure(2)
hist(sample,20); hold on;
plot(theta, 40*1000*p_post,'r')


% ---------
% 2.11 c)
% ---------
% Use the sampled posterior values for theta (theta_samp) to 
% sample from the posterior predictive distribution of the sixth 
% observation 'y_6'. This requires 1-2 lines of code. 
% See, for example, help trnd.
y6 = trnd(1,1000,1)+sample;
% Plot the histogram of the future observation



% Remember, you can print the plots also as shown in the exercise
% template for 2.9&2.17