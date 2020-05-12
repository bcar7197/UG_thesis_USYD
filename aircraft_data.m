%% Aircraft (Glider Data) - SI Units

current_data.rigidbody.aircraft.S = 0.044489; % m_2
current_data.rigidbody.aircraft.b = 0.42185; % m
current_data.rigidbody.aircraft.c = 0.13183;

% Mass distribution
current_data.rigidbody.aircraft.ixx = 0.00011235;
current_data.rigidbody.aircraft.iyy = 0.00082281;
current_data.rigidbody.aircraft.izz = 0.00092718;
current_data.rigidbody.aircraft.ixz = 0.00001007043;

if strfind(char(batch_file{index}),'24XX_pV') > 0
    current_data.rigidbody.aircraft.m = 33.6e-3; 
    
elseif strfind(char(batch_file{index}),'24XX_mV') > 0
    current_data.rigidbody.aircraft.m = 34.7e-3; 
    
elseif strfind(char(batch_file{index}),'24XX_pH') > 0
    current_data.rigidbody.aircraft.m  = 33.9e-3; 
    
elseif strfind(char(batch_file{index}),'24XX_mH') > 0
    current_data.rigidbody.aircraft.m   = 32.9e-3;
    
elseif strfind(char(batch_file{index}),'24') > 0   
    current_data.rigidbody.aircraft.m   = 30.6e-3;
    
elseif strfind(char(batch_file{index}),'44') > 0
    current_data.rigidbody.aircraft.m   = 35.5e-3;

elseif strfind(char(batch_file{index}),'64') > 0
    current_data.rigidbody.aircraft.m   = 37.2e-3;

    
end