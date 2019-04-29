function consensus(A,N)
% Self-tuning consensus on directed graphs in the case of
% unknown control directions (using randomly generated ICs)
mu = 1;I = eye(N);
trials = 150;

% Initialize
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

% General purpose ones vector
z = ones(N,1);

% More ICs
b = (-2)*z;
r(:,1) = z;

% Number of ones in A (plus self agent)
n = (A + I)*z;

% Condensing embedded loops by utilizing elementwise operations
for k = 2:trials
    xb(:,k-1) = (A + I)*x(:,k-1)./n;
    ub(:,k-1) = (A + I)*u(:,k-1)./n;
    
    phi(:,k) = x(:,k) - xb(:,k-1);
    r(:,k) = r(:,k-1) + phi(:,k).^2;
    
    th(:,k) = th(:,k-1) + mu*(phi(:,k).^2)./r(:,k);
    f(:,k) = th(:,k) + th(:,k-1);
    
    u(:,k) = -sign(b).*f(:,k).*phi(:,k)./r(:,k) + ub(:,k-1);
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

