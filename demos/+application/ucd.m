%% Multivariate Consensus
% Algorithm: Normalized Gradient Descent
% Author: Jason Kootsher

%% REFERENCES
% Copy of reference paper included in subdirectory ../../docs/references/
% See ../../docs/references/ReferenceB.pdf

%% Application III: Self-tuning Consensus on Directed Graphs in the Case of
% Unknown Control Directions (using randomly generated initial conditions)
function ucd(A,N)

% mu is the learning rate
% I is the N dimensional identity matrix
% trials is...well, number of trials
mu = 1;I = eye(N);
trials = 150;

% Initialize vectorizations
u = zeros(N,trials);ub = zeros(N,trials);
x = zeros(N,trials+1);xb = zeros(N,trials);

r = zeros(N,trials);f = zeros(N,trials);
th = zeros(N,trials);phi = zeros(N,trials);

% Populate initial conditions
% Try random ICs between 0 and 1
for i = 1:N
    x(:,1) = 10*rand(N,1);
    x(:,2) = 10*rand(N,1);
    th(:,1)= rand(N,1);
end

z = ones(N,1); % General purpose ones vector
n = (A + I)*z; % Number of agents in A (plus self agent)

b = (-2)*z; % High frequency gain (unknown parameter)
r(:,1) = z; % Normalizing factor

for k = 2:trials
    xb(:,k-1) = (A + I)*x(:,k-1)./n; % Average position of agents
    ub(:,k-1) = (A + I)*u(:,k-1)./n; % Average 'driving force' of agents
    
    phi(:,k) = x(:,k) - xb(:,k-1);   % Position deviation
    r(:,k) = r(:,k-1) + phi(:,k).^2; % Update normalizing factor
    
    % Parameter estimation integrator
    th(:,k) = th(:,k-1) + mu*(phi(:,k).^2)./r(:,k);
    
    f(:,k) = th(:,k) + th(:,k-1); % Recursive normalizing factor (m = 2)
    
    % Normalized gradient expression in terms of control signal
    % Gradient descent is applied here to estimate control directions
    u(:,k) = -sign(b).*f(:,k).*phi(:,k)./r(:,k) + ub(:,k-1);
    
    % Integrate the position using the discovered directional controllers
    x(:,k+1) = x(:,k) + b.*u(:,k);
end

% Plots
figure; plot(th'); title("Estimated Parameters");
xlabel('Discrete time n'); ylabel('Parameter');

figure; plot(x'); title("Agent Positions");
xlabel('Discrete time n'); ylabel('Position');

figure; plot(u'); title("Control Signals");
xlabel('Discrete time n'); ylabel('u(n)');

figure; plot(f'); title("Agent Gains");
xlabel('Discrete time n'); ylabel('Gain');

end

