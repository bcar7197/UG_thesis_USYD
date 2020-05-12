function [current_data] = eulerdot2bodyrotaccel(current_data,i)


% Form DCM
body_rates_mat = [1 0 -sin(current_data.rigidbody.rotation.theta(i)); ...
 
                    0 cos(current_data.rigidbody.rotation.phi(i)) sin(current_data.rigidbody.rotation.phi(i))*cos(current_data.rigidbody.rotation.theta(i)); ...
       
                        0 -sin(current_data.rigidbody.rotation.phi(i)) cos(current_data.rigidbody.rotation.phi(i))*cos(current_data.rigidbody.rotation.theta(i))];

% Multiply go eulerdot rates --> body angular accelerations
body_rates = body_rates_mat*[current_data.rigidbody.rotation.phidotdot(i); ...
                                current_data.rigidbody.rotation.thetadotdot(i);...
                                    current_data.rigidbody.rotation.psidotdot(i)];
                                
current_data.rigidbody.rotation.pdot(i,1) = body_rates(1);
current_data.rigidbody.rotation.qdot(i,1) = body_rates(2);
current_data.rigidbody.rotation.rdot(i,1) = body_rates(3);

end