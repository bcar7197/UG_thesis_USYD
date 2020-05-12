function [current_data] = eulerdot2bodyvel(current_data,i)

dcm = C_x(current_data.rigidbody.rotation.phi(i))*...
         C_y(current_data.rigidbody.rotation.theta(i))*...
            C_z(current_data.rigidbody.rotation.psi(i));

body_vel = dcm*[current_data.rigidbody.translation.xdot(i);...
                    current_data.rigidbody.translation.ydot(i);...
                        current_data.rigidbody.translation.zdot(i)];
                                
current_data.rigidbody.translation.u(i,1) = body_vel(1);
current_data.rigidbody.translation.v(i,1) = body_vel(2);
current_data.rigidbody.translation.w(i,1) = body_vel(3);

end