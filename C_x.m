function cx = C_x(angle)
% C_x performs a single axis transformaion about the x axis
%
% Usage:
%   cx = C_x(angle)
%
% Inputs:
%   angle : angle to transform (rad)
%
% Output:
%   cx : rotation matrix cx

cx = [ 1 0 0;
       0 cos(angle) sin(angle);
       0 -sin(angle) cos(angle)];
end