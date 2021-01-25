%% Geomtrical Analysis for the Toroidal Amplifier for the Scanning System
clc, close all, clear all
% Parameters fot the sanning magntes
% Tommasini 09/12/2020 (SIGRUM Report): AngX = 53 mrad, AngY = 60 mrad, Lx = 0.22 m, Ly = 0.37 m
% The Scanning sequence is X and Y

ascan_x = 53.0E-3;   %Scanning Angle X [rad]
ascan_y = 0.0E-3;   %Scanning Angle Y [rad]
Lscan_x = 0.22;     %Length (along z) of Scanning Magnet X [m]
Lscan_y = 0.37;     %Length (along z) of Scanning Magnet Y [m]
SADx = 2.8;         %SAD at the center of the Scannning X [m] 
SADy = 2.5;         %SAD at the center of the Scannning Y [m] 

% Parameters for the toroidal amplifier
Br = 6.6;           %Beam rigidity [Tm]  
B = 1.5;            %Field in the Toroidal Amplifier [T]
ascan_t = 2*pi/180; %Deviation angle introduced by toroidal amplifier [rad] 
SADt = 2.0;         %SAD of the toroidal amplifier [m]

R = Br/B;           %Radius of curvature [m]

Lscan_t = R*sin(ascan_t);           %Lenght (along z) of toroidal scan
Ascan_t = R*(1-cos(sin(ascan_t)));   %Aperture of the toroidal scan --> define the external radius of the torus

%% Description of particle tracjectory (x = rotation axis, y = transverse, z = height)
N = 100;

z1 = linspace(SADx, SADy, N);
x1 = linspace(0, abs(z1(end)-z1(1))*tan(ascan_x), N);

z2 = linspace(z1(end), SADt, N);
x2 = linspace(x1(end), x1(end)+abs(z2(end)-z2(1))*tan(ascan_x), N);

z3 = linspace(z2(end), 0, N);
x3 = linspace(x2(end), x2(end)+abs(z3(end)-z3(1))*tan(ascan_x+ascan_t), N);

%Join the vectors
x = {x1,x2, x3};
z = {z1, z2, z3};

%% Post processing
figure; hold on; axis equal;
for i=1:length(x)
    plot(x{i},z{i});
end

xlabel('x [m]'); ylabel('z [m]')


