function consensus(A,N)
% Self-tuning consensus and synchronization
mu = 0.4;I = eye(N);
trials = 100;

% Initialize
x = zeros(N,trials+1);
v = zeros(N,trials+1);
phi = zeros(N,trials);

vb = zeros(N,trials+1);
th = ones(N,1)*0.7;

% Initial states
b = [3.8;-1.5;2.3;-0.7;1.5;-3.4];

for i = 1:N
    x(i,1) = .5*(-2)^(i+1);
    v(i,1) = i*(-1)^i;
end

% General purpose ones vector
z = ones(N,1);

% Number of ones per row (including self)
n = (A + I)*z;

% Condensing embedded loops by utilizing elementwise operations
for k = 1:trials
    vb(:,k+1) = (A + I)*v(:,k)./n;

    % State updates
    x(:,k+1) = x(:,k) + v(:,k);
    phi(:,k) = vb(:,k+1) - v(:,k);
    v(:,k+1) = v(:,k) + b.*th(:,k).*phi(:,k);
    
    df = sign(b).*phi(:,k)./(z + phi(:,k).^2);
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

