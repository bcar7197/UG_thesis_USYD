function cz = C_z(angle)
% C_z performs a single axis transformaion about the z axis
%
% Usage:
%   cz = C_z(angle)
%
% Inputs:
%   angle : angle to transform (rad)
%
% Output:
%   cz : rotation matrix cz

cz = [ cos(angle)  sin(angle) 0;
       -sin(angle) cos(angle) 0;
       0           0          1];
end