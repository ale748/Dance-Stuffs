clear all
tstep = round((1:100)/10);
t0=0;
x=1:length(tstep);
for i=1:length(tstep)
  t(i)=Tfilt(tstep(i),t0,0.7);
  t0=t(i);
end
plot(x,[tstep;t])

