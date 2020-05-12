% Prelim Code for thesis

% Develop a function to import .CSV file and deliver X,Y,Z
% positions of the three aircraft nodes & two datum
% [X1 Y1 Z1 X2 Y2 Z2 X3 Y3 Z3 X4 Y4 Z4 X5 Y5 Z5; ... ; ...]

%Obtain Euler angles relative to some datum in the room
% [phi_1 theta_1 psi_1; phi_2 theta_2 psi_2 ; ...]

% Obtain x,y,z velocities using central difference scheme
% x_dot = (x_3 - 2*x_2 - x_1) / del_t^2
% y_dot = (y_3 - 2*y_2 - y_1) / del_t^2
% z_dot = (z_3 - 2*z_2 - z_1) / del_t^2
% @ time marker 2, using central (CoG) aircraft marker

% Obtain body angle velocities [u v w] using coordinate transform
% Obtain body angle accelerations [u_dot v_dot w_dot] using
% central differences

% Obtain aeroangles (alpha, beta) and velocity using trig / pythag

% Obtain gravity vector [Gx,Gy,Gz]
% gravity = C_z(euler(3))*C_y(euler(2))*C_x(euler(1))*[0;0;FlightData.Inertial.g];

% Obtain first derivative euler rates with central difference scheme
% tranform to [p q r] using a rotation matrix

% Obtain second derivative body angle rotations [p_dot, q_dot, r_dot]
% (somehow?) 

%Solve equations of motion [Fax, Fay, Faz, Max, May, Maz] using F = Ma-Mg

% N = -Fz, A = -Fx, S = -Sy ... L = Ncos(alpha) - Asin(alpha) D =
% Nsin(alpha) + Acos(alpha)

% Find time history aerodynamic Derivatives [Cl CD CY & CL CM CN]

%Need to consider higher order effects. Cdo = -K*cl^2 + Cd, Consider a
%parabolic fit, other stability deriviatives can be found through curve
%fitting, Clo, Clq, Clad, Cmo, Cmq, Cyb, Cybd, Cyp, Cyr, Cnb, Cnr. Cnp,
%CLb, Clp, Clr
% Static Margin? 

%Consider simulating in a non linear environment