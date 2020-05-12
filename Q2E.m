%% q2e Quaternion to Euler
% Ben Carroll - 15.8.2017

%euler = [psi, theta, phi; ....], quat = [q0, q1, q2, q3; ....] 

function euler = q2e(quat) 

%Check for gross error input matrix width
if size(quat,2) ~= 4
    error('Provide a vector of 4 units [q0,q1,q2,q3]')
    return
end

for i = 1:size(quat,1)

%separate Quaternions for row i 
q0 = quat(i,1);
q1 = quat(i,2);
q2 = quat(i,3);
q3 = quat(i,4);

%calculate Euler angles
psi   = atan2d((q2*q3+q0*q1),(q0^2+q3^2-0.5));
theta = atan2d((q0*q2-q1*q3),sqrt((q0^2+q1^2-1/2)^2+(q1*q2+q0*q3)^2));
phi   = atan2d((q1*q2+q0*q3),(q0^2+q1^2-0.5));

%Package row of Euler angles in a matrix
euler(i,:) = deg2rad([psi,theta,phi]);

end

end

