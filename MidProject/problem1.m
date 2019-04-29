%% Project 1
% Jason Kootsher

%% Part 1
dn = 1e6;
u = zeros(3,dn);
g = 1; k = 0;

% Populate signal vectors u
for n = 1:dn
   u(1,n) = 5*g*cos(2*pi*n/13);
   u(2,n) = u(1,n) + 10*g*cos(2*pi*n/30);
   u(3,n) = g*rand(1);
end

% y(n+1) + 1.4y(n) + 0.49y(n-1) = 1.5u(n) + u(n-1)
theta(1,:) = [-1.40 -0.49 1.50 1.00];

% y(n+1) + 1.4y(n) + 0.49y(n-1) = 1.5u(n) + 1.05u(n-1)
theta(2,:) = [-1.40 -0.49 1.50 1.05];

% y(n+1) - 1.4y(n) - 0.49y(n-1) = 1.5u(n) + 1.05u(n-1)
theta(3,:) = [1.40 0.49 1.50 1.05];

% NGA and RLS for signal u(i)
d = size(theta,1)*size(u,1);

for i = 1:d
    if isequal(mod(i,size(u,1)),1)
        k = k+1;
    end
    part1.nga(dn,theta(k,:),u(i-(k-1)*size(u,1),:));
    part1.rls(dn,theta(k,:),u(i-(k-1)*size(u,1),:));
end
evalin('base','clear all');