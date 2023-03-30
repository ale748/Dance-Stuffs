function F = calcC11C2(x,s,Z1,Zout)
  C1 = x(1);
  ZC1 = 1/(C1*s);
  C2 = x(2);
  ZC2 = 1/(C2*s);
  Zin2 = ((Z1*ZC2)/(Z1+ZC2))+2*ZC1;
##  Zin2 = (1/((1/ZC2)+(1/ZrxTot)+(1/Za)))+2*ZC1;
  %Zin2 = (ZC1/2) + 1/((1/ZC2)+(1/ZrxTot)+(1/Za));

  Zeq = conj(Zin2)-Zout;
  F(1) =  imag(Zeq);
  F(2) = real(Zeq);
