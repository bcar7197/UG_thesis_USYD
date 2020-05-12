function [current_data] = eulerdot2bodyrotrate(current_data,i)


% Form DCM
body_rates_mat = [1 0 -sin(current_data.rigidbody.rotation.theta(i)); ...
 
                    0 cos(current_data.rigidbody.rotation.phi(i)) sin(current_data.rigidbody.rotation.phi(i))*cos(current_data.rigidbody.rotation.theta(i)); ...
       
                        0 -sin(current_data.rigidbody.rotation.phi(i)) cos(current_data.rigidbody.rotation.phi(i))*cos(current_data.rigidbody.rotation.theta(i))];

% Multiply go euler rates --> body rates
body_rates = body_rates_mat*[current_data.rigidbody.rotation.phidot(i); ...
                                current_data.rigidbody.rotation.thetadot(i);...
                                    current_data.rigidbody.rotation.psidot(i)];
                                
current_data.rigidbody.rotation.p(i,1) = body_rates(1);
current_data.rigidbody.rotation.q(i,1) = body_rates(2);
current_data.rigidbody.rotation.r(i,1) = body_rates(3);

end