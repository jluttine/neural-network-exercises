% Use the Least Mean Squares (LMS) algorithm to solve the double-moon
% classification problem.

% Copyright (c) 2012 Jaakko Luttinen
% MIT License

function ex04_03(d, R, w, N)

% Parameters of the double-moon problem
if nargin < 1
  d = -1;  % distance (positive->linear / negative->nonlinear separability)
end
if nargin < 2
  R = 10;  % radius
end
if nargin < 3
  w = 6;   % width
end
if nargin < 4
  N = 1000; % number of data for each moon
end

%
%  Create data distributed uniformly on the moons
%

% Bounds for the radius
min_r = R - w/2;
max_r = R + w/2;
% In order to get the uniform distribution, the distribution for the radius 
% is a bit tricky (weigh the larger radiuses more because of the larger area)
r = sqrt( rand(2*N,1) * (max_r^2-min_r^2) + min_r^2 );
% Angle is uniformly distributed, [0,pi] for the upper moon and [pi,2pi] for
% the lower moon.
theta = rand(2*N,1) * pi;
theta(N+1:2*N) = theta(N+1:2*N) + pi;
% Transform polar coordinates to Euclidean coordinates
y = [r.*cos(theta), r.*sin(theta)];
y1 = y(1:N,:);
y2 = y(N+1:2*N,:);
% Displace the lower moon
y2 = bsxfun(@plus, y2, [R,-d]);

%
% Show the data
%

figure
plot(y1(:,1), y1(:,2), 'rx')
hold on
plot(y2(:,1), y2(:,2), 'go')
set(gca, 'DataAspectRatio', [1,1,1])
title(sprintf('Double-moon problem. r=%g, w=%g, d=%g', R,w,d));
xlabel('x_1')
ylabel('x_2')

%
% Run LMS
%

% Classification labels
d = [1*ones(N,1);
     -1*ones(N,1)];
% Inputs
u = [y1;
     y2];
% Add bias term to inputs
u = [u, ones(2*N,1)];
% Randomize the order of the data
perm = randperm(2*N);
d = d(perm);
u = u(perm,:);
% Run LMS
w = lms_classify(d, u)

%
% Show the results
%

% Draw the decision boundary
xl = xlim(); xlim(xl);
yl = ylim(); ylim(yl);
k = -w(N+1:end,1)./w(N+1:end,2);
b = -w(N+1:end,3)./w(N+1:end,2);
plot([-100;100], ...
     [-100*k'+b'; 100*k'+b'], ...
     'k-');

% Draw w values during the iteration
%figure
%plot(w(:,1), w(:,2), 'k.')

%figure, plot(w(end,:)*[y1,ones(N,1)]');
%figure, plot(w(end,:)*[y2,ones(N,1)]');

function w = lms_classify(d, u)

% Number of data (or iterations) and dimensions
[N,M] = size(u);

% Allocate memory
w = zeros(N,M); % Estimated parameter
e = zeros(N); % Errors

% Try different values for the learning parameter mu
mu0 = 0.01; % 0.001, 0.01, 0.1, 1
tau = 100;

% LMS algorithm: Estimate the parameter
w(1,:) = randn(1,M); % Initial parameter value
for n=1:(N-1)
  % Search-then-converge update scheme
  mu = mu0 / (1+n/tau);
  % Error: Linear fit error from wrong classifications
  dh = w(n,:)*u(n,:)';
  wrong = sign(dh) ~= d(n);
  e(n) = -wrong * dh;
  % Error: Linear fit error from all data
  e(n) = d(n) - w(n,:)*u(n,:)';      
  % LMS update parameter estimate
  w(n+1,:) = w(n,:) + mu*e(n)*u(n,:); 
  % Or: Normalized LMS update (with regularization 0.1)
  %w(n+1,:) = w(n,:) + mu*e(n).*u(n,:) / (0.01+u(n,:)*u(n,:)'); 
  %w(n+1,:) = w(n+1,:) / norm(w(n+1,:));
end

