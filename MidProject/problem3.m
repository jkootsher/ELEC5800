%% Project 1
% Jason Kootsher

%% Part 3
N = 6;

% Consensus Plot
A(1,:) = [0 1 1 0 1 0];
A(2,:) = [1 0 0 1 0 1];
A(3,:) = [1 0 0 0 1 1];
A(4,:) = [0 1 1 0 0 1];
A(5,:) = [1 0 1 0 0 1];
A(6,:) = [0 1 0 1 1 0];

% Use to generate A with random binary elements
% A = randi([0 1],N,N);

part3.consensus(A,N);
evalin('base','clear all');

% Dr. Radenkovic,

% If you want to randomly generate A matrices, you can utilize the command
% A=randi([0 1],n,m) where n=m=N. The only caveat will be the need for a 
% 'try/catch' statement if you're analyzing eigenvalues, since a singular 
% matrix will crash Matlab. This setup will work with any of your code 
% where you're examining the connectivity of a graph.

% Hope this helps,
% Jason Kootsher