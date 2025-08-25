% idealized camber gain in roll curves for front wheels

clearvars; clc;

track = 250/1000;  % track width (m)
lat_VSAL = 410.7/1000;  % front view virtual swing arm length (m) 

eqTerm = (track/lat_VSAL)*0.5; 

rad = linspace(0,0.349,1000);  % domain of camber change 
delta_C = zeros(size(rad));
%% Front calculations

for i = 1 : length(rad)    % loop to fill camber change array
    delta_C(1,i) = (1-eqTerm).*rad(1,i);
end
%%
delta_CD = delta_C.*(180/pi);   % switching from radians to degrees
deg = rad.*(180/pi);   

plot(deg,delta_CD);
grid on
xlabel('Chassis Roll (degrees)');
ylabel('Camber Change (degrees)');
title('Dynamic Camber in Roll (idealized)')
hold on
%% Rear calculations

lat_VSALR = 239.58/1000;  % rear view virtual swing arm length (m)

eqTermR = (track/lat_VSALR)*0.5;

rad = linspace(0,0.349,1000);  % domain of camber change 
delta_C = zeros(size(rad));
%%

for i = 1 : length(rad)    % loop to fill camber change array
    delta_C(1,i) = (1-eqTermR).*rad(1,i);
end
%%
delta_CD = delta_C.*(180/pi);   % switching from radians to degrees
deg = rad.*(180/pi);   

plot(deg,delta_CD);
grid on
xlabel('Chassis Roll (degrees)');
ylabel('Camber Change (degrees)');
title('Dynamic Camber in Roll (idealized)')
legend('Front wheel change','Rear wheel change','Location','best');
hold on
