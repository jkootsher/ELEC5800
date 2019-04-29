function nga(dn,theta,u)
% NGA (algorithm)
evalin('base','clearvars -except i d k dn theta u');

% Initialize
N = 4; mu = 1.2;
y = zeros(1,dn); e = zeros(1,dn);
s = zeros(1,dn);

% Theta estimator
x = zeros(N,dn);

for n = 2:dn
    phi = [y(n);y(n-1);u(n);u(n-1)];    
    y(n+1) = theta*phi;
    
    df = mu*phi/(1+phi'*phi);
    x(:,n+1) = x(:,n) + df*(y(n+1)-phi'*x(:,n));
    
    % Error calculation
    e(n+1) = y(n+1) - x(:,n)'*phi;
    s(n+1) = s(n) + e(n+1)^2/n;
end

% Plots
figure; plot(x'); title("Parameter Estimates");
xlabel("Discrete time n"); ylabel("Estimated value");

figure; plot(e); title("Average Error");
xlabel("Discrete time n"); ylabel("Error");
end

