function M=test_M(q_B_actual,dq_B_actual,th_actual,dth_actual)

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
%                      
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

BrDr_1_H_3=BrDr_1_H_2*BrDr_2_H_3;
%BrDr_1_r_c1
BrDr_1_r_c2=BrDr_1_H_2(1:3,4)+BrDr_1_H_2(1:3,1:3)*BrDr_2_r_c2;
BrDr_1_r_c3=BrDr_1_H_3(1:3,4)+BrDr_1_H_3(1:3,1:3)*BrDr_3_r_c3;

BrDr_2_r_c3=BrDr_2_H_3(1:3,4)+BrDr_2_H_3(1:3,1:3)*BrDr_3_r_c3;

W_R_BrDr1=W_R_B*BrDr_0_H_1(1:3,1:3);
W_R_BrDr2=W_R_BrDr1*BrDr_1_H_2(1:3,1:3);
W_R_BrDr3=W_R_BrDr2*BrDr_2_H_3(1:3,1:3);

BrDr_1_J_c1=W_R_BrDr1.'*Js_BrDr.J_BrDr_c1;
BrDr_1_J_c2=W_R_BrDr1.'*Js_BrDr.J_BrDr_c2;
BrDr_1_J_c3=W_R_BrDr1.'*Js_BrDr.J_BrDr_c3;

BrDr_2_J_c2=W_R_BrDr2.'*Js_BrDr.J_BrDr_c2;
BrDr_2_J_c3=W_R_BrDr2.'*Js_BrDr.J_BrDr_c3;

BrDr_3_J_c3=W_R_BrDr3.'*Js_BrDr.J_BrDr_c3;

BrDr_1_Jw_1=W_R_BrDr1.'*Js_BrDr.Jw_BrDr_1;
BrDr_2_Jw_2=W_R_BrDr2.'*Js_BrDr.Jw_BrDr_2;
BrDr_3_Jw_3=W_R_BrDr3.'*Js_BrDr.Jw_BrDr_3;

BrDr_1_dJ_c1=W_R_BrDr1.'*Js_BrDr.dJ_BrDr_c1;
BrDr_2_dJ_c2=W_R_BrDr2.'*Js_BrDr.dJ_BrDr_c2;
BrDr_3_dJ_c3=W_R_BrDr3.'*Js_BrDr.dJ_BrDr_c3;

BrDr_1_dJw_1=W_R_BrDr1.'*Js_BrDr.dJw_BrDr_1;
BrDr_2_dJw_2=W_R_BrDr2.'*Js_BrDr.dJw_BrDr_2;
BrDr_3_dJw_3=W_R_BrDr3.'*Js_BrDr.dJw_BrDr_3;

BrDr_M_1=BrDr_I_1*BrDr_1_Jw_1+BrDr_1_H_2(1:3,1:3)*BrDr_I_2*BrDr_2_Jw_2+BrDr_1_H_3(1:3,1:3)*BrDr_I_3*BrDr_3_Jw_3+...
            m1*mat_S(BrDr_1_r_c1)*BrDr_1_J_c1+m3*mat_S(BrDr_1_r_c2)*BrDr_1_J_c2+m5*mat_S(BrDr_1_r_c3)*BrDr_1_J_c3;
BrDr_M_2=BrDr_I_2*BrDr_2_Jw_2+BrDr_2_H_3(1:3,1:3)*BrDr_I_3*BrDr_3_Jw_3+...
         m3*mat_S(BrDr_2_r_c2)*BrDr_2_J_c2+m5*mat_S(BrDr_2_r_c3)*BrDr_2_J_c3;
BrDr_M_3=BrDr_I_3*BrDr_3_Jw_3+...
         m5*mat_S(BrDr_3_r_c3)*BrDr_3_J_c3;
% Ejes_BrDr = [    0 -1  0; 
%                 -1  0  0;
%                  0  0 -1];
Ejes_BrDr = [    0  0  0; 
                 0  0  0;
                 1 -1 -1];
             
M_BrDr(1,:)=(BrDr_M_1.'*Ejes_BrDr(:,1)).';
M_BrDr(2,:)=(BrDr_M_2.'*Ejes_BrDr(:,2)).';
M_BrDr(3,:)=(BrDr_M_3.'*Ejes_BrDr(:,3)).';

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

BrIz_1_H_3=BrIz_1_H_2*BrIz_2_H_3;
%BrDr_1_r_c1
BrIz_1_r_c2=BrIz_1_H_2(1:3,4)+BrIz_1_H_2(1:3,1:3)*BrIz_2_r_c2;
BrIz_1_r_c3=BrIz_1_H_3(1:3,4)+BrIz_1_H_3(1:3,1:3)*BrIz_3_r_c3;

BrIz_2_r_c3=BrIz_2_H_3(1:3,4)+BrIz_2_H_3(1:3,1:3)*BrIz_3_r_c3;

W_R_BrIz1=W_R_B*BrIz_0_H_1(1:3,1:3);
W_R_BrIz2=W_R_BrIz1*BrIz_1_H_2(1:3,1:3);
W_R_BrIz3=W_R_BrIz2*BrIz_2_H_3(1:3,1:3);

BrIz_1_J_c1=W_R_BrIz1.'*Js_BrIz.J_BrIz_c1;
BrIz_1_J_c2=W_R_BrIz1.'*Js_BrIz.J_BrIz_c2;
BrIz_1_J_c3=W_R_BrIz1.'*Js_BrIz.J_BrIz_c3;

BrIz_2_J_c2=W_R_BrIz2.'*Js_BrIz.J_BrIz_c2;
BrIz_2_J_c3=W_R_BrIz2.'*Js_BrIz.J_BrIz_c3;

BrIz_3_J_c3=W_R_BrIz3.'*Js_BrIz.J_BrIz_c3;

BrIz_1_Jw_1=W_R_BrIz1.'*Js_BrIz.Jw_BrIz_1;
BrIz_2_Jw_2=W_R_BrIz2.'*Js_BrIz.Jw_BrIz_2;
BrIz_3_Jw_3=W_R_BrIz3.'*Js_BrIz.Jw_BrIz_3;

BrIz_1_dJ_c1=W_R_BrIz1.'*Js_BrIz.dJ_BrIz_c1;
BrIz_2_dJ_c2=W_R_BrIz2.'*Js_BrIz.dJ_BrIz_c2;
BrIz_3_dJ_c3=W_R_BrIz3.'*Js_BrIz.dJ_BrIz_c3;

BrIz_1_dJw_1=W_R_BrIz1.'*Js_BrIz.dJw_BrIz_1;
BrIz_2_dJw_2=W_R_BrIz2.'*Js_BrIz.dJw_BrIz_2;
BrIz_3_dJw_3=W_R_BrIz3.'*Js_BrIz.dJw_BrIz_3;            
            
BrIz_M_1=BrIz_I_1*BrIz_1_Jw_1+BrIz_1_H_2(1:3,1:3)*BrIz_I_2*BrIz_2_Jw_2+BrIz_1_H_3(1:3,1:3)*BrIz_I_3*BrIz_3_Jw_3+...
            m1*mat_S(BrIz_1_r_c1)*BrIz_1_J_c1+m3*mat_S(BrIz_1_r_c2)*BrIz_1_J_c2+m5*mat_S(BrIz_1_r_c3)*BrIz_1_J_c3;
BrIz_M_2=BrIz_I_2*BrIz_2_Jw_2+BrIz_2_H_3(1:3,1:3)*BrIz_I_3*BrIz_3_Jw_3+...
         m3*mat_S(BrIz_2_r_c2)*BrIz_2_J_c2+m5*mat_S(BrIz_2_r_c3)*BrIz_2_J_c3;
BrIz_M_3=BrIz_I_3*BrIz_3_Jw_3+...
         m5*mat_S(BrIz_3_r_c3)*BrIz_3_J_c3;
    
Ejes_BrIz = [    0  0  0; 
                 0  0  0;
                 1 -1 -1];
M_BrIz(1,:)=(BrIz_M_1.'*Ejes_BrIz(:,1)).';
M_BrIz(2,:)=(BrIz_M_2.'*Ejes_BrIz(:,2)).';
M_BrIz(3,:)=(BrIz_M_3.'*Ejes_BrIz(:,3)).';

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
            
PrDr_1_H_3=PrDr_1_H_2*PrDr_2_H_3;
PrDr_1_H_4=PrDr_1_H_3*PrDr_3_H_4;
PrDr_1_H_5=PrDr_1_H_4*PrDr_4_H_5;
PrDr_1_H_6=PrDr_1_H_5*PrDr_5_H_6;

PrDr_2_H_4=PrDr_2_H_3*PrDr_3_H_4;
PrDr_2_H_5=PrDr_2_H_4*PrDr_4_H_5;
PrDr_2_H_6=PrDr_2_H_5*PrDr_5_H_6;

PrDr_3_H_5=PrDr_3_H_4*PrDr_4_H_5;
PrDr_3_H_6=PrDr_3_H_5*PrDr_5_H_6;

PrDr_4_H_6=PrDr_4_H_5*PrDr_5_H_6;

%PrDr_1_r_c1
PrDr_1_r_c2=PrDr_1_H_2(1:3,4)+PrDr_1_H_2(1:3,1:3)*PrDr_2_r_c2;
PrDr_1_r_c3=PrDr_1_H_3(1:3,4)+PrDr_1_H_3(1:3,1:3)*PrDr_3_r_c3;
PrDr_1_r_c4=PrDr_1_H_4(1:3,4)+PrDr_1_H_4(1:3,1:3)*PrDr_4_r_c4;
PrDr_1_r_c5=PrDr_1_H_5(1:3,4)+PrDr_1_H_5(1:3,1:3)*PrDr_5_r_c5;
PrDr_1_r_c6=PrDr_1_H_6(1:3,4)+PrDr_1_H_6(1:3,1:3)*PrDr_6_r_c6;

PrDr_2_r_c3=PrDr_2_H_3(1:3,4)+PrDr_2_H_3(1:3,1:3)*PrDr_3_r_c3;
PrDr_2_r_c4=PrDr_2_H_4(1:3,4)+PrDr_2_H_4(1:3,1:3)*PrDr_4_r_c4;
PrDr_2_r_c5=PrDr_2_H_5(1:3,4)+PrDr_2_H_5(1:3,1:3)*PrDr_5_r_c5;
PrDr_2_r_c6=PrDr_2_H_6(1:3,4)+PrDr_2_H_6(1:3,1:3)*PrDr_6_r_c6;

PrDr_3_r_c4=PrDr_3_H_4(1:3,4)+PrDr_3_H_4(1:3,1:3)*PrDr_4_r_c4;
PrDr_3_r_c5=PrDr_3_H_5(1:3,4)+PrDr_3_H_5(1:3,1:3)*PrDr_5_r_c5;
PrDr_3_r_c6=PrDr_3_H_6(1:3,4)+PrDr_3_H_6(1:3,1:3)*PrDr_6_r_c6;

PrDr_4_r_c5=PrDr_4_H_5(1:3,4)+PrDr_4_H_5(1:3,1:3)*PrDr_5_r_c5;
PrDr_4_r_c6=PrDr_4_H_6(1:3,4)+PrDr_4_H_6(1:3,1:3)*PrDr_6_r_c6;

PrDr_5_r_c6=PrDr_5_H_6(1:3,4)+PrDr_5_H_6(1:3,1:3)*PrDr_6_r_c6;

W_R_PrDr1=W_R_B*PrDr_0_H_1(1:3,1:3);
W_R_PrDr2=W_R_PrDr1*PrDr_1_H_2(1:3,1:3);
W_R_PrDr3=W_R_PrDr2*PrDr_2_H_3(1:3,1:3);
W_R_PrDr4=W_R_PrDr3*PrDr_3_H_4(1:3,1:3);
W_R_PrDr5=W_R_PrDr4*PrDr_4_H_5(1:3,1:3);
W_R_PrDr6=W_R_PrDr5*PrDr_5_H_6(1:3,1:3);

PrDr_1_J_c1=W_R_PrDr1.'*Js_PrDr.J_PrDr_c1;
PrDr_1_J_c2=W_R_PrDr1.'*Js_PrDr.J_PrDr_c2;
PrDr_1_J_c3=W_R_PrDr1.'*Js_PrDr.J_PrDr_c3;
PrDr_1_J_c4=W_R_PrDr1.'*Js_PrDr.J_PrDr_c4;
PrDr_1_J_c5=W_R_PrDr1.'*Js_PrDr.J_PrDr_c5;
PrDr_1_J_c6=W_R_PrDr1.'*Js_PrDr.J_PrDr_c6;

PrDr_2_J_c2=W_R_PrDr2.'*Js_PrDr.J_PrDr_c2;
PrDr_2_J_c3=W_R_PrDr2.'*Js_PrDr.J_PrDr_c3;
PrDr_2_J_c4=W_R_PrDr2.'*Js_PrDr.J_PrDr_c4;
PrDr_2_J_c5=W_R_PrDr2.'*Js_PrDr.J_PrDr_c5;
PrDr_2_J_c6=W_R_PrDr2.'*Js_PrDr.J_PrDr_c6;

PrDr_3_J_c3=W_R_PrDr3.'*Js_PrDr.J_PrDr_c3;
PrDr_3_J_c4=W_R_PrDr3.'*Js_PrDr.J_PrDr_c4;
PrDr_3_J_c5=W_R_PrDr3.'*Js_PrDr.J_PrDr_c5;
PrDr_3_J_c6=W_R_PrDr3.'*Js_PrDr.J_PrDr_c6;

PrDr_4_J_c4=W_R_PrDr4.'*Js_PrDr.J_PrDr_c4;
PrDr_4_J_c5=W_R_PrDr4.'*Js_PrDr.J_PrDr_c5;
PrDr_4_J_c6=W_R_PrDr4.'*Js_PrDr.J_PrDr_c6;

PrDr_5_J_c5=W_R_PrDr5.'*Js_PrDr.J_PrDr_c5;
PrDr_5_J_c6=W_R_PrDr5.'*Js_PrDr.J_PrDr_c6;

PrDr_6_J_c6=W_R_PrDr6.'*Js_PrDr.J_PrDr_c6;

PrDr_1_Jw_1=W_R_PrDr1.'*Js_PrDr.Jw_PrDr_1;
PrDr_2_Jw_2=W_R_PrDr2.'*Js_PrDr.Jw_PrDr_2;
PrDr_3_Jw_3=W_R_PrDr3.'*Js_PrDr.Jw_PrDr_3;
PrDr_4_Jw_4=W_R_PrDr4.'*Js_PrDr.Jw_PrDr_4;
PrDr_5_Jw_5=W_R_PrDr5.'*Js_PrDr.Jw_PrDr_5;
PrDr_6_Jw_6=W_R_PrDr6.'*Js_PrDr.Jw_PrDr_6;

PrDr_1_dJ_c1=W_R_PrDr1.'*Js_PrDr.dJ_PrDr_c1;
PrDr_2_dJ_c2=W_R_PrDr2.'*Js_PrDr.dJ_PrDr_c2;
PrDr_3_dJ_c3=W_R_PrDr3.'*Js_PrDr.dJ_PrDr_c3;

PrDr_1_dJw_1=W_R_PrDr1.'*Js_PrDr.dJw_PrDr_1;
PrDr_2_dJw_2=W_R_PrDr2.'*Js_PrDr.dJw_PrDr_2;
PrDr_3_dJw_3=W_R_PrDr3.'*Js_PrDr.dJw_PrDr_3;

PrDr_M_1=   PrDr_I_1*PrDr_1_Jw_1+PrDr_1_H_2(1:3,1:3)*PrDr_I_2*PrDr_2_Jw_2+PrDr_1_H_3(1:3,1:3)*PrDr_I_3*PrDr_3_Jw_3+...
            PrDr_1_H_4(1:3,1:3)*PrDr_I_4*PrDr_4_Jw_4+PrDr_1_H_5(1:3,1:3)*PrDr_I_5*PrDr_5_Jw_5+PrDr_1_H_6(1:3,1:3)*PrDr_I_6*PrDr_6_Jw_6+...
            m7*mat_S(PrDr_1_r_c1)*PrDr_1_J_c1+m9*mat_S(PrDr_1_r_c2)*PrDr_1_J_c2+m11*mat_S(PrDr_1_r_c3)*PrDr_1_J_c3+...
            m13*mat_S(PrDr_1_r_c4)*PrDr_1_J_c4+m15*mat_S(PrDr_1_r_c5)*PrDr_1_J_c5+m17*mat_S(PrDr_1_r_c6)*PrDr_1_J_c6;

PrDr_M_2=   PrDr_I_2*PrDr_2_Jw_2+PrDr_2_H_3(1:3,1:3)*PrDr_I_3*PrDr_3_Jw_3+...
            PrDr_2_H_4(1:3,1:3)*PrDr_I_4*PrDr_4_Jw_4+PrDr_2_H_5(1:3,1:3)*PrDr_I_5*PrDr_5_Jw_5+PrDr_2_H_6(1:3,1:3)*PrDr_I_6*PrDr_6_Jw_6+...
            m9*mat_S(PrDr_2_r_c2)*PrDr_2_J_c2+m11*mat_S(PrDr_2_r_c3)*PrDr_2_J_c3+...
            m13*mat_S(PrDr_2_r_c4)*PrDr_2_J_c4+m15*mat_S(PrDr_2_r_c5)*PrDr_2_J_c5+m17*mat_S(PrDr_2_r_c6)*PrDr_2_J_c6;
            
PrDr_M_3=PrDr_I_3*PrDr_3_Jw_3+...
          PrDr_3_H_4(1:3,1:3)*PrDr_I_4*PrDr_4_Jw_4+PrDr_3_H_5(1:3,1:3)*PrDr_I_5*PrDr_5_Jw_5+PrDr_3_H_6(1:3,1:3)*PrDr_I_6*PrDr_6_Jw_6+...
          m11*mat_S(PrDr_3_r_c3)*PrDr_3_J_c3+...
          m13*mat_S(PrDr_3_r_c4)*PrDr_3_J_c4+m15*mat_S(PrDr_3_r_c5)*PrDr_3_J_c5+m17*mat_S(PrDr_3_r_c6)*PrDr_3_J_c6;
            
PrDr_M_4=PrDr_I_4*PrDr_4_Jw_4+PrDr_4_H_5(1:3,1:3)*PrDr_I_5*PrDr_5_Jw_5+PrDr_4_H_6(1:3,1:3)*PrDr_I_6*PrDr_6_Jw_6+...
           m13*mat_S(PrDr_4_r_c4)*PrDr_4_J_c4+m15*mat_S(PrDr_4_r_c5)*PrDr_4_J_c5+m17*mat_S(PrDr_4_r_c6)*PrDr_4_J_c6;

PrDr_M_5=PrDr_I_5*PrDr_5_Jw_5+PrDr_5_H_6(1:3,1:3)*PrDr_I_6*PrDr_6_Jw_6+...
          m15*mat_S(PrDr_5_r_c5)*PrDr_5_J_c5+m17*mat_S(PrDr_5_r_c6)*PrDr_5_J_c6;

PrDr_M_6=PrDr_I_6*PrDr_6_Jw_6+...
         m17*mat_S(PrDr_6_r_c6)*PrDr_6_J_c6;


% Ejes_PrDr = [ 0  0 -1  0   0  -1;
%               0  0  0  0   0   0;
%              -1 -1  0 -1  -1   0];

Ejes_PrDr = [  0   0  0  0   0   0;
              -1   0  0  0   0   0;
               0  -1  1 -1  -1   1];
         
M_PrDr(1,:)=(PrDr_M_1.'*Ejes_PrDr(:,1)).';
M_PrDr(2,:)=(PrDr_M_2.'*Ejes_PrDr(:,2)).';
M_PrDr(3,:)=(PrDr_M_3.'*Ejes_PrDr(:,3)).';
M_PrDr(4,:)=(PrDr_M_4.'*Ejes_PrDr(:,4)).';
M_PrDr(5,:)=(PrDr_M_5.'*Ejes_PrDr(:,5)).';
M_PrDr(6,:)=(PrDr_M_6.'*Ejes_PrDr(:,6)).';

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

PrIz_1_H_3=PrIz_1_H_2*PrIz_2_H_3;
PrIz_1_H_4=PrIz_1_H_3*PrIz_3_H_4;
PrIz_1_H_5=PrIz_1_H_4*PrIz_4_H_5;
PrIz_1_H_6=PrIz_1_H_5*PrIz_5_H_6;

PrIz_2_H_4=PrIz_2_H_3*PrIz_3_H_4;
PrIz_2_H_5=PrIz_2_H_4*PrIz_4_H_5;
PrIz_2_H_6=PrIz_2_H_5*PrIz_5_H_6;

PrIz_3_H_5=PrIz_3_H_4*PrIz_4_H_5;
PrIz_3_H_6=PrIz_3_H_5*PrIz_5_H_6;

PrIz_4_H_6=PrIz_4_H_5*PrIz_5_H_6;

%PrIz_1_r_c1
PrIz_1_r_c2=PrIz_1_H_2(1:3,4)+PrIz_1_H_2(1:3,1:3)*PrIz_2_r_c2;
PrIz_1_r_c3=PrIz_1_H_3(1:3,4)+PrIz_1_H_3(1:3,1:3)*PrIz_3_r_c3;
PrIz_1_r_c4=PrIz_1_H_4(1:3,4)+PrIz_1_H_4(1:3,1:3)*PrIz_4_r_c4;
PrIz_1_r_c5=PrIz_1_H_5(1:3,4)+PrIz_1_H_5(1:3,1:3)*PrIz_5_r_c5;
PrIz_1_r_c6=PrIz_1_H_6(1:3,4)+PrIz_1_H_6(1:3,1:3)*PrIz_6_r_c6;

PrIz_2_r_c3=PrIz_2_H_3(1:3,4)+PrIz_2_H_3(1:3,1:3)*PrIz_3_r_c3;
PrIz_2_r_c4=PrIz_2_H_4(1:3,4)+PrIz_2_H_4(1:3,1:3)*PrIz_4_r_c4;
PrIz_2_r_c5=PrIz_2_H_5(1:3,4)+PrIz_2_H_5(1:3,1:3)*PrIz_5_r_c5;
PrIz_2_r_c6=PrIz_2_H_6(1:3,4)+PrIz_2_H_6(1:3,1:3)*PrIz_6_r_c6;

PrIz_3_r_c4=PrIz_3_H_4(1:3,4)+PrIz_3_H_4(1:3,1:3)*PrIz_4_r_c4;
PrIz_3_r_c5=PrIz_3_H_5(1:3,4)+PrIz_3_H_5(1:3,1:3)*PrIz_5_r_c5;
PrIz_3_r_c6=PrIz_3_H_6(1:3,4)+PrIz_3_H_6(1:3,1:3)*PrIz_6_r_c6;

PrIz_4_r_c5=PrIz_4_H_5(1:3,4)+PrIz_4_H_5(1:3,1:3)*PrIz_5_r_c5;
PrIz_4_r_c6=PrIz_4_H_6(1:3,4)+PrIz_4_H_6(1:3,1:3)*PrIz_6_r_c6;

PrIz_5_r_c6=PrIz_5_H_6(1:3,4)+PrIz_5_H_6(1:3,1:3)*PrIz_6_r_c6;

W_R_PrIz1=W_R_B*PrIz_0_H_1(1:3,1:3);
W_R_PrIz2=W_R_PrIz1*PrIz_1_H_2(1:3,1:3);
W_R_PrIz3=W_R_PrIz2*PrIz_2_H_3(1:3,1:3);
W_R_PrIz4=W_R_PrIz3*PrIz_3_H_4(1:3,1:3);
W_R_PrIz5=W_R_PrIz4*PrIz_4_H_5(1:3,1:3);
W_R_PrIz6=W_R_PrIz5*PrIz_5_H_6(1:3,1:3);

PrIz_1_J_c1=W_R_PrIz1.'*Js_PrIz.J_PrIz_c1;
PrIz_1_J_c2=W_R_PrIz1.'*Js_PrIz.J_PrIz_c2;
PrIz_1_J_c3=W_R_PrIz1.'*Js_PrIz.J_PrIz_c3;
PrIz_1_J_c4=W_R_PrIz1.'*Js_PrIz.J_PrIz_c4;
PrIz_1_J_c5=W_R_PrIz1.'*Js_PrIz.J_PrIz_c5;
PrIz_1_J_c6=W_R_PrIz1.'*Js_PrIz.J_PrIz_c6;

PrIz_2_J_c2=W_R_PrIz2.'*Js_PrIz.J_PrIz_c2;
PrIz_2_J_c3=W_R_PrIz2.'*Js_PrIz.J_PrIz_c3;
PrIz_2_J_c4=W_R_PrIz2.'*Js_PrIz.J_PrIz_c4;
PrIz_2_J_c5=W_R_PrIz2.'*Js_PrIz.J_PrIz_c5;
PrIz_2_J_c6=W_R_PrIz2.'*Js_PrIz.J_PrIz_c6;

PrIz_3_J_c3=W_R_PrIz3.'*Js_PrIz.J_PrIz_c3;
PrIz_3_J_c4=W_R_PrIz3.'*Js_PrIz.J_PrIz_c4;
PrIz_3_J_c5=W_R_PrIz3.'*Js_PrIz.J_PrIz_c5;
PrIz_3_J_c6=W_R_PrIz3.'*Js_PrIz.J_PrIz_c6;

PrIz_4_J_c4=W_R_PrIz4.'*Js_PrIz.J_PrIz_c4;
PrIz_4_J_c5=W_R_PrIz4.'*Js_PrIz.J_PrIz_c5;
PrIz_4_J_c6=W_R_PrIz4.'*Js_PrIz.J_PrIz_c6;

PrIz_5_J_c5=W_R_PrIz5.'*Js_PrIz.J_PrIz_c5;
PrIz_5_J_c6=W_R_PrIz5.'*Js_PrIz.J_PrIz_c6;

PrIz_6_J_c6=W_R_PrIz6.'*Js_PrIz.J_PrIz_c6;

PrIz_1_Jw_1=W_R_PrIz1.'*Js_PrIz.Jw_PrIz_1;
PrIz_2_Jw_2=W_R_PrIz2.'*Js_PrIz.Jw_PrIz_2;
PrIz_3_Jw_3=W_R_PrIz3.'*Js_PrIz.Jw_PrIz_3;
PrIz_4_Jw_4=W_R_PrIz4.'*Js_PrIz.Jw_PrIz_4;
PrIz_5_Jw_5=W_R_PrIz5.'*Js_PrIz.Jw_PrIz_5;
PrIz_6_Jw_6=W_R_PrIz6.'*Js_PrIz.Jw_PrIz_6;

PrIz_1_dJ_c1=W_R_PrIz1.'*Js_PrIz.dJ_PrIz_c1;
PrIz_2_dJ_c2=W_R_PrIz2.'*Js_PrIz.dJ_PrIz_c2;
PrIz_3_dJ_c3=W_R_PrIz3.'*Js_PrIz.dJ_PrIz_c3;

PrIz_1_dJw_1=W_R_PrIz1.'*Js_PrIz.dJw_PrIz_1;
PrIz_2_dJw_2=W_R_PrIz2.'*Js_PrIz.dJw_PrIz_2;
PrIz_3_dJw_3=W_R_PrIz3.'*Js_PrIz.dJw_PrIz_3;

PrIz_M_1=PrIz_I_1*PrIz_1_Jw_1+PrIz_1_H_2(1:3,1:3)*PrIz_I_2*PrIz_2_Jw_2+PrIz_1_H_3(1:3,1:3)*PrIz_I_3*PrIz_3_Jw_3+...
         PrIz_1_H_4(1:3,1:3)*PrIz_I_4*PrIz_4_Jw_4+PrIz_1_H_5(1:3,1:3)*PrIz_I_5*PrIz_5_Jw_5+PrIz_1_H_6(1:3,1:3)*PrIz_I_6*PrIz_6_Jw_6+...
         m7*mat_S(PrIz_1_r_c1)*PrIz_1_J_c1+m9*mat_S(PrIz_1_r_c2)*PrIz_1_J_c2+m11*mat_S(PrIz_1_r_c3)*PrIz_1_J_c3+...
         m13*mat_S(PrIz_1_r_c4)*PrIz_1_J_c4+m15*mat_S(PrIz_1_r_c5)*PrIz_1_J_c5+m17*mat_S(PrIz_1_r_c6)*PrIz_1_J_c6;
            
PrIz_M_2=PrIz_I_2*PrIz_2_Jw_2+PrIz_2_H_3(1:3,1:3)*PrIz_I_3*PrIz_3_Jw_3+...
         PrIz_2_H_4(1:3,1:3)*PrIz_I_4*PrIz_4_Jw_4+PrIz_2_H_5(1:3,1:3)*PrIz_I_5*PrIz_5_Jw_5+PrIz_2_H_6(1:3,1:3)*PrIz_I_6*PrIz_6_Jw_6+...
          m9*mat_S(PrIz_2_r_c2)*PrIz_2_J_c2+m11*mat_S(PrIz_2_r_c3)*PrIz_2_J_c3+...
          m13*mat_S(PrIz_2_r_c4)*PrIz_2_J_c4+m15*mat_S(PrIz_2_r_c5)*PrIz_2_J_c5+m17*mat_S(PrIz_2_r_c6)*PrIz_2_J_c6;

PrIz_M_3=PrIz_I_3*PrIz_3_Jw_3+...
         PrIz_3_H_4(1:3,1:3)*PrIz_I_4*PrIz_4_Jw_4+PrIz_3_H_5(1:3,1:3)*PrIz_I_5*PrIz_5_Jw_5+PrIz_3_H_6(1:3,1:3)*PrIz_I_6*PrIz_6_Jw_6+...
            m11*mat_S(PrIz_3_r_c3)*PrIz_3_J_c3+...
            m13*mat_S(PrIz_3_r_c4)*PrIz_3_J_c4+m15*mat_S(PrIz_3_r_c5)*PrIz_3_J_c5+m17*mat_S(PrIz_3_r_c6)*PrIz_3_J_c6;
            
PrIz_M_4=PrIz_I_4*PrIz_4_Jw_4+PrIz_4_H_5(1:3,1:3)*PrIz_I_5*PrIz_5_Jw_5+PrIz_4_H_6(1:3,1:3)*PrIz_I_6*PrIz_6_Jw_6+...
           m13*mat_S(PrIz_4_r_c4)*PrIz_4_J_c4+m15*mat_S(PrIz_4_r_c5)*PrIz_4_J_c5+m17*mat_S(PrIz_4_r_c6)*PrIz_4_J_c6;

PrIz_M_5=PrIz_I_5*PrIz_5_Jw_5+PrIz_5_H_6(1:3,1:3)*PrIz_I_6*PrIz_6_Jw_6+...
           m15*mat_S(PrIz_5_r_c5)*PrIz_5_J_c5+m17*mat_S(PrIz_5_r_c6)*PrIz_5_J_c6;

PrIz_M_6=PrIz_I_6*PrIz_6_Jw_6+...
         m17*mat_S(PrIz_6_r_c6)*PrIz_6_J_c6;
        
% Ejes_PrIz = [ 0  0  1  0   0   1;
%               0  0  0  0   0   0;
%              -1 -1  0 -1  -1   0];

Ejes_PrIz = [  0   0  0  0   0   0;
              -1   0  0  0   0   0;
               0  -1  1 -1  -1   1];
         
M_PrIz(1,:)=(PrIz_M_1.'*Ejes_PrIz(:,1)).';
M_PrIz(2,:)=(PrIz_M_2.'*Ejes_PrIz(:,2)).';
M_PrIz(3,:)=(PrIz_M_3.'*Ejes_PrIz(:,3)).';
M_PrIz(4,:)=(PrIz_M_4.'*Ejes_PrIz(:,4)).';
M_PrIz(5,:)=(PrIz_M_5.'*Ejes_PrIz(:,5)).';
M_PrIz(6,:)=(PrIz_M_6.'*Ejes_PrIz(:,6)).';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%Tronco
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tr_I_0=[I0xx     0   I0xz;
           0  I0yy  -I0yz; 
        I0xz -I0yz   I0zz];
%Posicion del CoM
r_B_c0=[-Lc0x 0 Lc0z].';

r_B_1_BrDr=BrDr_0_H_1(1:3,4);
r_B_1_BrIz=BrIz_0_H_1(1:3,4);
r_B_1_PrDr=PrDr_0_H_1(1:3,4);
r_B_1_PrIz=PrIz_0_H_1(1:3,4);

W_c0_r_1PrIz=W_R_B*(r_B_1_PrIz-r_B_c0);
W_c0_r_c1PrIz=W_R_B*(r_B_1_PrIz-r_B_c0)+W_R_PrIz1*PrIz_1_r_c1;
W_W_r_c1PrIz=q_B_actual(1:3)+W_R_B*(r_B_1_PrIz)+W_R_PrIz1*PrIz_1_r_c1;

BrDr_B_J_c1=Js_BrDr.J_BrDr_c1;
BrDr_B_J_c2=Js_BrDr.J_BrDr_c2;
BrDr_B_J_c3=Js_BrDr.J_BrDr_c3;

BrIz_B_J_c1=W_R_B.'*Js_BrIz.J_BrIz_c1;
BrIz_B_J_c2=W_R_B.'*Js_BrIz.J_BrIz_c2;
BrIz_B_J_c3=W_R_B.'*Js_BrIz.J_BrIz_c3;

PrDr_B_J_c1=W_R_B.'*Js_PrDr.J_PrDr_c1;
PrDr_B_J_c2=W_R_B.'*Js_PrDr.J_PrDr_c2;
PrDr_B_J_c3=W_R_B.'*Js_PrDr.J_PrDr_c3;
PrDr_B_J_c4=W_R_B.'*Js_PrDr.J_PrDr_c4;
PrDr_B_J_c5=W_R_B.'*Js_PrDr.J_PrDr_c5;
PrDr_B_J_c6=W_R_B.'*Js_PrDr.J_PrDr_c6;

PrIz_B_J_c1=W_R_B.'*Js_PrIz.J_PrIz_c1;
PrIz_B_J_c2=W_R_B.'*Js_PrIz.J_PrIz_c2;
PrIz_B_J_c3=W_R_B.'*Js_PrIz.J_PrIz_c3;
PrIz_B_J_c4=W_R_B.'*Js_PrIz.J_PrIz_c4;
PrIz_B_J_c5=W_R_B.'*Js_PrIz.J_PrIz_c5;
PrIz_B_J_c6=W_R_B.'*Js_PrIz.J_PrIz_c6;

M_B_f_qB=   m0*Js_Tr.J_Tr_c0;%+...
M_B_f_qB= M_B_f_qB+m1*Js_BrDr.J_BrDr_c1(:,1:6)+m3*Js_BrDr.J_BrDr_c2(:,1:6)+m5*Js_BrDr.J_BrDr_c3(:,1:6);%+...
M_B_f_qB= M_B_f_qB+m1*Js_BrIz.J_BrIz_c1(:,1:6)+m3*Js_BrIz.J_BrIz_c2(:,1:6)+m5*Js_BrIz.J_BrIz_c3(:,1:6);%   +...
M_B_f_qB= M_B_f_qB+m7*Js_PrDr.J_PrDr_c1(:,1:6)+m9*Js_PrDr.J_PrDr_c2(:,1:6)+m11*Js_PrDr.J_PrDr_c3(:,1:6)+m13*Js_PrDr.J_PrDr_c4(:,1:6)+m15*Js_PrDr.J_PrDr_c5(:,1:6)+m17*Js_PrDr.J_PrDr_c6(:,1:6);
M_B_f_qB= M_B_f_qB+m7*Js_PrIz.J_PrIz_c1(:,1:6)+m9*Js_PrIz.J_PrIz_c2(:,1:6)+m11*Js_PrIz.J_PrIz_c3(:,1:6)+m13*Js_PrIz.J_PrIz_c4(:,1:6)+m15*Js_PrIz.J_PrIz_c5(:,1:6)+m17*Js_PrIz.J_PrIz_c6(:,1:6);

%Parte Angular!!!
%M_B_tau_qB=   m0*Js_Tr.J_Tr_c0;
% M_B_tau_qB= Js_PrDr.Jw_PrDr_1(1:3,4:6).'*W_R_PrDr1*PrDr_I_1*PrDr_1_Jw_1+Js_PrDr.Jw_PrDr_2(1:3,4:6).'*W_R_PrDr2*PrDr_I_2*PrDr_2_Jw_2+Js_PrDr.Jw_PrDr_3(1:3,4:6).'*W_R_PrDr3*PrDr_I_3*PrDr_3_Jw_3+...
%             Js_PrDr.Jw_PrDr_1(1:3,4:6).'*W_R_PrDr4*PrDr_I_4*PrDr_4_Jw_4+Js_PrDr.Jw_PrDr_5(1:3,4:6).'*W_R_PrDr5*PrDr_I_5*PrDr_5_Jw_5+Js_PrDr.Jw_PrDr_6(1:3,4:6).'*W_R_PrDr6*PrDr_I_6*PrDr_6_Jw_6+...
%             Js_PrIz.Jw_PrIz_1(1:3,4:6).'*W_R_PrIz1*PrDr_I_1*PrIz_1_Jw_1+Js_PrIz.Jw_PrIz_2(1:3,4:6).'*W_R_PrIz2*PrIz_I_2*PrIz_2_Jw_2+Js_PrIz.Jw_PrIz_3(1:3,4:6).'*W_R_PrIz3*PrIz_I_3*PrIz_3_Jw_3+...
%             Js_PrIz.Jw_PrIz_4(1:3,4:6).'*W_R_PrIz4*PrDr_I_4*PrIz_4_Jw_4+Js_PrIz.Jw_PrIz_5(1:3,4:6).'*W_R_PrIz5*PrIz_I_5*PrIz_5_Jw_5+Js_PrIz.Jw_PrIz_6(1:3,4:6).'*W_R_PrIz6*PrIz_I_6*PrIz_6_Jw_6;%+...

%Parte Angular Corrected!!!
%M_B_tau_qB=   m0*Js_Tr.J_Tr_c0;
%M_B_tau_qB= W_R_PrDr1*PrDr_I_1*PrDr_1_Jw_1+Js_PrDr.Jw_PrDr_2(1:3,4:6).'*W_R_PrDr2*PrDr_I_2*PrDr_2_Jw_2+Js_PrDr.Jw_PrDr_3(1:3,4:6).'*W_R_PrDr3*PrDr_I_3*PrDr_3_Jw_3+...
%             Js_PrDr.Jw_PrDr_1(1:3,4:6).'*W_R_PrDr4*PrDr_I_4*PrDr_4_Jw_4+Js_PrDr.Jw_PrDr_5(1:3,4:6).'*W_R_PrDr5*PrDr_I_5*PrDr_5_Jw_5+Js_PrDr.Jw_PrDr_6(1:3,4:6).'*W_R_PrDr6*PrDr_I_6*PrDr_6_Jw_6+...
%M_B_tau_qB=              W_R_PrIz1*PrDr_I_1*PrIz_1_Jw_1;%+Js_PrIz.Jw_PrIz_2(1:3,4:6).'*W_R_PrIz2*PrIz_I_2*PrIz_2_Jw_2+Js_PrIz.Jw_PrIz_3(1:3,4:6).'*W_R_PrIz3*PrIz_I_3*PrIz_3_Jw_3+...
%             Js_PrIz.Jw_PrIz_4(1:3,4:6).'*W_R_PrIz4*PrDr_I_4*PrIz_4_Jw_4+Js_PrIz.Jw_PrIz_5(1:3,4:6).'*W_R_PrIz5*PrIz_I_5*PrIz_5_Jw_5+Js_PrIz.Jw_PrIz_6(1:3,4:6).'*W_R_PrIz6*PrIz_I_6*PrIz_6_Jw_6;%+...

%Parte Linear!!!
%M_B_tau_qB=           m7*mat_S(W_c0_r_c1PrIz)*Js_PrIz.J_PrIz_c1;%;+m9*mat_S(PrIz_c0_r_c2)*PrIz_W_J_c2+m11*mat_S(PrIz_c0_r_c3)*PrIz_W_J_c3+...
%             m13*mat_S(PrIz_1_r_c4)*PrIz_1_J_c4+m15*mat_S(PrIz_1_r_c5)*PrIz_1_J_c5+m17*mat_S(PrIz_1_r_c6)*PrIz_1_J_c6
%M_B_f_thBrDr= m1*Js_BrDr.J_BrDr_c1(:,7:9)+m3*Js_BrDr.J_BrDr_c2(:,7:9)+m5*Js_BrDr.J_BrDr_c3(:,7:9)%+...
%M_B_f_thBrIz= m1*Js_BrIz.J_BrIz_c1(:,7:9)+m3*Js_BrIz.J_BrIz_c2(:,7:9)+m5*Js_BrIz.J_BrIz_c3(:,7:9)
%M_B_f_thPrDr= m7*Js_PrDr.J_PrDr_c1(:,7:12)+m9*Js_PrDr.J_PrDr_c2(:,7:12)+m11*Js_PrDr.J_PrDr_c3(:,7:12)+m13*Js_PrDr.J_PrDr_c4(:,7:12)+m15*Js_PrDr.J_PrDr_c5(:,7:12)+m17*Js_PrDr.J_PrDr_c6(:,7:12)
%M_B_f_thPrIz= m7*Js_PrIz.J_PrIz_c1(:,7:12)+m9*Js_PrIz.J_PrIz_c2(:,7:12)+m11*Js_PrIz.J_PrIz_c3(:,7:12)+m13*Js_PrIz.J_PrIz_c4(:,7:12)+m15*Js_PrIz.J_PrIz_c5(:,7:12)+m17*Js_PrIz.J_PrIz_c6(:,7:12)


M=zeros(24);

M(7:9,1:9)=M_BrDr;
M(10:12,1:6)=M_BrIz(:,1:6);
M(10:12,10:12)=M_BrIz(:,7:9);
M(13:18,1:6)=M_PrDr(:,1:6);
M(13:18,13:18)=M_PrDr(:,7:12);
M(19:24,1:6)=M_PrIz(:,1:6);
M(19:24,19:24)=M_PrIz(:,7:12);

function S=mat_S(r)
S=[    0 -r(3)  r(2);
    r(3)     0 -r(1);
   -r(2)  r(1)     0];