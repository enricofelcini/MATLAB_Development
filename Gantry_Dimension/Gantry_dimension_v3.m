close all, clear all, clc

r = 2.2;                                    %Radius of curvature r = (Br)/B
th1 = 35*pi/180;;                             % Raise angle (UP)
th2 = pi/4;                            % Closing angle (DOWN)
N = 100;                                 % Number of points

lq45=0.5;

lq=0.175;

lqfup= 2*lq;

ldsad=2.5; %Distance from isocenter
lSM=0.5; %half length of full space occupied by scanning magnets, SAD is from ~half SM.

ldq=0.125; 		%extra length per side of the SC quadrupole
ldmb2q=0.200; 	%distance between SC dipole and SC quadrupole

ld45a=0.6; 		%postion of the NC quads (center) in the long 45degr drift
ld45b=1.;
ld45c=1.35;
ld45d=1.35;
ld45e=1.;		% the drift between ld45e and mbup is analytically determined by ld45	

ldbegin=2.5;%1.5; % ~some distance before the first bending upward
ldqbeg1=0.8;
ldqbeg2=0.5;
ldmb=0.25; %extra length before Lmag


% Calculation of the diagonal length 

x0 = linspace(0,0,N);
y0 = linspace(0, ldsad+lSM+ldmb);

theta = linspace(0,th2,N);
rho = linspace(r,r,N);
[x1,y1] = pol2cart(theta,rho);
x1 = x1 - x1(1)+x0(end);
y1 = y1 - y1(1)+y0(end);

x2 = linspace(x1(end), x1(end)-(2*ldmb+2*ldmb2q+2*ldq + lq)*sin(th2));
y2 = linspace(y1(end), y1(end)+(2*ldmb+2*ldmb2q+2*ldq + lq)*cos(th2));

theta = linspace(th2,2*th2,N);
[x3,y3] = pol2cart(theta,rho);
x3 = x3 - x3(1) + x2(end);
y3 = y3 - y3(1) + y2(end);

x4 = linspace(x3(end), x3(end)-(2*ldmb+2*ldmb2q+2*ldq + lq));
y4 = linspace(y3(end), y3(end));

theta = linspace(pi/2,pi/2+th1,N);
[x5,y5] = pol2cart(theta,rho);
x5 = x5 - x5(1) + x4(end);
y5 = y5 - y5(1) + y4(end);

l45tot = (y5(end)-r*(1-cos(th1/2))-(2*ldmb+2*ldmb2q+2*ldq + lqfup)*sin(th1/2)-r*(cos(th1/2)-cos(th1))- 2* ldmb*sin(th1))/sin(th1) ;

H_dipole = (ldsad+lSM+ldmb) + (r) + (2*ldmb+2*ldmb2q+2*ldq + lq)*sin(th2) -  r*(1-cos(th1)) - ldmb*sin(th1) ;
H_achromup = r*(1-cos(th1/2)) + 	  (2*ldmb+2*ldmb2q+2*ldq + lqfup)*sin(th1/2) + r*(cos(th1/2)-cos(th1)) + ldmb*sin(th1);

ld45 = (H_dipole-H_achromup)/sin(th1);

fprintf('H_dipole %f \n', H_dipole)
fprintf('H_achromup %f \n', H_achromup)
fprintf('ld45 %f \n', ld45)


if abs(l45tot-ld45) > 1.0E-6
    warning('Diagonal lenght not coherent');
end

x6 = linspace(x5(end), x5(end) -(2*ldmb+ld45)*cos(th1));
y6 = linspace(y5(end), y5(end)-(2*ldmb+ld45)*sin(th1));

theta = linspace(-pi/2+th1/2, -pi/2+th1,N);
[x7,y7] = pol2cart(theta,rho);
x7 = flip(x7);
y7 = flip(y7);
x7 = x7 - x7(1) + x6(end);
y7 = y7 - y7(1) + y6(end);

x8 = linspace(x7(end), x7(end)-(2*ldmb+2*ldmb2q+2*ldq + lqfup)*cos(th1/2));
y8 = linspace(y7(end), y7(end)-(2*ldmb+2*ldmb2q+2*ldq + lqfup)*sin(th1/2));

theta = linspace(-pi/2, -pi/2+th1/2,N);
[x9,y9] = pol2cart(theta,rho);
x9 = flip(x9);
y9 = flip(y9);
x9 = x9 - x9(1) + x8(end);
y9 = y9 - y9(1) + y8(end);

X = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9];
Y = [y0,y1,y2,y3,y4,y5,y6,y7,y8,y9];

if abs(Y(end)) > 1.0E-6
    warning('Not zero point at the coupling point');
end

figure; ax = axes('FontSize', 16, 'FontWeight', 'bold');
set(gcf,'color','w'); hold(ax,'on'); grid(ax,'on'); box(ax,'on'); axis equal;
for i =1:10
    plot(X((i-1)*N+1: i*N),Y((i-1)*N+1: i*N),'o');
end
plot(0,ldsad, 'rx');
xlabel('x [m]'); ylabel('y [m]');