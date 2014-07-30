function thLArm=bld_LArmIK(xLArm)
%Longitudes del robot
L0=47/10;
L1=25/10;
La=L0+L1;
L2=14.5/10;
L3=67.5/10;
L4=74.5/10;

x=xLArm(1);
y=xLArm(2);
z=xLArm(3);

th2=atan2(-z,x);
s=sqrt(z^2+x^2)-L2;
r=y-La;
t=sqrt(s^2+r^2);
D=(t^2-L3^2-L4^2)/(2*L3*L4);
th6=atan2(real(sqrt(1-D^2)),D);
th4=(atan2(s,r)-atan2(L4*sin(th6),L3+L4*cos(th6)));

%Asignacion de variables
thLArm(1)=th2;
thLArm(2)=th4;
thLArm(3)=th6;