function Pelvis_CoM=Pelvis_CoM(Ths)
 
Th1 =Ths(1);
Th2 =Ths(2);
Th3 =Ths(3);
Th4 =Ths(4);
Th5 =Ths(5);
Th6 =Ths(6);
Th7 =Ths(7);
Th8 =Ths(8);
Th9 =Ths(9);
Th10 =Ths(10);
Th11 =Ths(11);
Th12 =Ths(12);
Th13 =Ths(13);
Th14 =Ths(14);
Th15 =Ths(15);
Th16 =Ths(16);
Th17 =Ths(17);
Th18 =Ths(18);
L0=89.5;  L1=47;  L2=14.5;  L3=25;  L4=67.5; L5=74.5; 
L6=38.5;  L7=31;  L8=75;  L9=14.5;  L10=29.5; 
Lc0x=1.71; Lc0y=66.55;  Lc0z=18.27; 
Lc1y=4.06;  Lc1z=10.64;  Lc3y=22.58;  Lc3z=0.83; 
Lc5x=-0.98;  Lc5y=23.94;  Lc5z=0.92; 
Lc7y=8;   Lc7z=17.59;  Lc9y=15.03;  Lc9z=16.04; 
Lc11x=44.37;  Lc11y=1.22; Lc13x=11.09;  Lc13y=15.24; 
Lc15x=16.04;  Lc15y=15.03; Lc17x=27.09;  Lc17y=5.66; Lc17z=11.17; 
m0=695.4; m1=11.9; m3=76.5; m5=76.7; 
m2=m1; m4=m3; m6=m5; 
m7=15.1; m9=137; m11=31.2; m13=86.7; 
m8=m7; m10=m9; m12=m11; m14=m13; 
m15=137;  m17=37.4; 
m16=m15;  m18=m11; 
Pelvis_CoM(1)=(m10*(L6 + Lc9z*sin(Th8) - Lc9y*cos(Th8)*sin(Th10)) - m9*(L6 - Lc9z*sin(Th7) + Lc9y*cos(Th7)*sin(Th9)) - Lc0x*m0 + m16*(L6 + Lc15x*(cos(Th12 - Th14 - Th16)*sin(Th8) + sin(Th12 - Th14 - Th16)*cos(Th8)*sin(Th10)) - Lc15y*(sin(Th12 - Th14 - Th16)*sin(Th8) - cos(Th12 - Th14 - Th16)*cos(Th8)*sin(Th10)) - sin(Th8)*(L8*sin(Th12) - L9*cos(Th12) + L9*cos(Th12 - Th14) + L8*sin(Th12 - Th14)) + cos(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14))) + m14*(L6 + sin(Th8)*(L9*cos(Th12) - L8*sin(Th12)) - Lc13y*(sin(Th8)*cos(Th12 - Th14) + cos(Th8)*sin(Th10)*sin(Th12 - Th14)) - Lc13y*(sin(Th8)*sin(Th12 - Th14) - cos(Th8)*sin(Th10)*cos(Th12 - Th14)) + cos(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12))) + m18*(L6 + Lc17z*(cos(Th12 - Th14 - Th16)*sin(Th8) + sin(Th12 - Th14 - Th16)*cos(Th8)*sin(Th10)) - Lc17x*(cos(Th18)*(sin(Th12 - Th14 - Th16)*sin(Th8) - cos(Th12 - Th14 - Th16)*cos(Th8)*sin(Th10)) + cos(Th8)*cos(Th10)*sin(Th18)) - Lc17y*(sin(Th18)*(sin(Th12 - Th14 - Th16)*sin(Th8) - cos(Th12 - Th14 - Th16)*cos(Th8)*sin(Th10)) - cos(Th8)*cos(Th10)*cos(Th18)) - sin(Th8)*(L8*sin(Th12) - L9*cos(Th12) + L9*cos(Th12 - Th14) + L8*sin(Th12 - Th14)) + cos(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14))) + m15*(Lc15x*(cos(Th11 - Th13 - Th15)*sin(Th7) - sin(Th11 - Th13 - Th15)*cos(Th7)*sin(Th9)) - L6 + Lc15y*(sin(Th11 - Th13 - Th15)*sin(Th7) + cos(Th11 - Th13 - Th15)*cos(Th7)*sin(Th9)) + sin(Th7)*(L9*cos(Th11) + L8*sin(Th11) - L9*cos(Th11 - Th13) + L8*sin(Th11 - Th13)) + cos(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13))) - m3*(L1 - L3 + Lc3y*cos(Th3)) + m4*(L1 - L3 + Lc3y*cos(Th4)) + m12*(L6 - Lc11x*(sin(Th8)*sin(Th12) - cos(Th8)*cos(Th12)*sin(Th10)) + Lc11y*(cos(Th12)*sin(Th8) + cos(Th8)*sin(Th10)*sin(Th12))) + m13*(sin(Th7)*(L9*cos(Th11) + L8*sin(Th11)) - L6 + Lc13x*(sin(Th7)*sin(Th11 - Th13) + cos(Th7)*sin(Th9)*cos(Th11 - Th13)) - Lc13y*(sin(Th7)*cos(Th11 - Th13) - cos(Th7)*sin(Th9)*sin(Th11 - Th13)) + cos(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11))) + m17*(Lc17z*(cos(Th11 - Th13 - Th15)*sin(Th7) - sin(Th11 - Th13 - Th15)*cos(Th7)*sin(Th9)) - L6 + Lc17x*(cos(Th17)*(sin(Th11 - Th13 - Th15)*sin(Th7) + cos(Th11 - Th13 - Th15)*cos(Th7)*sin(Th9)) - cos(Th7)*cos(Th9)*sin(Th17)) + Lc17y*(sin(Th17)*(sin(Th11 - Th13 - Th15)*sin(Th7) + cos(Th11 - Th13 - Th15)*cos(Th7)*sin(Th9)) + cos(Th7)*cos(Th9)*cos(Th17)) + sin(Th7)*(L9*cos(Th11) + L8*sin(Th11) - L9*cos(Th11 - Th13) + L8*sin(Th11 - Th13)) + cos(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13))) - m1*(L1 + Lc1z) + m2*(L1 + Lc1z) - m5*(L1 - L3 + Lc5y*cos(Th3 + Th5) - Lc5x*sin(Th3 + Th5) + L4*cos(Th3)) + m6*(L1 - L3 + Lc5y*cos(Th4 + Th6) + Lc5x*sin(Th4 + Th6) + L4*cos(Th4)) - m7*(L6 - Lc7z*sin(Th7)) + m8*(L6 + Lc7z*sin(Th8)) + m11*(Lc11x*(sin(Th7)*sin(Th11) + cos(Th7)*cos(Th11)*sin(Th9)) - L6 + Lc11y*(cos(Th11)*sin(Th7) - cos(Th7)*sin(Th9)*sin(Th11))))/(m0 + m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + m10 + m11 + m12 + m13 + m14 + m15 + m16 + m17 + m18) ; 
Pelvis_CoM(2)=-(Lc7y*m7 - Lc0y*m0 + Lc7y*m8 + m13*(L7 + cos(Th9)*(L8*cos(Th11) - L9*sin(Th11)) + Lc13x*cos(Th9)*cos(Th11 - Th13) + Lc13y*cos(Th9)*sin(Th11 - Th13)) + m14*(L7 + cos(Th10)*(L8*cos(Th12) + L9*sin(Th12)) + Lc13y*cos(Th10)*cos(Th12 - Th14) - Lc13y*cos(Th10)*sin(Th12 - Th14)) + m17*(L7 + Lc17x*(sin(Th9)*sin(Th17) + cos(Th11 - Th13 - Th15)*cos(Th9)*cos(Th17)) - Lc17y*(cos(Th17)*sin(Th9) - cos(Th11 - Th13 - Th15)*cos(Th9)*sin(Th17)) + cos(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13)) - Lc17z*sin(Th11 - Th13 - Th15)*cos(Th9)) + m18*(L7 + Lc17x*(sin(Th10)*sin(Th18) + cos(Th12 - Th14 - Th16)*cos(Th10)*cos(Th18)) - Lc17y*(cos(Th18)*sin(Th10) - cos(Th12 - Th14 - Th16)*cos(Th10)*sin(Th18)) + cos(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14)) + Lc17z*sin(Th12 - Th14 - Th16)*cos(Th10)) - m3*(L0 + Lc3z*cos(Th1) + L2*sin(Th1) - Lc3y*sin(Th1)*sin(Th3)) - m4*(L0 + Lc3z*cos(Th2) + L2*sin(Th2) - Lc3y*sin(Th2)*sin(Th4)) + m15*(L7 + cos(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13)) + Lc15y*cos(Th11 - Th13 - Th15)*cos(Th9) - Lc15x*sin(Th11 - Th13 - Th15)*cos(Th9)) + m16*(L7 + cos(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14)) + Lc15y*cos(Th12 - Th14 - Th16)*cos(Th10) + Lc15x*sin(Th12 - Th14 - Th16)*cos(Th10)) + m11*(L7 + Lc11x*cos(Th9)*cos(Th11) - Lc11y*cos(Th9)*sin(Th11)) + m12*(L7 + Lc11x*cos(Th10)*cos(Th12) + Lc11y*cos(Th10)*sin(Th12)) + m9*(L7 - Lc9y*cos(Th9)) + m10*(L7 - Lc9y*cos(Th10)) - m1*(L0 + Lc1y*sin(Th1)) - m2*(L0 - Lc1y*sin(Th2)) - m5*(L0 + sin(Th1)*(L2 - L4*sin(Th3)) + Lc5z*cos(Th1) - Lc5x*cos(Th3 + Th5)*sin(Th1) - Lc5y*sin(Th3 + Th5)*sin(Th1)) - m6*(L0 + sin(Th2)*(L2 - L4*sin(Th4)) + Lc5z*cos(Th2) + Lc5x*cos(Th4 + Th6)*sin(Th2) - Lc5y*sin(Th4 + Th6)*sin(Th2)))/(m0 + m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + m10 + m11 + m12 + m13 + m14 + m15 + m16 + m17 + m18) ; 
Pelvis_CoM(3)=-(m13*(cos(Th7)*(L9*cos(Th11) + L8*sin(Th11)) + Lc13x*(cos(Th7)*sin(Th11 - Th13) - sin(Th7)*sin(Th9)*cos(Th11 - Th13)) - Lc13y*(cos(Th7)*cos(Th11 - Th13) + sin(Th7)*sin(Th9)*sin(Th11 - Th13)) - sin(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11))) - m14*(Lc13y*(cos(Th8)*sin(Th12 - Th14) + sin(Th8)*sin(Th10)*cos(Th12 - Th14)) - cos(Th8)*(L9*cos(Th12) - L8*sin(Th12)) + Lc13y*(cos(Th8)*cos(Th12 - Th14) - sin(Th8)*sin(Th10)*sin(Th12 - Th14)) + sin(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12))) + Lc0z*m0 + m3*(Lc3z*sin(Th1) - L2*cos(Th1) + Lc3y*cos(Th1)*sin(Th3)) - m4*(Lc3z*sin(Th2) - L2*cos(Th2) + Lc3y*cos(Th2)*sin(Th4)) + m17*(Lc17z*(cos(Th11 - Th13 - Th15)*cos(Th7) + sin(Th11 - Th13 - Th15)*sin(Th7)*sin(Th9)) + Lc17x*(cos(Th17)*(sin(Th11 - Th13 - Th15)*cos(Th7) - cos(Th11 - Th13 - Th15)*sin(Th7)*sin(Th9)) + cos(Th9)*sin(Th7)*sin(Th17)) + Lc17y*(sin(Th17)*(sin(Th11 - Th13 - Th15)*cos(Th7) - cos(Th11 - Th13 - Th15)*sin(Th7)*sin(Th9)) - cos(Th9)*cos(Th17)*sin(Th7)) + cos(Th7)*(L9*cos(Th11) + L8*sin(Th11) - L9*cos(Th11 - Th13) + L8*sin(Th11 - Th13)) - sin(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13))) - m18*(Lc17x*(cos(Th18)*(sin(Th12 - Th14 - Th16)*cos(Th8) + cos(Th12 - Th14 - Th16)*sin(Th8)*sin(Th10)) - cos(Th10)*sin(Th8)*sin(Th18)) - Lc17z*(cos(Th12 - Th14 - Th16)*cos(Th8) - sin(Th12 - Th14 - Th16)*sin(Th8)*sin(Th10)) + Lc17y*(sin(Th18)*(sin(Th12 - Th14 - Th16)*cos(Th8) + cos(Th12 - Th14 - Th16)*sin(Th8)*sin(Th10)) + cos(Th10)*cos(Th18)*sin(Th8)) + cos(Th8)*(L8*sin(Th12) - L9*cos(Th12) + L9*cos(Th12 - Th14) + L8*sin(Th12 - Th14)) + sin(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14))) + m11*(Lc11x*(cos(Th7)*sin(Th11) - cos(Th11)*sin(Th7)*sin(Th9)) + Lc11y*(cos(Th7)*cos(Th11) + sin(Th7)*sin(Th9)*sin(Th11))) - m12*(Lc11x*(cos(Th8)*sin(Th12) + cos(Th12)*sin(Th8)*sin(Th10)) - Lc11y*(cos(Th8)*cos(Th12) - sin(Th8)*sin(Th10)*sin(Th12))) + m5*(Lc5z*sin(Th1) - cos(Th1)*(L2 - L4*sin(Th3)) + Lc5x*cos(Th3 + Th5)*cos(Th1) + Lc5y*sin(Th3 + Th5)*cos(Th1)) + m6*(cos(Th2)*(L2 - L4*sin(Th4)) - Lc5z*sin(Th2) + Lc5x*cos(Th4 + Th6)*cos(Th2) - Lc5y*sin(Th4 + Th6)*cos(Th2)) + m9*(Lc9z*cos(Th7) + Lc9y*sin(Th7)*sin(Th9)) + m10*(Lc9z*cos(Th8) + Lc9y*sin(Th8)*sin(Th10)) + m15*(Lc15x*(cos(Th11 - Th13 - Th15)*cos(Th7) + sin(Th11 - Th13 - Th15)*sin(Th7)*sin(Th9)) + Lc15y*(sin(Th11 - Th13 - Th15)*cos(Th7) - cos(Th11 - Th13 - Th15)*sin(Th7)*sin(Th9)) + cos(Th7)*(L9*cos(Th11) + L8*sin(Th11) - L9*cos(Th11 - Th13) + L8*sin(Th11 - Th13)) - sin(Th7)*sin(Th9)*(L8*cos(Th11) - L9*sin(Th11) + L8*cos(Th11 - Th13) + L9*sin(Th11 - Th13))) - m16*(Lc15y*(sin(Th12 - Th14 - Th16)*cos(Th8) + cos(Th12 - Th14 - Th16)*sin(Th8)*sin(Th10)) - Lc15x*(cos(Th12 - Th14 - Th16)*cos(Th8) - sin(Th12 - Th14 - Th16)*sin(Th8)*sin(Th10)) + cos(Th8)*(L8*sin(Th12) - L9*cos(Th12) + L9*cos(Th12 - Th14) + L8*sin(Th12 - Th14)) + sin(Th8)*sin(Th10)*(L8*cos(Th12) + L9*sin(Th12) + L8*cos(Th12 - Th14) - L9*sin(Th12 - Th14))) - Lc1y*m1*cos(Th1) - Lc1y*m2*cos(Th2) + Lc7z*m7*cos(Th7) + Lc7z*m8*cos(Th8))/(m0 + m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + m10 + m11 + m12 + m13 + m14 + m15 + m16 + m17 + m18) ; 
