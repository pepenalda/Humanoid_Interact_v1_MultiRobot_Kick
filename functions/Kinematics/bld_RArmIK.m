function thRArm=bld_RArmIK(xRArm)
%Longitudes del robot
L0=47/10;
L1=25/10;
La=L0+L1;
L2=14.5/10;
L3=67.5/10;
L4=74.5/10;

x=xRArm(1);
y=xRArm(2);
z=xRArm(3);

th1=atan2(z,x);
s=sqrt(z^2+x^2)-L2;
r=-(y)-La;
t=sqrt(s^2+r^2);
D=(t^2-L3^2-L4^2)/(2*L3*L4);
th5=-atan2(real(sqrt(1-D^2)),D);
%Gamma=acos(D)*180/pi
% D=-(t^2-L3^2-L4^2)/(2*L3*L4);
% th5=atan2(real(sqrt(1-D^2)),D);
th3=-(atan2(s,r)+atan2(L4*sin(th5),L3+L4*cos(th5)));

%Asignacion de variables
thRArm(1)=th1;
thRArm(2)=th3;
thRArm(3)=th5;
