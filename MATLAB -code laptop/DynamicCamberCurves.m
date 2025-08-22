% Dynamic Camber Curves

% Get data from excel file

clear; 

AngLF = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','D9:D29');   % Angle of left front wheel from vertical
TravelLF = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','F9:F29');   % Vertical wheel travel of Left front wheel (mm)


AngRF = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','H9:H29');   % Angle of right front wheel 
TravelRF = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','J9:J29');   % Wheel travel of right front wheel (mm)


AngLR = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','M9:M29');  % Angle of left rear wheel 
TravelLR = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','O9:O29');   % Wheel travel

AngRR = readmatrix('Dynamic Camber Data.xlsx', ...
    'Range','R9:R29');   % Angle of right rear wheel 
TravelRR = readmatrix('Dynamic Camber Data.xlsx', 'Range','T9:T29');


% Plot front wheel camber curves (theoretically left vs right are the same

 x = linspace(-6.25,6.25,200);
fit_x = polyfit(TravelLF,AngLF,6);
fit_y = polyval(fit_x,x);
plot(x, fit_y);
hold on


plot(TravelLF,AngLF,'-o', 'LineWidth', 1, 'MarkerSize', 4);
grid on 
xlabel('Vertical Wheel Travel (mm)');
ylabel(' Camber Angle (Deg)');
title('Dynamic Camber (Front wheels)')

hold on 

figure(2);
plot(x, fit_y);
xlabel('Vertical Wheel Travel (mm)');
ylabel(' Camber Angle (Deg)');
title('Dynamic Camber (Front wheels)')
grid on
hold on





