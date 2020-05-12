function [current_data] = eulerdot2bodyaccel(current_data,i)

dcm = C_x(current_data.rigidbody.rotation.phi(i))*...
         C_y(current_data.rigidbody.rotation.theta(i))*...
            C_z(current_data.rigidbody.rotation.psi(i));

body_accel = dcm*[current_data.rigidbody.translation.xdotdot(i);...
                    current_data.rigidbody.translation.ydotdot(i);...
                        current_data.rigidbody.translation.zdotdot(i)];
                                
current_data.rigidbody.translation.udot(i,1) = body_accel(1);
current_data.rigidbody.translation.vdot(i,1) = body_accel(2);
current_data.rigidbody.translation.wdot(i,1) = body_accel(3);

end