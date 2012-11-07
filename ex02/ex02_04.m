% Use the LMS algorithm to estimate the parameter a of the
% following process:
%   x(n) = a*x(n-1) + noise
% where noise is Gaussian with zero mean and variance s2.

% Copyright (c) 2012 Jaakko Luttinen
% MIT License

% True parameters
a = 0.99;
s2 = 0.02;

N = 6000; % Number of iterations

% Try how the size of the ensemble affects the estimated 
% mean-square error.
M = 1000;

% Allocate memory
w = zeros(N,M); % Estimated parameter
x = zeros(N,M); % Process
e = zeros(N,M); % Errors

% Simulate the process
x0 = randn(1,M); % Initial state
xp = x0;
for n=1:N
  x(n,:) = a.*xp + sqrt(s2)*randn(1,M);
  xp = x(n,:);
end

% Try different values for mu
mu = 0.01; % 0.001, 0.01, 0.1, 1

% Estimate the parameter
xp = x0;
w(1) = 0;
for n=1:(N-1)
  % Input:          x(n-1) (or xp)
  % Output:         w(n)*x(n-1)
  % Desired output: x(n)
  e(n,:) = x(n,:) - w(n,:).*xp;      % Error
  % LMS update parameter estimate
  w(n+1,:) = w(n,:) + mu*e(n,:).*xp; 
  % Or: Normalized LMS update
  %w(n+1,:) = w(n,:) + mu*e(n,:).*xp./(0.1+xp.^2); 
  xp = x(n,:);
end

figure

% Show an example of a process realization
subplot(2,2,1)
plot(x(:,1))
title('Example process')

% Show mean error computed by averaging over the ensemble
subplot(2,2,2)
semilogy(mean(e,2))
title('Mean error')

% Show mean-squared error computed by averaging over the ensemble
subplot(2,2,3)
semilogy(mean(e.^2,2))
title('Mean-square error')

% Show the parameter estimation processes
subplot(2,2,4)
plot(w)
title('Estimated parameter')