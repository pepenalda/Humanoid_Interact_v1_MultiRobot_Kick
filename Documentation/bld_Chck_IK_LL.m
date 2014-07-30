function bld_Chck_IK_LL(th)

syms th_18 th_16 th_14 th_12 th_10 th_8

syms L5 L6 L7 L8

w_R_RF=eye(3);
w_p_RF=[0 -38.5/10 0].';
row4=[0 0 0 1];

w_T_RF=[w_R_RF w_p_RF; row4];

L5=38.5/10;
L6=31/10;
L7=75/10;
L8=14.5/10;
k=sqrt(2)/2;

%%Pierna derecha
pi_12a_12=inv([0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1]);

pi_12_11=inv([0 -1 0 29.5/10; -1 0 0 0; 0 0 -1 0; 0 0 0 1]);

pi_11_10 = inv([ cos(th_18)  -sin(th_18) 0    0;
             sin(th_18)  cos(th_18) 0    0;
                  0         0    1    0;
                  0         0    0    1]);

pi_10_09=inv([0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1]);

pi_09_08 =inv([ cos(th_16)   sin(th_16) 0    0;
            -sin(th_16)  cos(th_16) 0    0;
                  0         0    1    0;
                  0         0    0    1]);
              
pi_08_07 =inv([0 -1 0 -L7; 1 0 0 -L8; 0 0 1 0; 0 0 0 1]);

pi_07_06 = inv([ cos(th_14)  sin(th_14) 0    0;
            -sin(th_14)  cos(th_14) 0    0;
                  0         0    1    0;
                  0         0    0    1]);
pi_06_05a = inv([1 0 0 0; 0 1 0 L8; 0 0 1 0; 0 0 0 1]);

pi_05a_05 = inv([1 0 0 -L7; 0 1 0 0; 0 0 1 0; 0 0 0 1]);

pi_05_04 = inv([cos(th_12) -sin(th_12) 0    0;
            sin(th_12)  cos(th_12) 0    0;
                  0         0    1    0;
                  0         0    0    1]); 
              
pi_04_03=inv([0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1]);

pi_03_02 = inv([ cos(th_10)  sin(th_10) 0    0;
            -sin(th_10)  cos(th_10) 0    0;
                  0         0  1    0;
                  0         0  0    1]);

pi_02_01=  inv([-k 0 -k 0; k 0 -k 0; 0 -1 0 L6; 0 0 0 1]);

pi_01_00 = inv([cos(th_8-pi/4) -sin(th_8-pi/4) 0    0;
                sin(th_8-pi/4)  cos(th_8-pi/4) 0    0;
                  0         0  1    0;
                  0         0  0    1]);
              
pi_00_00a=inv([ 1 0 0 L5; 0 0 -1 0; 0 1 0 0;0 0 0 1]);

pi_00a_o = inv([ 1 0 0 0; 0 1 0 -89.5/10; 0 0 1 0;0 0 0 1]);

mlab_R_vrml=[0 0 1;
             1 0 0;
             0 1 0];
         
mlab_tra_vrml=[0 0 0].';
row4=[0 0 0 1];
mlab_T_vrml=[mlab_R_vrml mlab_tra_vrml; row4];


pi_12_hip=simplify(w_T_RF*pi_12a_12*pi_12_11*pi_11_10*pi_10_09*pi_09_08*pi_08_07*pi_07_06*pi_06_05a*pi_05a_05);
Rpi_12_hip=pi_12_hip(1:3,1:3)

hip_T_pel=simplify(pi_05_04*pi_04_03*pi_03_02*pi_02_01*pi_01_00*pi_00_00a*inv(mlab_T_vrml));
hip_R_pel=hip_T_pel(1:3,1:3)
