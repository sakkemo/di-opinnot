%   Author: Jaakko Riihimäki <jaakko.riihimaki@tkk.fi>
%   Last modified: 2007-10-01 15:10:43 EEST

%
% This is a template file for the exercise 3.11 in the
% course S-114.2601 Introduction to Bayesian Modeling

% Use esim4_6.m with the following changes:

% - Check that the range and spacing of A and B are sensible for the 
%   alternative prior
% - Compute the log-posterior in a grid
% - Scale the log-posterior by subtracting its maximum value before
%   exponentiating (think why this is useful)
% - Exponentiate
% - Normalize the posterior
% - Replace the direct 2D grid sampling with the factored grid sampling
%   described in Gelman et al p. 92
% - In addition to the plots, report p(beta>0|x,y)

