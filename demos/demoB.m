%% Multivariate Consensus
% Part III: Directed Graphs & Group Consensus
% Author: Jason Kootsher

%% REFERENCES
% Copy of reference paper included in subdirectory ../docs/references/
% See ../docs/references/ReferenceB.pdf

%% Scenario I: Strong Connectivity & Multi Agent Communication
N = 6; % Number of agents

% Consensus Plot (Hardcoded example)
A(1,:) = [0 1 1 0 1 0];
A(2,:) = [1 0 0 1 0 1];
A(3,:) = [1 0 0 0 1 1];
A(4,:) = [0 1 1 0 0 1];
A(5,:) = [1 0 1 0 0 1];
A(6,:) = [0 1 0 1 1 0];

% Use to generate A with random binary elements (uncomment line 17)
% A = randi([0 1],N,N);

application.ucd(A,N);
evalin('base','clear all'); % Clear the workspace