function [xls_data_filter] = butterworth_filter_new(xls_data,start_frame)

total_frames = size(xls_data,1)-start_frame+1;
frame_rate   = 1/(xls_data(9,2)-xls_data(8,2));
filter_mat = linspace(0.01,0.5,1000);

xls_data_filter(:,2) = xls_data(:,2);

for jj = 3:9
    
    x = xls_data(start_frame:(total_frames+7),jj);
    
for j = 1:length(filter_mat)

    cutoff_freq = filter_mat(j);
    [b,a] = butter(5,cutoff_freq,'low');
    y = filtfilt(b,a,x);
        
    R(j) = (1/length(y)*sum((x-y).^2))^0.5;

end

coeff = polyfit(filter_mat((end-500):end),R((end-500):end),1);

dist    = abs(R - coeff(2));
minDist = min(dist);
idx     = find(dist == minDist);

wn = filter_mat(idx);

if length(wn) > 1
    wn = wn(1);
end

[b,a] = butter(5,wn,'low');
y = filtfilt(b,a,xls_data(start_frame:(total_frames+7),jj));

xls_data_filter(8:(length(y)+7),jj) = y;

end

end

