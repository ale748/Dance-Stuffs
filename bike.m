function dw= bike(t,w,Tpedal,im,Params,Motor)
  M=Params.M;
  R=Params.R;
  I=Params.I;
  Ka=Params.Ka;
  Crr=Params.Crr;
  beta = Params.beta;
  g=Params.g;
  Pmax = Params.Pmax;
  Trr = feval(Params.Trr,w);
  Vimax = Params.Vi;
  imax = Params.imax;
##
##  i = (Vimax-w*Motor.Ki)/Motor.R;
##  if i >= imax
##    i=imax;
##  endif
##i
 i = im*imax;
  Vi = w*Motor.Ki+i*Motor.R;
  if Vi*i>Pmax
   i = Pmax / Vi;
  endif
  Vi = w*Motor.Ki+i*Motor.R;
  if Vi>Vimax
    Vi = Vimax;
  endif
  v = w*R;
  Fa = Params.Fa*v^2;
  N = M*g*cos(beta);
  Frr = Crr*N;
  Mgx = M*g*sin(beta);

  Tm = (Motor.Ki*Vi-w*Motor.Ki^2)/Motor.R;
  if Tm<0
    Tm = 0;
  endif
  dw = (Tm+Tpedal- (Trr*sign(w)) - R*(Mgx + Fa + Frr))/(I+M*R^2);
