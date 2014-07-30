function M=get_M_NE(q_B_actual,dq_B_actual,th_actual,dth_actual)

[Js_Tr, Js_BrDr, Js_BrIz, Js_PrDr, Js_PrIz]=Jacobians(q_B_actual,dq_B_actual,th_actual,dth_actual);

L0=0.0895; L1=0.047; L2=0.0145; L3=0.025; L4=0.0675; L5=0.0745;
L6=0.0385; L7=0.031; L8=0.075; L9=0.0145; L10=0.0295;
Lc0z=0.066; Lc0x=0.019;
Lc1z=0.011;  Lc3y=0.023;  Lc5y=0.024;
Lc7y=0.016; Lc7z=10;
Lc9y=0.015; Lc9z=15;  Lc11x=0.044; Lc13x=0.011;
Lc13y=0.015;
Lc15x=0.016; Lc15y=0.015; Lc17x=0.026; Lc17z=0.012;
I0xx=0.0008337;  I0yy=0.0007232; I0zz=0.0009933;  I0xz=0.0000058;  I0yz=0.0001069;
I1xx=0.0000022;  I1yy=0.0000051;  I1zz=0.0000053;  I1xz=0.0000004;
I3xx=0.0000238;  I3yy=0.0000077;  I3zz=0.0000190;
I5xx=0.0000284;  I5yy=0.0000054;   I5zz=0.0000267;  I5xy=0.0000032;
I7xx=0.0000139;  I7yy=0.0000027;   I7zz=0.0000133;
I9xx=0.0000529;  I9yy=0.0000542;   I9zz=0.0000110; I9xz=0.0000010; I9yz=0.0000014;
I11xx=0.0000138;  I11yy=0.0000253;  I11zz=0.0000169; I11xy=0.0000013;
I13xx=0.0000135;  I13yy=0.0000435;   I13zz=0.0000372;
I15xx=0.0000110;  I15yy=0.0000542;   I15zz=0.0000529;  I15xy=0.0000014;  I15xz=0.0000010;
I17xx=0.0000395;  I17yy=0.0000337;   I17zz=0.0000116;
m0=0.6954; m1=0.0119; m3=0.0765; m5=0.0767; 
m7=0.0151; m9=0.137; m11=0.0312; m13=0.0867; 
m15=0.137;  m17=0.0374; 

th1=th_actual(1);
th2=th_actual(2);
th3=th_actual(3);
th4=th_actual(4);
th5=th_actual(5);
th6=th_actual(6);
th7=th_actual(7);
th8=th_actual(8);
th9=th_actual(9);
th10=th_actual(10);
th11=th_actual(11);
th12=th_actual(12);
th13=th_actual(13);
th14=th_actual(14);
th15=th_actual(15);
th16=th_actual(16);
th17=th_actual(17);
th18=th_actual(18);

phi=q_B_actual(4);
th=q_B_actual(5);
psi=q_B_actual(6);

W_R_B=EulYXZ_2_Rot(phi,th,psi);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%Brazo Derecho
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=sin(th1);
c1=cos(th1);
s3=sin(th3);
c3=cos(th3);
s5=sin(th5);
c5=cos(th5);

BrDr_0_H_1=[
                       -s1   -c1    0     0;
                         0     0   -1   -L1;
                        c1   -s1    0    L0;
                         0     0    0     1];
BrDr_1_H_2=[
                         0    0  1    0;
                       -c3  -s3  0  -L2;
                        s3  -c3  0  -L3;
                         0    0  0    1];
BrDr_2_H_3=[
                        c5  s5  0    0;
                       -s5  c5  0  -L4;
                         0   0  1    0;
                         0   0  0    1];      
BrDr_3_H_4=[
                         0   0  1    0;
                         1   0  0  -L5;
                         0   1  0    0;
                         0   0  0    1];
%%%Posiciones de los centros de masa
BrDr_1_r_c1=[0 0 Lc1z].';
BrDr_2_r_c2=[0 -Lc3y 0].';
BrDr_3_r_c3=[0 -Lc5y 0].';

%Momentos de Inercia 
BrDr_I_1=[I1xx     0     0;
              0  I1yy -I1xz;
              0 -I1xz  I1zz];
          
BrDr_I_2=[I3xx    0    0;
              0 I3yy    0;
              0    0 I3zz];
          
BrDr_I_3=[ I5xx I5xy     0; 
            I5xy I5yy     0;
               0    0 I5zz];

W_R_BrDr1=W_R_B*BrDr_0_H_1(1:3,1:3);
W_R_BrDr2=W_R_BrDr1*BrDr_1_H_2(1:3,1:3);
W_R_BrDr3=W_R_BrDr2*BrDr_2_H_3(1:3,1:3);

M_BrDr_JsAng=Js_BrDr.Jw_BrDr_1.'*W_R_BrDr1*BrDr_I_1*W_R_BrDr1'*Js_BrDr.Jw_BrDr_1;
M_BrDr_JsAng=M_BrDr_JsAng+Js_BrDr.Jw_BrDr_2.'*W_R_BrDr2*BrDr_I_2*W_R_BrDr2'*Js_BrDr.Jw_BrDr_2;
M_BrDr_JsAng=M_BrDr_JsAng+Js_BrDr.Jw_BrDr_3.'*W_R_BrDr3*BrDr_I_3*W_R_BrDr3'*Js_BrDr.Jw_BrDr_3;

M_BrDr_Lag=M_BrDr_JsAng+m1*Js_BrDr.J_BrDr_c1.'*Js_BrDr.J_BrDr_c1;
%M_BrDr_Lag=m1*Js_BrDr.J_BrDr_c1.'*Js_BrDr.J_BrDr_c1;
M_BrDr_Lag=M_BrDr_Lag+m3*Js_BrDr.J_BrDr_c2.'*Js_BrDr.J_BrDr_c2;
M_BrDr_Lag=M_BrDr_Lag+m5*Js_BrDr.J_BrDr_c3.'*Js_BrDr.J_BrDr_c3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%Brazo Izquierdo
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s2=sin(th2);
c2=cos(th2);
s4=sin(th4);
c4=cos(th4);
s6=sin(th6);
c6=cos(th6);

BrIz_0_H_1=[
                        s2    c2    0     0;
                         0     0    1   -L1;
                        c2   -s2    0    L0;
                         0     0    0     1];
BrIz_1_H_2=[
                         0    0  1    0;
                       -c4  -s4  0  -L2;
                        s4  -c4  0  -L3;
                         0    0  0    1];
BrIz_2_H_3=[
                        c6  s6  0    0;
                       -s6  c6  0  -L4;
                         0   0  1    0;
                         0   0  0    1];

BrIz_3_H_4=[
                         0   0  1    0;
                         1   0  0  -L5;
                         0   1  0    0;
                         0   0  0    1];

%Posiciones de los centros de masa
BrIz_1_r_c1=[0 0 Lc1z].';
BrIz_2_r_c2=[0 -Lc3y 0].';
BrIz_3_r_c3=[0 -Lc5y 0].';

% %Momentos de Inercia 
BrIz_I_1=[  I1xx I1xz     0;
            I1xz I1yy     0;
               0    0 I1zz];
           
BrIz_I_2=[  I3xx    0    0;
               0 I3yy    0;
               0    0 I3zz];
           
BrIz_I_3=[   I5xx -I5xy    0;
            -I5xy  I5yy    0;
                0     0 I5zz];

W_R_BrIz1=W_R_B*BrIz_0_H_1(1:3,1:3);
W_R_BrIz2=W_R_BrIz1*BrIz_1_H_2(1:3,1:3);
W_R_BrIz3=W_R_BrIz2*BrIz_2_H_3(1:3,1:3);

M_BrIz_JsAng=Js_BrIz.Jw_BrIz_1.'*W_R_BrIz1*BrIz_I_1*W_R_BrIz1'*Js_BrIz.Jw_BrIz_1;
M_BrIz_JsAng=M_BrIz_JsAng+Js_BrIz.Jw_BrIz_2.'*W_R_BrIz2*BrIz_I_2*W_R_BrIz2'*Js_BrIz.Jw_BrIz_2;
M_BrIz_JsAng=M_BrIz_JsAng+Js_BrIz.Jw_BrIz_3.'*W_R_BrIz3*BrIz_I_3*W_R_BrIz3'*Js_BrIz.Jw_BrIz_3;

M_BrIz_Lag=M_BrIz_JsAng+m1*Js_BrIz.J_BrIz_c1.'*Js_BrIz.J_BrIz_c1;
%M_BrIz_Lag=m1*Js_BrIz.J_BrIz_c1.'*Js_BrIz.J_BrIz_c1;
M_BrIz_Lag=M_BrIz_Lag+m3*Js_BrIz.J_BrIz_c2.'*Js_BrIz.J_BrIz_c2;
M_BrIz_Lag=M_BrIz_Lag+m5*Js_BrIz.J_BrIz_c3.'*Js_BrIz.J_BrIz_c3;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%Pierna Derecha
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s7=sin(th7);
c7=cos(th7);
s9=sin(th9);
c9=cos(th9);
s11=sin(th11);
c11=cos(th11);
s13=sin(th13);
c13=cos(th13);
s15=sin(th15);
c15=cos(th15);
s17=sin(th17);
c17=cos(th17);

PrDr_0_H_1=[
                       -s7     0  -c7     0;
                       -c7     0   s7   -L6;
                         0     1    0     0;
                         0     0    0     1];
PrDr_1_H_2=[
                        c9  s9  0    0;
                       -s9  c9  0  -L7;
                         0   0  1    0;
                         0   0  0    1];
PrDr_2_H_3=[
                          0     0  -1  0;
                        c11  -s11   0  0;
                       -s11  -c11   0  0;
                          0     0   0  1];
PrDr_3_H_4=[
                       -c13  -s13  0  -L8;
                        s13  -c13  0  -L9;
                          0     0  1    0;
                          0     0  0    1];
PrDr_4_H_5=[
                       -s15   c15  0   L8;
                       -c15  -s15  0  -L9;
                          0     0  1    0;
                          0     0  0    1];
PrDr_5_H_6=[
                          0     0  -1  0;
                        c17  -s17   0  0;
                       -s17  -c17   0  0;
                          0     0   0  1];

PrDr_6_H_7=[            0      -1   0 L10;
                       -1       0   0  0;
                        0       0  -1  0;
                        0       0   0  1];
% 
% %Posiciones de los centros de masa
PrDr_1_r_c1=[0 Lc7y Lc7z].';
PrDr_2_r_c2=[0 -Lc9y Lc9z].';
PrDr_3_r_c3=[-Lc11x 0 0].';
PrDr_4_r_c4=[Lc13x -Lc13y 0].';
PrDr_5_r_c5=[-Lc15x -Lc15y 0].';
PrDr_6_r_c6=[Lc17x 0 Lc17z].';
% 
% %Momentos de Inercia 
PrDr_I_1=[ I7xx    0    0;
               0 I7yy    0;
               0    0 I7zz];
PrDr_I_2=[ I9xx     0  I9xz;
               0  I9yy -I9yz;
            I9xz -I9yz  I9zz];
PrDr_I_3=[ I11xx I11xy     0;
            I11xy I11yy     0;
                0     0 I11zz];
PrDr_I_4=[ I13xx     0     0;
                0 I13yy     0;
                0     0 I13zz];
PrDr_I_5=[ I15xx  I15xy I15xz;
            I15xy  I15yy     0;
            I15xz      0 I15zz];
PrDr_I_6=[ I17xx     0     0;
                0 I17yy     0;
                0     0 I17zz]; 

W_R_PrDr1=W_R_B*PrDr_0_H_1(1:3,1:3);
W_R_PrDr2=W_R_PrDr1*PrDr_1_H_2(1:3,1:3);
W_R_PrDr3=W_R_PrDr2*PrDr_2_H_3(1:3,1:3);
W_R_PrDr4=W_R_PrDr3*PrDr_3_H_4(1:3,1:3);
W_R_PrDr5=W_R_PrDr4*PrDr_4_H_5(1:3,1:3);
W_R_PrDr6=W_R_PrDr5*PrDr_5_H_6(1:3,1:3);

M_PrDr_JsAng=Js_PrDr.Jw_PrDr_1.'*W_R_PrDr1*PrDr_I_1*W_R_PrDr1'*Js_PrDr.Jw_PrDr_1;
M_PrDr_JsAng=M_PrDr_JsAng+Js_PrDr.Jw_PrDr_2.'*W_R_PrDr2*PrDr_I_2*W_R_PrDr2'*Js_PrDr.Jw_PrDr_2;
M_PrDr_JsAng=M_PrDr_JsAng+Js_PrDr.Jw_PrDr_3.'*W_R_PrDr3*PrDr_I_3*W_R_PrDr3'*Js_PrDr.Jw_PrDr_3;
M_PrDr_JsAng=M_PrDr_JsAng+Js_PrDr.Jw_PrDr_4.'*W_R_PrDr4*PrDr_I_4*W_R_PrDr4'*Js_PrDr.Jw_PrDr_4;
M_PrDr_JsAng=M_PrDr_JsAng+Js_PrDr.Jw_PrDr_5.'*W_R_PrDr5*PrDr_I_5*W_R_PrDr5'*Js_PrDr.Jw_PrDr_5;
M_PrDr_JsAng=M_PrDr_JsAng+Js_PrDr.Jw_PrDr_6.'*W_R_PrDr6*PrDr_I_6*W_R_PrDr6'*Js_PrDr.Jw_PrDr_6;

M_PrDr_Lag=M_PrDr_JsAng+m7*Js_PrDr.J_PrDr_c1.'*Js_PrDr.J_PrDr_c1;
%M_PrDr_Lag=m7*Js_PrDr.J_PrDr_c1.'*Js_PrDr.J_PrDr_c1;
M_PrDr_Lag=M_PrDr_Lag+m9*Js_PrDr.J_PrDr_c2.'*Js_PrDr.J_PrDr_c2;
M_PrDr_Lag=M_PrDr_Lag+m11*Js_PrDr.J_PrDr_c3.'*Js_PrDr.J_PrDr_c3;
M_PrDr_Lag=M_PrDr_Lag+m13*Js_PrDr.J_PrDr_c4.'*Js_PrDr.J_PrDr_c4;
M_PrDr_Lag=M_PrDr_Lag+m15*Js_PrDr.J_PrDr_c5.'*Js_PrDr.J_PrDr_c5;
M_PrDr_Lag=M_PrDr_Lag+m17*Js_PrDr.J_PrDr_c6.'*Js_PrDr.J_PrDr_c6;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%Pierna Izquierda
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s8=sin(th8);
c8=cos(th8);
s10=sin(th10);
c10=cos(th10);
s12=sin(th12);
c12=cos(th12);
s14=sin(th14);
c14=cos(th14);
s16=sin(th16);
c16=cos(th16);
s18=sin(th18);
c18=cos(th18);

PrIz_0_H_1=[
                       -s8     0  -c8     0;
                       -c8     0   s8    L6;
                         0     1    0     0;
                         0     0    0     1];
PrIz_1_H_2=[
                        c10  s10  0    0;
                       -s10  c10  0  -L7;
                          0    0  1    0;
                          0    0  0    1];
PrIz_2_H_3=[
                          0     0   1  0;
                        c12  -s12   0  0;
                        s12   c12   0  0;
                          0     0   0  1];
PrIz_3_H_4=[
                        c14   s14  0  -L8;
                       -s14   c14  0   L9;
                          0     0  1    0;
                          0     0  0    1];
PrIz_4_H_5=[
                        s16  -c16  0  -L8;
                        c16   s16  0  -L9;
                          0     0  1    0;
                          0     0  0    1];
PrIz_5_H_6=[                        
                          0     0   1  0;
                        c18  -s18   0  0;
                        s18   c18   0  0;
                          0     0   0  1];

PrIz_6_H_7=[
                          0    -1   0  L10;
                         -1     0   0    0;
                          0     0  -1    0;
                          0     0   0    1];
% %Posiciones de los centros de masa
PrIz_1_r_c1=[0 -Lc7y Lc7z].';
PrIz_2_r_c2=[ 0 -Lc9y Lc9z].';
PrIz_3_r_c3=[-Lc11x 0 0].';
PrIz_4_r_c4=[ Lc13x -Lc13y 0].';
PrIz_5_r_c5=[ Lc15x -Lc15y 0].';
PrIz_6_r_c6=[ Lc17x  0  Lc17z].';
% 
% %Momentos de Inercia 
PrIz_I_1=[ I7xx    0    0;
               0 I7yy    0;
               0    0 I7zz];
PrIz_I_2=[  I9xx -I9xz  -I9yz;
            -I9xz  I9yy      0;
            -I9yz     0   I9zz];
PrIz_I_3=[  I11xx  -I11xy     0;
            -I11xy   I11yy     0;
                 0       0 I11zz];
PrIz_I_4=[ I13xx     0      0;
                0 I13yy      0;
                0     0 I13zz];
PrIz_I_5=[  I15xx -I15xy -I15xz;
            -I15xy  I15yy      0;
            -I15xz      0  I15zz];
PrIz_I_6=[ I17xx     0     0;
                0 I17yy     0;
                0     0 I17zz];

W_R_PrIz1=W_R_B*PrIz_0_H_1(1:3,1:3);
W_R_PrIz2=W_R_PrIz1*PrIz_1_H_2(1:3,1:3);
W_R_PrIz3=W_R_PrIz2*PrIz_2_H_3(1:3,1:3);
W_R_PrIz4=W_R_PrIz3*PrIz_3_H_4(1:3,1:3);
W_R_PrIz5=W_R_PrIz4*PrIz_4_H_5(1:3,1:3);
W_R_PrIz6=W_R_PrIz5*PrIz_5_H_6(1:3,1:3);

M_PrIz_JsAng=             Js_PrIz.Jw_PrIz_1.'*W_R_PrIz1*PrIz_I_1*W_R_PrIz1'*Js_PrIz.Jw_PrIz_1;
M_PrIz_JsAng=M_PrIz_JsAng+Js_PrIz.Jw_PrIz_2.'*W_R_PrIz2*PrIz_I_2*W_R_PrIz2'*Js_PrIz.Jw_PrIz_2;
M_PrIz_JsAng=M_PrIz_JsAng+Js_PrIz.Jw_PrIz_3.'*W_R_PrIz3*PrIz_I_3*W_R_PrIz3'*Js_PrIz.Jw_PrIz_3;
M_PrIz_JsAng=M_PrIz_JsAng+Js_PrIz.Jw_PrIz_4.'*W_R_PrIz4*PrIz_I_4*W_R_PrIz4'*Js_PrIz.Jw_PrIz_4;
M_PrIz_JsAng=M_PrIz_JsAng+Js_PrIz.Jw_PrIz_5.'*W_R_PrIz5*PrIz_I_5*W_R_PrIz5'*Js_PrIz.Jw_PrIz_5;
M_PrIz_JsAng=M_PrIz_JsAng+Js_PrIz.Jw_PrIz_6.'*W_R_PrIz6*PrIz_I_6*W_R_PrIz6'*Js_PrIz.Jw_PrIz_6;

M_PrIz_Lag=M_PrIz_JsAng+m7*Js_PrIz.J_PrIz_c1.'*Js_PrIz.J_PrIz_c1;
%M_PrIz_Lag=m7*Js_PrIz.J_PrIz_c1.'*Js_PrIz.J_PrIz_c1;
M_PrIz_Lag=M_PrIz_Lag  +m9*Js_PrIz.J_PrIz_c2.'*Js_PrIz.J_PrIz_c2;
M_PrIz_Lag=M_PrIz_Lag  +m11*Js_PrIz.J_PrIz_c3.'*Js_PrIz.J_PrIz_c3;
M_PrIz_Lag=M_PrIz_Lag  +m13*Js_PrIz.J_PrIz_c4.'*Js_PrIz.J_PrIz_c4;
M_PrIz_Lag=M_PrIz_Lag  +m15*Js_PrIz.J_PrIz_c5.'*Js_PrIz.J_PrIz_c5;
M_PrIz_Lag=M_PrIz_Lag  +m17*Js_PrIz.J_PrIz_c6.'*Js_PrIz.J_PrIz_c6;

M=zeros(24,24);

M(1:6,1:6)=M_BrDr_Lag(1:6,1:6)+M_BrIz_Lag(1:6,1:6)+M_PrDr_Lag(1:6,1:6)+M_PrIz_Lag(1:6,1:6);
M(1:6,7:9)=M_BrDr_Lag(1:6,7:9);
M(1:6,10:12)=M_BrIz_Lag(1:6,7:9);
M(1:6,13:18)=M_PrDr_Lag(1:6,7:12);
M(1:6,19:24)=M_PrIz_Lag(1:6,7:12);

M(7:9,1:9)=M_BrDr_Lag(7:9,1:9);
M(7:9,10:24)=zeros(3,15);

M(10:12,1:6)=M_BrIz_Lag(7:9,1:6);
M(10:12,7:9)=zeros(3,3);
M(10:12,10:12)=M_BrIz_Lag(7:9,7:9);
M(10:12,13:24)=zeros(3,12);

M(13:18,1:6)=M_PrDr_Lag(7:12,1:6);
M(13:18,7:12)=zeros(6,6);
M(13:18,13:18)=M_PrDr_Lag(7:12,7:12);
M(13:18,19:24)=zeros(6,6);

M(19:24,1:6)=M_PrIz_Lag(7:12,1:6);
M(19:24,7:18)=zeros(6,12);
M(19:24,19:24)=M_PrIz_Lag(7:12,7:12);
