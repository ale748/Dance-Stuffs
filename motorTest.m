clear all
close all;
clc;

Motor.R=500e-3;
Motor.L=100e-6;
Motor.Ki = 36.2/(2*pi*221/60);
Motor.Iner = 3*0.5^2;
Motor.imax = 15;
Motor.Crr = 1;
Motor.Arr = 0
Motor.M=3;
Motor.g=9.8;
Motor.Tr=0;
Vi=36;
tmax = 10;
tstart = tmax/20;

tspan = [0 tmax];
X0=[0 0];
Tbrake=@(t)brake(t,40,tstart,tmax);
ode_opt = odeset('MaxStep',1000,'AbsTol',1e-3);
[t,X]=ode45(@(t,X)motor(t,X,Vi,Tbrake,Motor),tspan,X0, ode_opt);
plot(t,X)
i=X(:,2);
w=X(:,1);
Pin=Vi*i;
Torque=zeros(size(t));
for j=1:length(t)
  Torque(j) = feval(Tbrake,t(j));
end;
Pout = w.*Torque;
Eff = Pout./Pin;
N=w*30/pi;
figure;
plot(Torque,N)
title('Speed');
xlabel('Torque [N/m]');
ylabel('Speed [rev/min]');
figure

ax = plotyy(Torque,[Pin Pout],Torque,Eff*100);
title('Power');
xlabel('Torque [N/m]');
ylabel(ax(1),'Power [W]');
ylabel(ax(2),'Efficiency [%]');
axis(ax(2),[0 40 0 100])
axis(ax(1),[0 40 0 600])

##
##plot(Torque,Eff*100);
##ylabel('Efficiency [%]');

