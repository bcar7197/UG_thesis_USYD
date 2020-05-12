% h = [x_r y_r z_r w_r x y z]

%perform a third order repair of any NaN points
for h = 3:9
    
    % repairs done when node is at least 3 from start/end
for i = (start_frame+2):(max_frames+5)
    
    if isnan(xls_data(i,h)) == 1
        
        % Get Previous 2 points
        pt(1,1) =  xls_data(i-2,2); %time(1)
        pt(1,2) =  xls_data(i-2,h); %f(t_1)
        pt(2,1) =  xls_data(i-1,2); %time(2)
        pt(2,2) =  xls_data(i-1,h); %f(t_2)
        
        % Get new 2 points (after NaN)
        counter = 0;
        for j = (i+1):(max_frames+7)

             if isnan(xls_data(j,h)) == 0 && counter <=2
                 pt(counter+3,1) =  xls_data(j,2); 
                 pt(counter+3,2) =  xls_data(j,h);   
                 counter = counter + 1; 
            end
        end
          
         
        %perform 3rd order fit
        A = [pt(1,1)^3 pt(1,1)^2 pt(1,1) 1; ...
                pt(2,1)^3 pt(2,1)^2 pt(2,1) 1; ...
                    pt(3,1)^3 pt(3,1)^2 pt(3,1) 1; ...
                        pt(4,1)^3 pt(4,1)^2 pt(4,1) 1];
              
        B = [pt(1,2); pt(2,2); pt(3,2); pt(4,2)];
        
        xls_data(i,h) = [xls_data(i,2)^3 xls_data(i,2)^2 xls_data(i,2) 1]*inv(A)*B;
        
        end
         
    end
    
end