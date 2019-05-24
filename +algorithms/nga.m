%% Multivariate Consensus
% Algorithm: Normalized Gradient Descent
% Author: Jason Kootsher

%% NGA (function)
function nga(dn,theta,u)
% Clear workspace of extraneous data
evalin('base','clearvars -except i d k dn theta u');

% Initialize constants
% N is the total number of parameters defined in theta
% mu is the rate of descent, also known as the learning rate
% y, e, and s all correspond to signal initializations
N = 4; mu = 1.2;
y = zeros(1,dn); e = zeros(1,dn);
s = zeros(1,dn);

% Theta estimator (parameter estimation)
x = zeros(N,dn);

for n = 2:dn
    phi = [y(n);y(n-1);u(n);u(n-1)]; % phi is the vectorization of signals
    y(n+1) = theta*phi;              % Estimated output signal at time n+1
    
    df = mu*phi/(1+phi'*phi);        % Normalized learning rate
    
    % Estimation of input parameters (theta estimate)
    x(:,n+1) = x(:,n) + df*(y(n+1)-phi'*x(:,n));
    
    % Error calculations
    e(n+1) = y(n+1) - x(:,n)'*phi; % Forward propagation error
    s(n+1) = s(n) + e(n+1)^2/n;    % Backward propagation error
end

% Plots
figure; plot(x'); title("Parameter Estimates");
xlabel("Discrete time n"); ylabel("Estimated value");

figure; plot(e); title("Average Error");
xlabel("Discrete time n"); ylabel("Error");
end

