%% Project 1
% Jason Kootsher

%% Part 2a
N = 6;

% Consensus Plot
A(1,:) = [0 0 1 1 0 1];
A(2,:) = [1 0 0 0 0 0];
A(3,:) = [0 1 0 0 0 1];
A(4,:) = [1 1 0 0 1 0];
A(5,:) = [0 1 1 0 0 0];
A(6,:) = [0 0 1 1 0 0];

part2.consensus(A,N);
evalin('base','clear all');

%% Part 2b
N = 6;

% Consensus Plot
A(1,:) = [0 0 0 0 0 1];
A(2,:) = [0 0 0 0 1 0];
A(3,:) = [0 1 0 0 0 0];
A(4,:) = [1 0 0 0 0 0];
A(5,:) = [0 0 0 1 0 0];
A(6,:) = [0 0 1 0 0 0];

part2.consensus(A,N);
evalin('base','clear all');