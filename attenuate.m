%% ATTENUATE
% Calculates and applies directional attenuation
% to the coverage ranges of the given nodes.
%
% Examples:
%
%   Use OPTIM_NODE_CONFIG or STRETCH_CHAINLINK as the entry point.
%
% See also OPTIM_NODE_CONFIG, STRETCH_CHAINLINK, CHAINLINK, NODE_CONFIG_VOL
%
% Copyright 2014 Sidharth Iyer (246964@gmail.com)

%% Function signature
function range = attenuate(N, maxTL, edge)

%% Input
%%
% _N_: Node data for node 1 such that
% _N_(i, :) = [ _Cx_ _Cy_ _Cz_ ]
%%
% _maxTL_: Column vector of maximum acceptable loss in intensity
% between transmission and detection
%%
% _edge_: Euclidean distance between nodes

%% Output
% _range_: Column vector of attenuated ranges in the target directions

  % numPoints = ceil(edge) / 100;   % Space intermediate points ~1m apart
  numPaths = 2;   % 1 for node communication, 2 for echo-based detection
  numPoints = 2;  % Integration granularity
  edgeStep = edge / numPoints;    % Step increment size
  z = linspace(N(1,3), N(2,3), numPoints + 1);  % Intermediate points
  range = zeros(size(maxTL));

  % Start from first node:
  for i = 1 : numPoints + 1
    range(1) = range(1) + edgeStep;     % Increment old range

    % Test new range against given maximum acceptable losses:
    if maxTL(1) < numPaths ...
                  * (20 * log10(range(1)) ...
                     + francois_garrison(25, 35, z(i), 8, 10) * range(1))
      range(1) = range(1) - edgeStep;   % Undo last increment if overshot
      break
    end
  end

  % Start from other node:
  for j = numPoints + 1 : -1 : 1
    % Short circuit if unltimate goal is satisfied
    % Comment out entire conditional block if overlapping is required
    % if j <= numPoints && range(1) + range(2) > edge
    if range(1) + range(2) > edge
      return
    end

    range(2) = range(2) + edgeStep;     % Increment old range

    % Test new range against given maximum acceptable losses:
    if maxTL(2) < numPaths ...
                  * (20 * log10(range(2)) ...
                     + francois_garrison(25, 35, z(i), 8, 10) * range(2))
      range(2) = range(2) - edgeStep;   % Undo last increment if overshot
      break
    end
  end

  %%
  % Return the attenuated ranges for the given sources:

end
