function thLLeg=bld_LHipIK(LA_T_Pel)
L1=31/10;
L5=77/10;
L7=75.0/10;
L8=14.5/10;
Lb=hypot(L7,L8);

r_LHip_Pel=[0 -L5/2 L1].';

W_R_Pel_Des=LA_T_Pel(1:3,1:3);
W_r_LHip_Pel=W_R_Pel_Des*r_LHip_Pel;

r_LA_Pel=LA_T_Pel(1:3,4);
r_LA_LHip=r_LA_Pel-W_r_LHip_Pel;

LHipX=r_LA_LHip(1);	%Desired Hip Position X
LHipY=r_LA_LHip(2);	%Desired Hip Position Y
LHipZ=r_LA_LHip(3);	%Desired Hip Position Z
%Posición de la cadera
y1=LHipY;
x1=LHipX;
z1=LHipZ;

% th10=atan2(y1,z1);
th18=-atan2(y1,z1);

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

th14=(G+2*a0);

cosa1=(y1*y1+z1*z1)/(sqrt(y1*y1+z1*z1)*l);
sina1=sqrt(1-cosa1*cosa1);
a1=-atan2(x1,sqrt(y1*y1+z1*z1));
a2=(G)/2;
% th12=-(a1-a2-a0);
th16=a1-a2-a0;

%Orientación de la cadera
LAnkle_R_LHip=[  -sin(th14 + th16),            -cos(th14 + th16),           0;...
                 -cos(th14 + th16)*sin(th18),  sin(th14 + th16)*sin(th18), -cos(th18);...
                  cos(th14 + th16)*cos(th18), -sin(th14 + th16)*cos(th18), -sin(th18)];
                      
R=LAnkle_R_LHip.'*W_R_Pel_Des;

ths=Rot2ths_CadIzq(R);

th8=ths(1);
th10=ths(2);
th12=ths(3);

thLLeg(1)=th8;
thLLeg(2)=th10;
thLLeg(3)=th12;
thLLeg(4)=th14;
thLLeg(5)=th16;
thLLeg(6)=th18;