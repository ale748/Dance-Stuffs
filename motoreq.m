function F = motoreq (w,Vbat,Tbrake,Trr,Motor, Params)
  immax = Params.immax;
  Pimax = Params.Pmax;

  Ki = Motor.Ki;
  R = Motor.R;
  Tr = feval(Trr,w);
  Tm = Tr + Tbrake;
  im = Tm/Ki;
  eff = feval(Params.eff,im);
  Vi = Vbat;
  if Vi*im > eff* Pimax
    Vi = eff*Pimax / im;
  endif
  if im > immax
    F = 0;
  else
    F = Vi - im*R - w*Ki;
  endif



