% File: Analysis_of_Characteristics_for_Direct_Current_Motor_in_Matlab.m
% Description: Analysis of Characteristics for Direct Current Motor in Matlab
% Environment: Matlab
%
% MIT License
% Copyright (c) 2017 Valentyn N Sichkar
% github.com/sichkar-valentyn
%
% Reference to:
% [1] Valentyn N Sichkar. Analysis of Characteristics for Direct Current Motor in Matlab // GitHub platform [Electronic resource]. URL: https://github.com/sichkar-valentyn/Analysis_of_Characteristics_for_Direct_Current_Motor_in_Matlab (date of access: XX.XX.XXXX)


%Simulation of Linear Control System using Functions From Control System Toolbox
%Analysis of Characteristics for Direct Current Motor
close all;

%% Motor Properties
Um_max = 30;    % Max applied voltage           Units: volts
Wmax = 300;     % Max velocity                  Units: rad/sec
Ra=15;          % Electrical resistance         Units: ohms
La= 0.15;       % Electrical inductance         Units: henry
J=0.12E-5;      % Inertia                       Units: Kg*m^2

Ta = La/Ra;     % Inductance Resistance Ratio
Ke=Um_max/Wmax; % Electromotive force constant  Units: volts / (rad/sec)
Km=Ke;          % Torque constant               Units: Nm / (Work)^2

%% Create transfer functions for each inertia
i = 1;
for J = 0.5E-6 : 0.5E-6 : 0.4E-5 
    %Store transfer functions
    Tm=(J*Ra)/(Ke*Km);
    theTFs(i) = tf(1/Ke, [Tm*Ta Tm 1]);
    
    %Store legend entries
    theLegend(i) = {['J=' num2str(J)]};
    i = i + 1;
end
L = size(theTFs);
L = L(2); % gets second numeber, which is length of the array

%% Nyquist
figure(1); hold;
P = nyquistoptions;
P.FreqUnits = 'Hz';
for i = 1:L
    nyquistplot(theTFs(i), P);
end
legend(theLegend);

%% Bode
figure(2); hold;
P = bodeoptions;
P.FreqUnits = 'Hz';
for i = 1:L
    bodeplot(theTFs(i), {10,10000}, P); grid on
end
legend(theLegend);
    
%% Step
figure(3); hold;
for i = 1:L
     step(theTFs(i), 0:0.001:0.15); grid on
end
legend(theLegend);

%% Impulse
figure(4); hold;
for i = 1:L
impulse(theTFs(i), 0:0.001:0.15); grid on
end
legend(theLegend);



