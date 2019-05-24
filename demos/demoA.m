%% Multivariate Consensus
% Part II: Directed Graphs & Group Consensus
% Author: Jason Kootsher

%% REFERENCES
% Copy of reference paper included in subdirectory ../docs/references/
% See ../docs/references/ReferenceA.pdf

%% Scenario I: Strong Connectivity & Multi Agent Communication
N = 6; % Number of agents

% Consensus Plot (Hardcoded example)
A(1,:) = [0 0 1 1 0 1];
A(2,:) = [1 0 0 0 0 0];
A(3,:) = [0 1 0 0 0 1];
A(4,:) = [1 1 0 0 1 0];
A(5,:) = [0 1 1 0 0 0];
A(6,:) = [0 0 1 1 0 0];

application.sync(A,N);
evalin('base','clear all'); % Clear the workspace

%% Scenario II: Strong Connectivity & Single Agent Communication
N = 6; % Number of agents

% Consensus Plot (Hardcoded example)
A(1,:) = [0 0 0 0 0 1];
A(2,:) = [0 0 0 0 1 0];
A(3,:) = [0 1 0 0 0 0];
A(4,:) = [1 0 0 0 0 0];
A(5,:) = [0 0 0 1 0 0];
A(6,:) = [0 0 1 0 0 0];

application.sync(A,N);
evalin('base','clear all'); % Clear the workspace