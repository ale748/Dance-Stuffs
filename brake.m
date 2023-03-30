function T = brake(t,Tmax,tstart, tmax)
  if t<tstart
    T=0;
  elseif t>tmax
    T=Tmax;
  else
    T=Tmax*(t-tstart)/tmax;
    endif

end

