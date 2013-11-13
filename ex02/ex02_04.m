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
e = zeros(N,M); % Errors

switch 1
case 1
  % Simulate the given process
  disp('Use samples from the dynamic process')
  x = zeros(N,M); % Process
  x0 = randn(1,M); % Initial state
  xp = x0;
  for n=1:N
    x(n,:) = a.*xp + sqrt(s2)*randn(1,M);
    xp = x(n,:);
  end
  u = [x0; x(1:(N-1),:)]; % Input
  d = x; % Desired output
case 2
  % Try using independent samples and how it affects
  % the upper bound for the learning parameter. Use
  % the same variance as in equilibrium in the dynamic
  % process.
  disp('Use independent samples')
  u = sqrt(1.005)*randn(N,M); % Input
  d = a*u + sqrt(s2)*randn(N,M); % Desired output
end

% Try different values for the learning parameter mu
mu = 0.1; % 0.001, 0.01, 0.1, 1

% LMS algorithm: Estimate the parameter
w(1) = 0; % Initial parameter value
for n=1:(N-1)
  % Error
  e(n,:) = d(n,:) - w(n,:).*u(n,:);      
  % LMS update parameter estimate
  w(n+1,:) = w(n,:) + mu*e(n,:).*u(n,:); 
  % Or: Normalized LMS update (with regularization 0.1)
  %w(n+1,:) = w(n,:) + mu*e(n,:).*u(n,:)./(0.1+u(n,:).^2); 
end

figure

% Show an example of a process realization
subplot(2,2,1)
plot(d(:,1))
title('Example process')

% Show mean error computed by averaging over the ensemble
subplot(2,2,2)
plot(mean(e,2))
title('Mean error')

% Show mean-squared error computed by averaging over the ensemble
subplot(2,2,3)
semilogy(mean(e.^2,2))
title('Mean-square error')

% Show the parameter estimation processes
subplot(2,2,4)
plot(w)
title('Estimated parameter')
