%% Guardian Rover - Master Initialization and Control Script
clear; clc; close all;

%% 1. Create Bus Objects
% Run your existing scripts to load the buses into the workspace
run('EmergencyState.m');
run('SensorDataBus.m'); 

    

% Define Lookup Table data
sensor_voltage_breakpoints = [0 1 2 3 4 5]; 
sensor_distance_table = [100 80 60 40 20 5]; 

disp('Parameters and Bus Objects loaded successfully.');

%% 3. Run Simulation
model_name = 'MAIN'; 
load_system(model_name);

disp('Running simulation...');
simOut = sim(model_name);
disp('Simulation complete.');

%% 4. Plot Diagnostics Data
figure('Name', 'Guardian Rover Diagnostics', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

% Plot 1: Active Robot State
subplot(2,1,1);
if isprop(simOut, 'Active_State')
    plot(simOut.Active_State.Time, simOut.Active_State.Data, 'LineWidth', 2, 'Color', '#7E2F8E');
    title('Active Robot State Over Time');
    xlabel('Time (s)');
    ylabel('State Code');
    yticks([0 1 2 3 4]);
    yticklabels({'0: IDLE', '1: FWD', '2: TURN L', '3: TURN R', '4: STOP'});
    ylim([-0.5 4.5]);
    grid on;
else
    disp('Warning: Active_State not found in simOut. Check your To Workspace block name.');
end

% Plot 2: Sensor Distances
subplot(2,1,2);
hold on;
if isprop(simOut, 'Dist_F') && isprop(simOut, 'Dist_L') && isprop(simOut, 'Dist_R')
    plot(simOut.Dist_F.Time, simOut.Dist_F.Data, 'r', 'LineWidth', 1.5);
    plot(simOut.Dist_L.Time, simOut.Dist_L.Data, 'g', 'LineWidth', 1.5);
    plot(simOut.Dist_R.Time, simOut.Dist_R.Data, 'b', 'LineWidth', 1.5);
    title('Ultrasonic Sensor Distances');
    xlabel('Time (s)');
    ylabel('Distance (cm)');
    legend('Front', 'Left', 'Right', 'Location', 'best');
    grid on;
else
    disp('Warning: Distance arrays not found. Check your To Workspace block names.');
end
hold off;