

% G-G Diagram Data 

clear vars; clc;

LatAcc = readmatrix('rc_accel_data (1).xlsx','range', 'A4:A2003'); % Lateral acc data (m/s^2)
LongAcc = readmatrix('rc_accel_data (1).xlsx','range','F4:F2003'); % Longitudinal acc data (m/s^2)

LatAccG = readmatrix('rc_accel_data (1).xlsx','range','C4:C1003'); % same data in terms of g's
LongAccG = readmatrix('rc_accel_data (1).xlsx','range','E4:E1003'); % data in g's for longitudinal 

fs = 50;              % sample frequency (Hz) <-- adjust for your data
fc = 5;                % cutoff frequency (Hz)
[b,a] = butter(3, fc/(fs/2));   % 3rd order Butterworth
LatAcc_f = filtfilt(b,a,LatAccG);
LongAcc_f = filtfilt(b,a,LongAccG);

mask = abs(LatAcc_f - mean(LatAcc_f)) < 3*std(LatAcc_f) & ...
       abs(LongAcc_f - mean(LongAcc_f)) < 3*std(LongAcc_f);
LatAcc_f = LatAcc_f(mask);
LongAcc_f = LongAcc_f(mask);    % getting rid of outliers more than 3 std dev away from mean

figure(1);   % unflitered data 
scatter(LatAccG,LongAccG);
title('G-G Diagram (unfiltered)');
xlabel('Lateral Acceleration (g)');
ylabel('Longitudinal Acceleration (g)');
grid on
hold on 

figure(2);  % filtered data
scatter(LatAcc_f,LongAcc_f);
title('G-G Diagram');
xlabel('Lateral Acceleration (g)');
ylabel('Longitudinal Acceleration (g)');
grid on
hold on
