function fastica()

%
% Generate data
%

% Create sources
N = 1000;
x1 = 1:N;
x2 = sin(linspace(0,10*pi,N));
x3 = randn(1,N);
X = [x1 
     x2 
     x3];

% Mix the sources
M = 3;
W = randn(M,M);
Y = W*X;

% 
% Preprocess the data
%

% Center the data
Y = bsxfun(@minus, Y, mean(Y,2));
% Whiten the data
[V,D] = eig(Y*Y'/N);
Y = V * D^(-0.5) * V' * Y;

%
% Independent component analysis
%

% Non-quadratic non-linearities
f = @(u) log(cosh(u));
g = @(u) tanh(u);
dg = @(u) (1 - tanh(u).^2);

% Run FastICA
D = 3;
W = randn(M, D);
for d = 1:D
  w = W(:,d);
  for n = 1:10
    Z1 = bsxfun(@times, Y, g(w'*Y));
    Z2 = dg(w'*Y);
    w = mean(Z1,2) - mean(Z2,2)*w;
    % Gram-Schmidt decorrelation
    w = w - W(:,1:(d-1))*(W(:,1:(d-1))'*w);
    % Normalization
    w = w / norm(w);
  end
  W(:,d) = w;
  %W = W * (W'*W)^(-0.5);
end

%
% Analysis of the result
%

% Estimate sources by projecting
Xh = W'*Y;

% Plot true sources, observations and estimated sources
figure
for m=1:M
  subplot(M, 3, 3*(m-1)+1);
  plot(X(m,:));
  subplot(M, 3, 3*(m-1)+2);
  plot(Y(m,:));
  subplot(M, 3, 3*(m-1)+3);
  plot(Xh(m,:));
end
  
