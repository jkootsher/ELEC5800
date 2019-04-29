function rls(dn,theta,u)
% RLS algorithm
evalin('base','clearvars -except i d k dn theta u');

% Initialize
N = 4; p = eye(N);
y = zeros(1,dn); e = zeros(1,dn);
s = zeros(1,dn); l = zeros(1,dn);

% Theta estimator
x = zeros(N,dn);

for n = 2:dn    
    phi = [y(n);y(n-1);u(n);u(n-1)];
    y(n+1) = theta*phi;
    p = p - (p*(phi*phi')*p)/(1 + phi'*p*phi);
    x(:,n+1) = x(:,n) + p*phi*(y(n+1) - x(:,n)'*phi);
    
    % Error calculation
    e(n+1) = y(n+1) - x(:,n)'*phi;
    s(n+1) = s(n) + e(n+1)^2/n;
    
    % Eigenvalue for p(n)
    try
        warning off;
        pinv = p\eye(N);
        l(n) = min(eig(pinv));
    catch % Singular
        l(n) = 0;
    end
end

% Plots
figure; plot(x'); title("Parameter Estimates");
xlabel("Discrete time n"); ylabel("Estimated value");

figure; plot(e); title("Average Error");
xlabel("Discrete time n"); ylabel("Error");

figure; plot(l); title("Minimum Eigenvalue of P(n)");
xlabel("Discrete time n"); ylabel("Eigenvalue");
end

