close all
clear all;
clc;

Vbat  = 36.2;
Params.Pmax = 500;
Params.immax = 50;
Effx = .9;
Params.eff = @(im)Effx;
Tk=00;
ibat0=0.689;
Tbr0=0.3;
N0 = 221;
Motor.R = 3*150e-3;
Motor.Ki = 36.2/(2*pi*221/60);
Crr = (ibat0*Effx*Motor.Ki + Tbr0)/(N0*2*pi/60)
Arr = 0.00;
Trr = @(w)(Tk*sign(w)+Crr*w+Arr*(w^2)*sign(w));

w0=0;
Tbr = 0:100;
w = zeros(size(Tbr));
im = zeros(size(Tbr));
Vi = zeros(size(Tbr));
ibat = zeros(size(Tbr));

for i = 1:length(Tbr)
  w(i) = fsolve(@(w)motoreq(w,Vbat,Tbr(i),Trr,Motor,Params),w0);
  im(i) = (Tbr(i) + feval(Trr,w(i)))/Motor.Ki;
  if im(i)>Params.immax
    w(i)=NaN;
    im(i) = NaN;
  endif
  Vi(i) = w(i)*Motor.Ki + im(i)*Motor.R;
  if Vi(i)<Vbat
    ibat(i) = Vi(i)*im(i)/(feval(Params.eff,im)*Vbat);
  else
    ibat(i) = im(i)/(feval(Params.eff,im));
  endif
  w0 = w(i);
end
Pin = Vbat*ibat;
Pout = Tbr.*w;
Eff = Pout./Pin;
N=w*30/pi;
plot(Tbr,w)
figure
plot(Tbr,im,Tbr,Vi,Tbr,ibat)
figure;
ax = plotyy(Tbr,[Pin' Pout'],Tbr,Eff*100);
title('Power');
xlabel('Torque [Nm]');
ylabel(ax(1),'Power [W]');
ylabel(ax(2),'Efficiency [%]');

axis(ax(2),[0 50 0 100])
axis(ax(1),[0 50 0 700])
yticks(ax(2), (0:10)*100/10)
yticks(ax(1), (0:10)*700/10)

figure;
ax2 = plotyy(Tbr,N,Tbr,ibat);
title('Vel');
xlabel('Torque [Nm]');
ylabel(ax2(1),'Speed [rpm]');
ylabel(ax2(2),'Current [%]');
axis(ax2(2),[0 50 0 18])
axis(ax2(1),[0 50 0 260])
yticks(ax2(2), (0:10)*18/10)
yticks(ax2(1), (0:10)*260/10)

