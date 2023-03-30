function T=Tfilt(Tx,T0,alpha);
  T=(T0+alpha*Tx)/(1+alpha);
end

