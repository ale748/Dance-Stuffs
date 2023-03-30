function dX = motor(t,X,Vi,Tbrake,MotorParams)
  R=MotorParams.R;
  L=MotorParams.L;
  Ki=MotorParams.Ki;
  Iner=MotorParams.Iner;
  imax=MotorParams.imax;
  M=MotorParams.M;
  g=MotorParams.g;
  Tr=MotorParams.Tr;
  Crr = MotorParams.Crr;
  Arr = MotorParams.Arr;
  w=X(1);
  i=X(2);
  if (Vi-w*Ki)/R >imax
    Vi = imax*R + w*Ki;
  endif
  dw = (Ki*i-feval(Tbrake,t)*sign(w)-Crr*w - Tr*sign(w) - sign(w)*Arr*(w^2))/Iner;
  di = (Vi-i*R-w*Ki)/L;
  dX = zeros(size(X));
  dX(1)=dw;
  dX(2)=di;
