function [current_data] =  body_moments(current_data,i)

ixx = current_data.rigidbody.aircraft.ixx;
iyy = current_data.rigidbody.aircraft.iyy;
izz = current_data.rigidbody.aircraft.izz;
ixz = current_data.rigidbody.aircraft.ixz;

current_data.rigidbody.inertial.Mx(i,1) = ixx*current_data.rigidbody.rotation.pdot(i) - ixz*current_data.rigidbody.rotation.rdot(i)...
                                            -ixz*current_data.rigidbody.rotation.p(i)*current_data.rigidbody.rotation.q(i)...
                                            + (izz-iyy)*current_data.rigidbody.rotation.q(i)*current_data.rigidbody.rotation.r(i);
                                    
current_data.rigidbody.inertial.My(i,1) = iyy*current_data.rigidbody.rotation.qdot(i)...
                                            +(ixx-izz)*current_data.rigidbody.rotation.p(i)*current_data.rigidbody.rotation.r(i)...
                                            +ixz*(current_data.rigidbody.rotation.p(i).^2 - current_data.rigidbody.rotation.r(i).^2);
                                           
                                     
current_data.rigidbody.inertial.Mz(i,1) = -ixz*current_data.rigidbody.rotation.pdot(i) + izz*current_data.rigidbody.rotation.rdot(i)...
                                            +(iyy-izz)*current_data.rigidbody.rotation.p(i)*current_data.rigidbody.rotation.q(i)...
                                            + ixz*current_data.rigidbody.rotation.q(i)*current_data.rigidbody.rotation.r(i);

end