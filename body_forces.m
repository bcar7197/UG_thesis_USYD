function [current_data] =  body_forces(current_data,i)

current_data.rigidbody.inertial.Fx(i,1) = current_data.rigidbody.aircraft.m*(current_data.rigidbody.translation.udot(i) -...
                                                current_data.rigidbody.rotation.r(i)*current_data.rigidbody.translation.v(i) + ...
                                                current_data.rigidbody.rotation.q(i)*current_data.rigidbody.translation.w(i)) - ...
                                                current_data.rigidbody.aircraft.m*current_data.rigidbody.inertial.gx(i);
                                    
current_data.rigidbody.inertial.Fy(i,1) = current_data.rigidbody.aircraft.m*(current_data.rigidbody.translation.vdot(i) +...
                                                current_data.rigidbody.rotation.r(i)*current_data.rigidbody.translation.u(i) - ...
                                                current_data.rigidbody.rotation.p(i)*current_data.rigidbody.translation.w(i)) - ...
                                                current_data.rigidbody.aircraft.m*current_data.rigidbody.inertial.gy(i);
                                     
current_data.rigidbody.inertial.Fz(i,1) = current_data.rigidbody.aircraft.m*(current_data.rigidbody.translation.wdot(i) -...
                                                current_data.rigidbody.rotation.q(i)*current_data.rigidbody.translation.u(i) + ...
                                                current_data.rigidbody.rotation.p(i)*current_data.rigidbody.translation.v(i)) - ...
                                                current_data.rigidbody.aircraft.m*current_data.rigidbody.inertial.gz(i);

end