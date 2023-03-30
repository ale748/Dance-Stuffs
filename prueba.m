close all
clear all
clc


Params.M = 80;
Params.I = 2*0.3^2;
Params.g = 9.8;
Params.R = 0.6/2;
Params.Crr=0.04;
Params.beta=0*pi/180;
Params.Ka=.0;
Motor.R = 150e-3;
Motor.Ki = 48.65/(2*pi*331/60);
Params.Pmax = 477;
Params.imax = 48.9/Motor.Ki;
Params.Vi = 32;
Cd = 0.47;
density = 1.2;
Area = 1*0.6;
Params.Fa = Cd*density*Area/2;
Ta = 0.;
Tb =0.0;
Tc = 0.00;
Params.Trr = @(w)(Ta+w*Tb+w^2*Tc*sign(w));

Tp=0;
tstep  = 100;
tspan=[0 tstep];
w0=0;
t=[];
w=[];


ode_opt = odeset('MaxStep',1000,'AbsTol',1e-3);
  [t,w]=ode23(@(tx,wx)bike(tx,wx,Tp,1,Params,Motor),tspan,w0,ode_opt);
Vel=w*Params.R*3.6;
plot(t,Vel)

