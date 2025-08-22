%% Velocity vs. Time Simulation for 1/8 Scale Formula RC Car

clear; clc; close all;

%% Parameters
P_motor = 2400;       % Motor power in Watts
Kv = 2050;            % Motor speed constant in RPM/Volt
V_batt = 14.8;        % Battery voltage in Volts
gear_ratio = 4.3;     % Final drive ratio
tire_diam = 0.100;    % Tire diameter in meters (100 mm)
tire_width = 0.040;   % Tire width in meters (40 mm)
m = 3.718;            % Total car mass in kg
wb = 0.425;           % Wheelbase in meters
track = 0.250;        % Track width in meters
rho_air = 1.16;       % Air density (kg/m^3)

% Weight distribution
front_wt_frac = 0.40;
rear_wt_frac  = 0.60;

%% Aerodynamic Assumptions
% Frontal Area:
% Estimated here as width * height, where height ≈ 0.5 * track width.
height_est = 0.125;                  % Approx height in m (~half the track width assumption)
frontal_area = (track * height_est)-0.011;   % m²
A = frontal_area;

% Drag Coefficient:
Cd = 0.75;

%% Rolling Resistance Assumption
% Small foam/rubber tires on smooth asphalt have Crr ≈ 0.015–0.025.
% We take 0.02 as a reasonable average.
Crr = 0.02;

g = 9.81; % m/s²

%% Motor & Drivetrain Calculations
% Motor max RPM from Kv and voltage:
motor_max_rpm = Kv * V_batt;                  % RPM
motor_max_radps = motor_max_rpm * 2*pi/60;    % rad/s

% Max wheel RPM after gearing:
wheel_max_radps = motor_max_radps / gear_ratio;

% Wheel radius:
r_wheel = tire_diam / 2;

% Max no-load speed (m/s):
v_max_noload = wheel_max_radps * r_wheel;   % v = omega * r

%% Torque from Motor Power:
% Motor torque = Power / angular speed (at max power)   P = omega * tau
% Peak power usually at ~50% of no-load speed for brushed/brushless RC motors.
omega_peak_power = 0.5 * motor_max_radps;
T_motor_peak = P_motor / omega_peak_power;   % Nm at peak power
T_stall = 2 * T_motor_peak;      % Stall torque estimate 

% Torque at wheels after gearing:
T_wheel_peak = T_motor_peak * gear_ratio;    % Nm

% Peak tractive force at wheels:
F_trac_peak = T_wheel_peak / r_wheel;        % N

get_F_trac = @(v) ...
    max(0, (T_stall * (1 - (v / v_max_noload))) * gear_ratio / r_wheel);

%% Simulation Setup
dt = 0.01;              
t_end = 10;             % Simulate for 10 seconds
n_steps = t_end / dt;

v = 0;                  % Initializing
time = zeros(1, n_steps);
vel  = zeros(1, n_steps);

for i = 1:n_steps
    % Aerodynamic Drag Force: Fd = 0.5 * rho * Cd * A * v²
    F_drag = 0.5 * rho_air * Cd * A * v^2;
    
    % Rolling Resistance: Frr = Crr * m * g
    F_rr = Crr * m * g;
    
    % Available tractive force (simplified as constant at peak for this sim)
    % In reality, torque decreases with speed, but we'll apply a simple linear drop-off
    % until v_max_noload.
    F_trac = get_F_trac(v);
    
    % Net force: F_net = F_trac - F_drag - F_rr
    F_net = F_trac - F_drag - F_rr;
    
    % Acceleration: a = F_net / m
    a = F_net / m;
    
    % Update velocity:
    v = v + a * dt;
    if v < 0, v = 0;
    
   end % No backwards velocity
    
    % Store data
    time(i) = (i-1) * dt;
    vel(i)  = v;
end

%% Plot Results

v_range = linspace(0, v_max_noload, 200);
F_trac_curve = arrayfun(get_F_trac, v_range);

F_drag_curve = 0.5 * rho_air * Cd * A .* v_range.^2;
F_rr_total = Crr * m * g; % constant rolling resistance
F_resist_curve = F_drag_curve + F_rr_total;


figure;
tiledlayout(2,1);
nexttile;
plot(time, vel, 'LineWidth', 1); 
hold on
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs. Time - 1/8 Scale Formula RC Car');
grid on;

nexttile;

plot(v_range, F_trac_curve, 'LineWidth', 1);
hold on
plot(v_range, F_resist_curve, 'LineWidth', 1);
hold on
xlabel('Vehicle Speed (m/s)');
ylabel('Tractive Force (N)');
title('Tractive Force vs. Vehicle Speed');
grid on;

diff_force = F_trac_curve - F_resist_curve;        % Difference between forces
[~, idx_intersect] = min(abs(diff_force));        % Index of closest point
v_intersect = v_range(idx_intersect);             % Speed at intersection (m/s)
F_intersect = F_trac_curve(idx_intersect);        % Force at intersection (N)
plot(v_intersect,F_intersect,'Marker','o');
legend('Tractive Force','Drag + Rolling Resistance','Max Velocity (m/s)','Location','best');

