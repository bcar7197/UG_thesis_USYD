function [F] = Orientate(current_data,file_name)

GraphGood
counter = 0;

% %determine frame rate reduction
% n = round(length(current_data.t)/5000,0);

xArrowLength = 1000*1e-3;
yArrowLength = xArrowLength;
zArrowLength = xArrowLength;

for i = [1:50:length(current_data.t)]

h = figure(1);
%set(h,'visible','off')

hold on
grid on 
grid minor

screensize = get(0,'Screensize'); 
set(h,'Position',[0 0 screensize(3) screensize(4)])
set(gca,'fontsize',12)

view([-70 15]);

set(gca,'ZDir','Reverse')
set(gca,'YDir','Reverse')

%plot origin
%x axis
quiver3(0,0,0,500*1e-3,0,0,...
    'MaxHeadSize',1,...
    'linewidth',3,...
    'color',myred)
%y axis
quiver3(0,0,0,0,500*1e-3,0,...
    'MaxHeadSize',1,...
    'linewidth',3,...
    'color',mygreen)
%z axis
quiver3(0,0,0,0,0,500*1e-3,...
    'MaxHeadSize',1,...
    'linewidth',3,...
    'color',myblue)

DCM = C_z(-current_data.rigidbody.rotation.psi(i))*C_y(-current_data.rigidbody.rotation.theta(i))*C_x(-current_data.rigidbody.rotation.phi(i));

xVectorEarth = DCM*[xArrowLength;0;0];
yVectorEarth = DCM*[0;yArrowLength;0];
zVectorEarth = DCM*[0;0;zArrowLength];

% xVectorEarth = angle2dcm(current_data.rigidbody.rotation.psi(i),current_data.rigidbody.rotation.theta(i),current_data.rigidbody.rotation.phi(i))*[xArrowLength;0;0];
% yVectorEarth = angle2dcm(current_data.rigidbody.rotation.psi(i),current_data.rigidbody.rotation.theta(i),current_data.rigidbody.rotation.phi(i))*[0;yArrowLength;0];
% zVectorEarth = angle2dcm(current_data.rigidbody.rotation.psi(i),current_data.rigidbody.rotation.theta(i),current_data.rigidbody.rotation.phi(i))*[0;0;zArrowLength];

 plot3(current_data.rigidbody.translation.x,current_data.rigidbody.translation.y,current_data.rigidbody.translation.z,'color','k','linestyle','--')

%Aircraft x axis
quiver3(current_data.rigidbody.translation.x(i),current_data.rigidbody.translation.y(i),current_data.rigidbody.translation.z(i),xVectorEarth(1),xVectorEarth(2),xVectorEarth(3),...
    'MaxHeadSize',1,...
    'linewidth',3,...
    'color',myred)
%Aircraft y axis
quiver3(current_data.rigidbody.translation.x(i),current_data.rigidbody.translation.y(i),current_data.rigidbody.translation.z(i),yVectorEarth(1),yVectorEarth(2),yVectorEarth(3),...
    'MaxHeadSize',yArrowLength,...
    'linewidth',3,...
    'color',myblue)
%Aircraft z axis
quiver3(current_data.rigidbody.translation.x(i),current_data.rigidbody.translation.y(i),current_data.rigidbody.translation.z(i),zVectorEarth(1),zVectorEarth(2),zVectorEarth(3),...
    'MaxHeadSize',zArrowLength,...
    'linewidth',3,...
    'color',mygreen)

xlim([current_data.rigidbody.translation.x(1)-3000*1e-3 max(current_data.rigidbody.translation.x+3000*1e-3)])
ylim([current_data.rigidbody.translation.y(1)-3000*1e-3 max(current_data.rigidbody.translation.y+3000*1e-3)])
zlim([current_data.rigidbody.translation.z(1)-3000*1e-3 max(current_data.rigidbody.translation.z+3000*1e-3)])

axis equal

F(i) = getframe(h);
% close(h)
counter = counter + 1;

end
% 
% writerObj = VideoWriter(file_name,'MPEG-4');
% writerObj.Quality = 90;
% writerObj.FrameRate = 60;
% 
% open(writerObj);
% 
% writeVideo(writerObj,F);
% 
% close(writerObj);
% end
