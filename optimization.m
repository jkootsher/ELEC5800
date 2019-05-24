%% Multivariate Consensus
% Part I: Optimization Techniques; NGA & RLS
% Author: Jason Kootsher

%% Define constants
dn = 1e6;        % Total samples
u = zeros(3,dn); % Initialize control signals
g = 1; k = 0;   % Gain; Basic counter

%% Populate signal vectors u
for n = 1:dn
   u(1,n) = 5*g*cos(2*pi*n/13);
   u(2,n) = u(1,n) + 10*g*cos(2*pi*n/30);
   u(3,n) = g*rand(1); % Gaussian noise
end

%% Define gain parameters theta (coefficients of difference equations)

% y(n+1) + 1.4y(n) + 0.49y(n-1) = 1.5u(n) + u(n-1)
theta(1,:) = [-1.40 -0.49 1.50 1.00];

% y(n+1) + 1.4y(n) + 0.49y(n-1) = 1.5u(n) + 1.05u(n-1)
theta(2,:) = [-1.40 -0.49 1.50 1.05];

% y(n+1) - 1.4y(n) - 0.49y(n-1) = 1.5u(n) + 1.05u(n-1)
theta(3,:) = [1.40 0.49 1.50 1.05];

%% Use Normalized Gradient (NGA) & Recursive Least Squares (RLS) Algorithms

% Calculate the dimensions of the test set
d = size(theta,1)*size(u,1);

for i = 1:d
    if isequal(mod(i,size(u,1)),1)
        k = k+1; % Keep track of which signals to use
    end
    algorithms.nga(dn,theta(k,:),u(i-(k-1)*size(u,1),:)); % NGA
    algorithms.rls(dn,theta(k,:),u(i-(k-1)*size(u,1),:)); % RLS
end
evalin('base','clear all'); % Clear the workspace