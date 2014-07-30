function thRLeg=bld_RHipIK(RA_T_Pel)

L1=31/10;
L5=77/10;
L7=75.0/10;
L8=14.5/10;
Lb=sqrt(L7^2+L8^2);

r_RHip_Pel=[0 L5/2 L1].';

W_R_Pel_Des=RA_T_Pel(1:3,1:3);
W_r_RHip_Pel=W_R_Pel_Des*r_RHip_Pel;

r_RA_Pel=RA_T_Pel(1:3,4);
r_RA_RHip=r_RA_Pel-W_r_RHip_Pel;

RHipX=r_RA_RHip(1);	%Desired Hip Position X
RHipY=r_RA_RHip(2);	%Desired Hip Position Y
RHipZ=r_RA_RHip(3);	%Desired Hip Position Z

%Posición de la cadera
y1=RHipY;
x1=RHipX;
z1=RHipZ;

th17=-atan2(y1,z1);

l=sqrt(x1*x1+y1*y1+z1*z1);
cosG=-(l*l-2*Lb*Lb)/(2*Lb*Lb);
sinG=sqrt(1-cosG*cosG);
if isreal(sinG)
    G=pi-atan2(sinG,cosG);
else
    sinG=imag(sqrt(1-cosG*cosG));
    G=pi-atan2(sinG,cosG);
end
a0=atan2(L8,L7);

th13=-(G+2*a0);

a1=-atan2(x1,sqrt(y1*y1+z1*z1));
a2=(G)/2;
th15=-(a1-a2-a0);

%Orientacion de la Cadera

RAnkle_R_RHip=[  sin(th13 + th15),             cos(th13 + th15),                  0;...
                -cos(th13 + th15)*sin(th17),  sin(th13 + th15)*sin(th17), cos(th17);...
                 cos(th13 + th15)*cos(th17), -sin(th13 + th15)*cos(th17), sin(th17)];

R=RAnkle_R_RHip.'*W_R_Pel_Des;
ths=Rot2ths_CadDer(R);

th7=ths(1);
th9=ths(2);
th11=ths(3);

th7p=th7+pi/4;

%static int thRL(6);
thRLeg(1)=th7;
thRLeg(2)=th9;
thRLeg(3)=th11;
thRLeg(4)=th13;
thRLeg(5)=th15;
thRLeg(6)=th17;
