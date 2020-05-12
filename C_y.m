function cy = C_y(angle)
% C_y performs a single axis transformaion about the y axis
%
% Usage:
%   cy = C_y(angle)
%
% Inputs:
%   angle : angle to transform (rad)
%
% Output:
%   cy : rotation matrix cy

cy = [ cos(angle) 0 -sin(angle);
       0          1      0;
       sin(angle) 0 cos(angle)];
end