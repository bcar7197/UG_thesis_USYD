%% Post_Process_master

clear all,close all, clc

GraphGood
 
index      = 'Runs\';
aero_foils = ['NACA24XX';'NACA44XX';'NACA64XX'];

volume_coeffs = {'_';'_mV_';'_pV_';'_mH_';'_pH_'};

listing    = dir('Runs\');
file_names = extractfield(listing,'name')';

counter = 1;
counter_2 = 1;
alpha_collect = [];
p_collect = [];
q_collect = [];
r_collect = [];
beta_collect = [];
cL_collect    = [];
cD_collect    = [];
cm_collect    = [];
cY_collect    = [];
cn_collect    = [];
cl_collect    = [];


for volume_index = 1:length(volume_coeffs)

for foil_index = 1:size(aero_foils,1)
    
    str = strcat(aero_foils(foil_index,:),volume_coeffs(foil_index),'.csv');
    batch_file_XFLR(counter_2,:) = {str};
    
    for n_index = 0:9
        
        str = strcat(aero_foils(foil_index,:),volume_coeffs(volume_index), num2str(n_index),'.csv');
        
        if ismember(str,file_names) == 1
           
            batch_file(counter,:) = {str};
            counter = counter + 1;
            
        end
        
        
    end
    
    counter_2 = counter_2 + 1;
end

end
    
rho = 1019*1e2/(287.05*(22+273));
       
for index = 1:size(batch_file,1)

file_name = strcat('Runs/',char([batch_file{index}]));

xls_data_original = xlsread(file_name);
xls_data = xls_data_original;

start_frame = 8; %must be at least 8
max_frames  = size(xls_data,1)-start_frame+1;
frame_rate   = 1/(xls_data(9,2)-xls_data(8,2));

aircraft_data

% Re zero frames and time
for i = start_frame:(7+max_frames)
    
    if i == start_frame
        
        xls_data(i,1) = 1; 
        xls_data(i,2) = 0;
       
    else
        
        xls_data(i,1) = xls_data(i-1,1) + 1; 
        xls_data(i,2) = xls_data(i-1,2) + 1/frame_rate;
        
    end
        
end

% Repair data with third order poly fit
third_order_repair

[xls_data] = butterworth_filter_new(xls_data,start_frame);

% time
current_data.t = xls_data(start_frame:(max_frames+7),2);

% rigid body translation 
current_data.rigidbody.translation.x =  xls_data(start_frame:(max_frames+7),7)*1e-3;
current_data.rigidbody.translation.y =  xls_data(start_frame:(max_frames+7),9)*1e-3;
current_data.rigidbody.translation.z =  -xls_data(start_frame:(max_frames+7),8)*1e-3;


% rigid body rotation
current_data.rigidbody.rotation.q0   =  xls_data(start_frame:(max_frames+7),6);
current_data.rigidbody.rotation.q1   =  xls_data(start_frame:(max_frames+7),3);
current_data.rigidbody.rotation.q2   =  xls_data(start_frame:(max_frames+7),5);
current_data.rigidbody.rotation.q3   =  -xls_data(start_frame:(max_frames+7),4);

euler = Q2E([current_data.rigidbody.rotation.q0 current_data.rigidbody.rotation.q1 current_data.rigidbody.rotation.q2 current_data.rigidbody.rotation.q3]);

current_data.rigidbody.rotation.phi   = euler(:,1);
current_data.rigidbody.rotation.theta = euler(:,2);
current_data.rigidbody.rotation.psi   = euler(:,3);

initalise_blanks

% tic
%[F] = Orientate(current_data,file_name);
% toc

%% Rotational Data - Angular Body Velocity

% Numerically Differentiated Euler Rates
% phi dot (radians)- second order accurate scheme ((x+1) - (x-1)) / (2t)
phi_del_m2  = current_data.rigidbody.rotation.phi((1):(end-4));
phi_del_m1  = current_data.rigidbody.rotation.phi((2):(end-3));
phi_del_p1  = current_data.rigidbody.rotation.phi((4):(end-1));
phi_del_p2  = current_data.rigidbody.rotation.phi((5):(end));

time_del_t = current_data.t(2) - current_data.t(1);
current_data.rigidbody.rotation.phidot(3:end-2) = (phi_del_m2 - 8*phi_del_m1 + 8*phi_del_p1 - phi_del_p2)/(12*time_del_t);


% theta dot (radians)- second order accurate scheme ((x+1) - (x-1)) / (2t)
theta_del_m2  = current_data.rigidbody.rotation.theta((1):(end-4));
theta_del_m1  = current_data.rigidbody.rotation.theta((2):(end-3));
theta_del_p1  = current_data.rigidbody.rotation.theta((4):(end-1));
theta_del_p2  = current_data.rigidbody.rotation.theta((5):(end));

current_data.rigidbody.rotation.thetadot(3:end-2) = (theta_del_m2 - 8*theta_del_m1 + 8*theta_del_p1 - theta_del_p2)/(12*time_del_t);

% psi dot (radians)- second order accurate scheme ((x+1) - (x-1)) / (2t)
psi_del_m2  = current_data.rigidbody.rotation.psi((1):(end-4));
psi_del_m1  = current_data.rigidbody.rotation.psi((2):(end-3));
psi_del_p1  = current_data.rigidbody.rotation.psi((4):(end-1));
psi_del_p2  = current_data.rigidbody.rotation.psi((5):(end));

current_data.rigidbody.rotation.psidot(3:end-2) = (psi_del_m2 - 8*psi_del_m1 + 8*psi_del_p1 - psi_del_p2)/(12*time_del_t);

%calculate body rotation rates
for i = 2:(length(current_data.rigidbody.rotation.psidot)-1);
    
    [current_data] = eulerdot2bodyrotrate(current_data,i);
   
end

%% Rotation - Angular Body Acceleration - Alterative Method

% Numerically Differentiated euler rotation accleration
% phi dot (rad/s^2)- second order accurate scheme ((x+1) - 2*x + (x-1)) / (t^2)
phi_del     = current_data.rigidbody.rotation.phi((3):(end-2));

time_del_2 = (current_data.t(2) - current_data.t(1)).^2;

current_data.rigidbody.rotation.phidotdot(3:end-2) = (-1*phi_del_m2+16*phi_del_m1-30*phi_del+16*phi_del_p1-1*phi_del_p2)./(12*time_del_2);

% theta dot (rad/s^2)- second order accurate scheme ((x+1) - 2*x + (x-1)) / (t^2)
theta_del     = current_data.rigidbody.rotation.theta((3):(end-2));

current_data.rigidbody.rotation.thetadotdot(3:end-2) = (-1*theta_del_m2+16*theta_del_m1-30*theta_del+16*theta_del_p1-1*theta_del_p2)./(12*time_del_2);

% theta dot (rad/s^2)- second order accurate scheme ((x+1) - 2*x + (x-1)) / (t^2)
psi_del     = current_data.rigidbody.rotation.psi((3):(end-2));

current_data.rigidbody.rotation.psidotdot(3:end-2) = (-1*psi_del_m2+16*psi_del_m1-30*psi_del+16*psi_del_p1-1*psi_del_p2)./(12*time_del_2);

%calculate body accelerations
for i = 3:(length(current_data.rigidbody.rotation.phidotdot)-2);
    
    [current_data] = eulerdot2bodyrotaccel(current_data,i);
   
end

%% Translational Data

% x dot (radians)- fourth accurate scheme
x_del_m2  = current_data.rigidbody.translation.x((1):(end-4));
x_del_m1  = current_data.rigidbody.translation.x((2):(end-3));
x_del_p1  = current_data.rigidbody.translation.x((4):(end-1));
x_del_p2  = current_data.rigidbody.translation.x((5):(end));

current_data.rigidbody.translation.xdot(3:end-2) = (x_del_m2 - 8*x_del_m1 + 8*x_del_p1 - x_del_p2)/(12*time_del_t);

% y dot (mm/s)- fourth accurate scheme
y_del_m2  = current_data.rigidbody.translation.y((1):(end-4));
y_del_m1  = current_data.rigidbody.translation.y((2):(end-3));
y_del_p1  = current_data.rigidbody.translation.y((4):(end-1));
y_del_p2  = current_data.rigidbody.translation.y((5):(end));

current_data.rigidbody.translation.ydot(3:end-2) = (y_del_m2 - 8*y_del_m1 + 8*y_del_p1 - y_del_p2)/(12*time_del_t);

% z dot (radians)- fourth accurate scheme
z_del_m2  = current_data.rigidbody.translation.z((1):(end-4));
z_del_m1  = current_data.rigidbody.translation.z((2):(end-3));
z_del_p1  = current_data.rigidbody.translation.z((4):(end-1));
z_del_p2  = current_data.rigidbody.translation.z((5):(end));

current_data.rigidbody.translation.zdot(3:end-2) = (z_del_m2 - 8*z_del_m1 + 8*z_del_p1 - z_del_p2)/(12*time_del_t);

%calculate body velocities
for i = 2:(length(current_data.rigidbody.translation.xdot)-1);
    
    [current_data] = eulerdot2bodyvel(current_data,i);
   
end

%calculate total velocity
current_data.rigidbody.translation.V(2:end-1) = (current_data.rigidbody.translation.u(2:end-1).^2 + ...
                                           current_data.rigidbody.translation.v(2:end-1).^2 + ...
                                            current_data.rigidbody.translation.w(2:end-1).^2).^0.5;
                                        
%% Translational - Body Acceleration - Alterative Method

% Numerically Differentiated euler rotation accleration
% x dotdot
x_del     = current_data.rigidbody.translation.x((3):(end-2));

current_data.rigidbody.translation.xdotdot(3:end-2) = (-1*x_del_m2+16*x_del_m1-30*x_del+16*x_del_p1-1*x_del_p2)./(12*time_del_2);

% y dotdot
y_del     = current_data.rigidbody.translation.y((3):(end-2));

current_data.rigidbody.translation.ydotdot(3:end-2) = (-1*y_del_m2+16*y_del_m1-30*y_del+16*y_del_p1-1*y_del_p2)./(12*time_del_2);

% z dotdot
z_del     = current_data.rigidbody.translation.z((3):(end-2));

current_data.rigidbody.translation.zdotdot(3:end-2) = (-1*z_del_m2+16*z_del_m1-30*z_del+16*z_del_p1-1*z_del_p2)./(12*time_del_2);


%calculate body accelerations
for i = 3:(length(current_data.rigidbody.translation.xdotdot)-2);
    
    [current_data] = eulerdot2bodyaccel(current_data,i);
   
end

%% Gravity Data (body axis)

for i = 3:(length(current_data.rigidbody.translation.xdotdot)-2);
    
    [current_data] = gravity_body(current_data,i);
   
end


%% Body Forces (N)

for i = 3:(length(current_data.rigidbody.translation.xdotdot)-2);
    
    [current_data] = body_forces(current_data,i);
   
end

%% Moments (N.m)

for i = 3:(length(current_data.rigidbody.translation.xdotdot)-2);
    
    [current_data] = body_moments(current_data,i);
   
end


%% Aerodynamic Data
% Angle of Attack
current_data.rigidbody.aero.alpha(2:end-1,1) = atan2(current_data.rigidbody.translation.w(2:end-1),current_data.rigidbody.translation.u(2:end-1));
current_data.rigidbody.aero.beta(2:end-1,1)  = atan2(current_data.rigidbody.translation.v(2:end-1),current_data.rigidbody.translation.V(2:end-1));

%% Lift and Drag Forces (in airpath axis)

for i = 3:(length(current_data.rigidbody.translation.xdotdot)-2);
    
    
    [F_aero] = C_z(current_data.rigidbody.aero.beta(i))*C_y(-current_data.rigidbody.aero.alpha(i))*...
            [-current_data.rigidbody.inertial.Fx(i);-current_data.rigidbody.inertial.Fy(i);-current_data.rigidbody.inertial.Fz(i)];
    
     current_data.rigidbody.inertial.L(i,1)    = F_aero(3);
     current_data.rigidbody.inertial.D(i,1)    = F_aero(1);
     current_data.rigidbody.inertial.Y(i,1)    = F_aero(2);   
        
end

%% Lift and Drag Coefficent
current_data.rigidbody.coefficent.cL(3:end-2) = current_data.rigidbody.inertial.L(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S);
current_data.rigidbody.coefficent.cD(3:end-2) = current_data.rigidbody.inertial.D(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S);
current_data.rigidbody.coefficent.cY(3:end-2) = current_data.rigidbody.inertial.Y(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S);

%% Moment Coefficients
current_data.rigidbody.coefficent.cl(3:end-2) = current_data.rigidbody.inertial.Mx(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S*current_data.rigidbody.aircraft.b);
current_data.rigidbody.coefficent.cm(3:end-2) = current_data.rigidbody.inertial.My(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S*current_data.rigidbody.aircraft.c);
current_data.rigidbody.coefficent.cn(3:end-2) = current_data.rigidbody.inertial.Mz(3:end-2)./(0.5*rho*(current_data.rigidbody.translation.V(3:end-2)).^2*current_data.rigidbody.aircraft.S*current_data.rigidbody.aircraft.b);

end

