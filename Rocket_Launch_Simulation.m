% Rocket Numerical Simulation

% Parameters
Dt = 0.1;                  % Time step (s)
t_f = 510;                 % Time of rocket engine shut off (s)

% allocating size of variable arrays
t = [0:Dt:t_f];                 % Time vector (s)
Mass = zeros(1, length(t));     % Mass (kg)
Theta = zeros(1, length(t));    % Angle (deg)
g = zeros(1, length(t));        % Acceleration of gravity (m/s^2)
W = zeros(1, length(t));        % Weight force (N)
Rho = zeros(1, length(t));      % Air density (kg/m^3)
Drag = zeros(1, length(t));     % Drag force (N)
Fx = zeros(1, length(t));       % Net horizontal force (N)
Fy = zeros(1, length(t));       % Net vertical force (N)
Ax = zeros(1, length(t));       % Horizontal acceleration (m/s^2)
Ay = zeros(1, length(t));       % Vertical Acceleration (m/s^2)
Vx = zeros(1, length(t));       % Horizontal velocity (m/s)
Vy = zeros(1, length(t));       % Vertical velocity (m/s)
x = zeros(1, length(t));        % Horizontal position (m)
y = zeros(1, length(t));        % Vertical position (m)
Distancex = zeros(1, length(t));    % Horizontal distance travelled (m)
Distancey = zeros(1, length(t));    % Vertical distance travelled (m)
Distance = zeros(1, length(t));     % Total distance travelled (m)

% Constants
C = 0.4;                        % Drag coefficient
Rho_0=1.225;                    % air density at sea level (kg/m^3)
A = pi*3.7^2;                   % cross sectional area of rocket (m^2)
G=6.67408*10^-11;               % Gravitation Constant (m^3/kg.s^2)
M_earth=5.9722*10^24;           % Mass of the Earth (kg)
R_earth=6.371*10^6;             % Radius of Earth (m)
M_0=500000;                     % Initial mass (kg)
M_final=22800;                  % Payload to low earth orbit (kg)
M_fuel=M_0-M_final;             % Mass used to reach orbit (kg)
u=5500;                         % Relative exhaust velocity (m/s)
dm_dt=M_fuel/t(length(t));      % Rate of change of mass (kg/s)
Thrust=u*dm_dt;                 % Thrust (N)

% Initial Conditions
Theta(1) = 90;                  % Initial angle (deg)
Ax(1) = 0;                      % Initial horizontal acceleration (m/s^2)
Ay(1) = 0;                      % Initial vertical acceleration (m/s^2)
Vx(1) = 0;                      % Initial horizontal velocity (m/s)
Vy(1) = 0;                      % Initial vertical velocity (m/s)
x(1) = 0;                       % Initial horizontal position (m)
y(1) = 0;                       % Initial vertical position (m)
Distancex(1) = 0;               % Initial horizontal distance travelled (m)
Distancey(1) = 0;               % Initial vertical distance travelled (m)
Distance(1) = 0;                % Initial  distance travelled (m)
Mass(1) = M_0;                  % Initial rocket mass (kg)
Fx(1) = 0;                      % Initial horizontal net force (N)
Fy(1) = 0;                      % Initial vertical net force (N)
         
% Looping until engine shut off and calculating instantaneous variables
for n=2:length(t)                  % Run until rocket engine shut off
                      
    Mass(n)=M_0-dm_dt*t(n);         % instantaneous mass (kg)
    g(n) =(G*M_earth)/((R_earth+y(n-1))^2);     % Gravity (m/s^2)
    W(n)=Mass(n)*g(n);                  % instantaneous weight force
   
    % Drag force calculation
    Rho(n) =Rho_0*exp(-y(n-1)/8000);                % Air density (kg/m^3)
    Drag(n)= 0.5*C*Rho(n)*A*((Vx(n-1)+Vy(n-1))^2); % Calculate drag force
    
    % Net Forces  
    Fx(n)= Thrust*cosd(Theta(n-1))-Drag(n)*cosd(Theta(n-1))-W(n)*cosd(Theta(n-1)); % Sum of x forces
    Fy(n)= Thrust*sind(Theta(n-1))-W(n)*sind(Theta(n-1))-Drag(n)*sind(Theta(n-1)); % Sum of y forces
        
    % Acceleration calculations
    Ax(n)= Fx(n)/Mass(n);                       % Net acceleration in horizontal direction 
    Ay(n)= Fy(n)/Mass(n);                       % Net acceleration in vertical direction
	
    % Velocity calculations
    Vx(n)= Vx(n-1)+Ax(n)*Dt;                 % Velocity in horizontal direction
    Vy(n)= Vy(n-1)+Ay(n)*Dt;                 % Velocity in vertical direction
    
	
    % Position calculations
    x(n)= x(n-1)+Vx(n)*Dt;                   % Position in horizontal direction
    y(n)= y(n-1)+Vy(n)*Dt;                   % Position in vertical direction
    
    % Distance calculations    
    Distancex(n) = Distancex(n-1)+abs(Vx(n)*Dt);      % Horizontal Distance 
    Distancey(n) = Distancey(n-1)+abs(Vy(n)*Dt);      % Vertical Distance  
    Distance(n) = (Distancex(n)^2+Distancey(n)^2)^(1/2); % Total distance travelled

    % Rocket angle calculation
   if y(n)<9000  % Initial launch angle
       Theta(n)=90;
   elseif y(n)>=9000 && y(n)<=11000 % angle at gravity turn
        Theta(n)=85; 
   elseif y(n)>11000  % angle after gravity turn
        Theta(n)=atand(g(n)/(Ax(n)+Ay(n))); 
    end
end

% Plotting graphs of important variables in subplot
subplot(3,3,1)
plot(t(1:length(t)),Ax(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Ax (m/s^2)'});
title({'Horizontal Acceleration'});

subplot(3,3,2)
plot(t(1:length(t)),Ay(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Ay (m/s^2)'});
title({'Vertical Acceleration'});


subplot(3,3,3)
plot(x(1:length(t)),y(1:length(t))); 
xlabel({'Range (m)'});
ylabel({'Altitude (m)'});
title({'Trajectory'});

subplot(3,3,4)
plot(t(1:length(t)),Vx(1:length(t)));
ylim([0,10000]);
xlabel({'Time (s)'});
ylabel({'Vx (m/s)'});
title({'Horizontal Velocity'});

subplot(3,3,5)
plot(t(1:length(t)),Vy(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Vy (m/s)'});
title({'Vertical Velocity'});

subplot(3,3,6)
plot(t(1:length(t)),Mass(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Mass (kg)'});
title({'Rocket Mass'});

subplot(3,3,7)
plot(t(1:length(t)),Theta(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Theta (Deg)'});
title({'Theta'});

subplot(3,3,8)
plot(Distance(1:length(t)),Theta(1:length(t)));
xlabel({'Distance (m)'});
ylabel({'Theta (Deg)'});
title({'Theta vs Distance Travelled'});


subplot(3,3,9)
plot(t(1:length(t)),Drag(1:length(t)));
xlabel({'Time (s)'});
ylabel({'Drag (N)'});
title({'Drag Force'});
