function bld_Chck_IK_RL(th)

w_R_RF=eye(3);
w_p_RF=[0 -38.5/10 0].';
row4=[0 0 0 1];

w_T_RF=[w_R_RF w_p_RF; row4];

L5=38.5/10;
L6=31/10;
L7=75/10;
L8=14.5/10;
k=0.707;

%%Pierna derecha
pd_12a_12=inv([0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1]);

pd_12_11=inv([0 -1 0 0; -1 0 0 0; 0 0 -1 0; 0 0 0 1]);

pd_11_10 = inv([ cos(th(17))  -sin(th(17)) 0    0;
             sin(th(17))  cos(th(17))  0    0;
                  0         0      1    0;
                  0         0      0    1]);

pd_10_09=inv([0 0 -1 0; 1 0 0 0; 0 -1 0 0; 0 0 0 1]);

pd_09_08 =inv([ cos(th(15))   sin(th(15)) 0    0;
            -sin(th(15))  cos(th(15))  0    0;
                  0         0      1    0;
                  0         0      0    1]);
              
pd_08_07 =inv([0 1 0 L7; -1 0 0 -L8; 0 0 1 0; 0 0 0 1]);

pd_07_06 = inv([ cos(th(13))   sin(th(13)) 0    0;
            -sin(th(13))  cos(th(13))  0    0;
                  0         0      1    0;
                  0         0      0    1]);
pd_06_05a = inv([-1 0 0 0; 0 -1 0 -L8; 0 0 1 0; 0 0 0 1]);

pd_05a_05 = inv([1 0 0 -L7; 0 1 0 0; 0 0 1 0; 0 0 0 1]);

pd_05_04 = inv([cos(th(11)) -sin(th(11)) 0    0;
            sin(th(11))  cos(th(11)) 0    0;
                  0         0    1    0;
                  0         0    0    1]); 
              
pd_04_03=inv([0 0 -1 0; 1 0 0 0; 0 -1 0 0; 0 0 0 1]);

pd_03_02 = inv([ cos(th(9))   sin(th(9)) 0    0;
            -sin(th(9))  cos(th(9))  0    0;
                  0         0    1    0;
                  0         0    0    1]);

pd_02_01=  inv([k 0 -k 0; k 0 k 0; 0 -1 0 L6; 0 0 0 1]);

pd_01_00 = inv([cos(th(7)) -sin(th(7)) 0    0;
            sin(th(7))  cos(th(7)) 0    0;
                  0         0  1    0;
                  0         0  0    1]);
              
pd_00_00a=inv([-1 0 0 -L5; 0 0 -1 0; 0 -1 0 0; 0 0 0 1]);

pd_00a_o = inv([1 0 0 0; 0 1 0 -89.5/10; 0 0 1 0; 0 0 0 1]);

mlab_R_vrml=[0 0 1;
             1 0 0;
             0 1 0];
         
mlab_tra_vrml=[0 0 0].';
row4=[0 0 0 1];
mlab_T_vrml=[mlab_R_vrml mlab_tra_vrml; row4];


pd_12_c=w_T_RF*pd_12a_12*pd_12_11*pd_11_10*pd_10_09*pd_09_08*pd_08_07*pd_07_06*pd_06_05a*pd_05a_05*pd_05_04*pd_04_03*pd_03_02*pd_02_01*pd_01_00*pd_00_00a*inv(mlab_T_vrml);

R=pd_12_c(1:3,1:3)
p=pd_12_c(1:3,4)
