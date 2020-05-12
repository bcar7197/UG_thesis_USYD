N = 100;   % length of signal in time domain

data = randn(1,N);   % simulated data

DATA = fft(data);   % FFT of data

%     %     %     %     %     %     %     %     %     %     %

% Construct Filter

hf_gain = 0;   % can be set independently

atten_factor = -0.1;

LTF = [ hf_gain linspace(atten_factor, 1, 30) ones(1,39) linspace(1, atten_factor, 30)  ];

% Plot filter

clf;

subplot(3,1,1);

plot(LTF, '-b.');

ylim([0  1.2]);

ylabel('Filter');

%     %     %     %     %     %     %     %     %     %     %

% Combine data and filter in frequency domain

LTF = fftshift(LTF);   % shift to match FFT output of data

COMBINED =  DATA .* LTF;   % multiply signal by filter

combined = ifft(COMBINED);   % convert to time domain

%     %     %     %     %     %     %     %     %     %     %

% Plot original and output signals

subplot(3,1,2);

hold on;

box on;

plot(data, '-bs');

plot(real(combined), '--r.');

ylabel('Time  Signals');

legend('original data', 'filtered signal');

% Plot difference between original and output signals

subplot(3,1,3);

plot(data - real(combined), '-g*');

ylabel('Difference');

ylim([-1 1]);