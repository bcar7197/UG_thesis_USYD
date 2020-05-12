current_data.rigidbody.translation.xdot = zeros(length(current_data.rigidbody.translation.x),1);
current_data.rigidbody.translation.ydot = zeros(length(current_data.rigidbody.translation.y),1);
current_data.rigidbody.translation.zdot = zeros(length(current_data.rigidbody.translation.z),1);

current_data.rigidbody.translation.xdotdot = current_data.rigidbody.translation.xdot;
current_data.rigidbody.translation.ydotdot = current_data.rigidbody.translation.ydot;
current_data.rigidbody.translation.zdotdot = current_data.rigidbody.translation.zdot;

current_data.rigidbody.translation.u = zeros(length(current_data.rigidbody.translation.x),1);
current_data.rigidbody.translation.v = zeros(length(current_data.rigidbody.translation.y),1);
current_data.rigidbody.translation.w = zeros(length(current_data.rigidbody.translation.z),1);

current_data.rigidbody.translation.V = zeros(length(current_data.rigidbody.translation.u),1);

current_data.rigidbody.translation.udot = current_data.rigidbody.translation.u;
current_data.rigidbody.translation.vdot = current_data.rigidbody.translation.v;
current_data.rigidbody.translation.wdot = current_data.rigidbody.translation.w;

current_data.rigidbody.rotation.phidot = zeros(length(current_data.rigidbody.rotation.phi),1);
current_data.rigidbody.rotation.thetadot = zeros(length(current_data.rigidbody.rotation.theta),1);
current_data.rigidbody.rotation.psidot = zeros(length(current_data.rigidbody.rotation.psi),1);

current_data.rigidbody.rotation.phidotdot = current_data.rigidbody.rotation.phidot;
current_data.rigidbody.rotation.thetadotdot = current_data.rigidbody.rotation.thetadot;
current_data.rigidbody.rotation.psidotdot = current_data.rigidbody.rotation.psidot;

current_data.rigidbody.rotation.p = current_data.rigidbody.rotation.phidot;
current_data.rigidbody.rotation.q = current_data.rigidbody.rotation.thetadot;
current_data.rigidbody.rotation.r = current_data.rigidbody.rotation.psidot;

current_data.rigidbody.rotation.pdot = current_data.rigidbody.rotation.phidot;
current_data.rigidbody.rotation.qdot = current_data.rigidbody.rotation.thetadot;
current_data.rigidbody.rotation.rdot = current_data.rigidbody.rotation.psidot;

current_data.rigidbody.aero.alpha = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.aero.beta  = zeros(length(current_data.rigidbody.translation.v),1);

current_data.rigidbody.inertial.gx = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.gy = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.gz = zeros(length(current_data.rigidbody.translation.w),1);

current_data.rigidbody.inertial.Fx = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.Fy = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.Fz = zeros(length(current_data.rigidbody.translation.w),1);

current_data.rigidbody.inertial.L = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.D = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.Y = zeros(length(current_data.rigidbody.translation.w),1);

current_data.rigidbody.inertial.Mx = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.My = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.inertial.Mz = zeros(length(current_data.rigidbody.translation.w),1);

current_data.rigidbody.coefficent.cL = zeros(length(current_data.rigidbody.translation.w),1); 
current_data.rigidbody.coefficent.cD = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.coefficent.cY = zeros(length(current_data.rigidbody.translation.w),1);

current_data.rigidbody.coefficent.cl = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.coefficent.cm = zeros(length(current_data.rigidbody.translation.w),1);
current_data.rigidbody.coefficent.cn = zeros(length(current_data.rigidbody.translation.w),1);