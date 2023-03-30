clear all
close all
clc
[fname fpath fltidx] = uigetfile();

fid=fopen([fpath fname]);
sizeA=[8 Inf];
A=fscanf(fid,'%d %f %f %f %f %f %f %f',sizeA)';
fclose (fid);
index = A(:,1);
fid = fopen([fpath 'Converted\' fname]);
[m n] = size(A)
for i = 1:m

  fprintf(fid,"%d;%f;%f;%f;%f;%f;%f;%f",A(i,1),A(i,2),A(i,3),A(i,4),A(i,5),A(i,6),A(i,7),A(i,8));
end
fclose (fid);
I=2*0.015^2;
T = A(:,2);
N = A(:,3);
w = 2*pi*N/60;
Pout = A(:,4);
Volt = A(:,5);
Current = A(:,6);
Pout = A(:,7);
effic = A(:,8);
Resistance = T.*w*I;
plot(T,N,'.')
figure
plot(N,Resistance,'.')
