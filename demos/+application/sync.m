%% Multivariate Consensus
% Algorithm: Normalized Gradient Descent
% Author: Jason Kootsher

%% REFERENCES
% Copy of reference paper included in subdirectory ../../docs/references/
% See ../../docs/references/ReferenceA.pdf

%% Application I: Self-tuning Consensus and Synchronization
function sync(A,N)

% mu is the learning rate
% I is the N dimensional identity matrix
% trials is...well, number of trials
mu = 0.4;I = eye(N);
trials = 100;

% Initialize vectorizations
x = zeros(N,trials+1);
v = zeros(N,trials+1);
phi = zeros(N,trials);

vb = zeros(N,trials+1); % Initial average velocity vectorization
th = ones(N,1)*0.7;     % Initial input signal parameter gains

% Initial states
b = [3.8;-1.5;2.3;-0.7;1.5;-3.4]; % Cross signal gains

for i = 1:N
    x(i,1) = .5*(-2)^(i+1); % Initial position for agent i
    v(i,1) = i*(-1)^i;      % Initial velocity for agent i
end

z = ones(N,1); % General purpose ones vector
n = (A + I)*z; % Number of agents per row (including self)

for k = 1:trials
    vb(:,k+1) = (A + I)*v(:,k)./n; % Average velocity of agents

    % State updates
    x(:,k+1) = x(:,k) + v(:,k);                % Velocity integrator
    phi(:,k) = vb(:,k+1) - v(:,k);             % Velocity deviation
    v(:,k+1) = v(:,k) + b.*th(:,k).*phi(:,k);  % Acceleration integrator
    df = sign(b).*phi(:,k)./(z + phi(:,k).^2); % Normalized differential
    
    % Parameter estimation using gradient descent
    th(:,k+1) = th(:,k) - mu*df.*(v(:,k+1) - vb(:,k+1));
end

% Plots
figure; plot(th'); title("Estimated Parameters");
xlabel('Discrete time k'); ylabel('Parameter');

figure; plot(v'); title("Agent Velocity");
xlabel('Discrete time k'); ylabel('Velocity');

figure; plot(x(N-1,:)-x(1,:)); title("Difference Between Final and First Agent Positions");
xlabel('Discrete time k'); ylabel('Position');
end

