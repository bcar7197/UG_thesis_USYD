function [current_data] =  gravity_body(current_data,i)

dcm = C_x(current_data.rigidbody.rotation.phi(i))*...
         C_y(current_data.rigidbody.rotation.theta(i))*...
            C_z(current_data.rigidbody.rotation.psi(i));
        
G = dcm*[0;0;9.81];

current_data.rigidbody.inertial.gx(i,1) = G(1);
current_data.rigidbody.inertial.gy(i,1) = G(2);
current_data.rigidbody.inertial.gz(i,1) = G(3);

end