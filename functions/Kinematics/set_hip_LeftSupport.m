function set_hip_LeftSupport

global Robot

th=Get_Ths_vrHumanoid;

w_R_LF=eye(3);
w_p_LF=[0 38.5/10 0].';
row4=[0 0 0 1];

w_T_LF=[w_R_LF w_p_LF; row4];

L5=38.5/10;
L6=31/10;
L7=75/10;
L8=14.5/10;
k=0.707;

%%Pierna izquierda
pi_12a_12=inv([0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1]);

pi_12_11=inv([0 -1 0 29.5/10; -1 0 0 0; 0 0 -1 0; 0 0 0 1]);

pi_11_10 = inv([ cos(th(18))  -sin(th(18)) 0    0;
             sin(th(18))  cos(th(18)) 0    0;
                  0         0    1    0;
                  0         0    0    1]);

pi_10_09=inv([0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1]);

pi_09_08 =inv([ cos(th(16))   sin(th(16)) 0    0;
            -sin(th(16))  cos(th(16)) 0    0;
                  0         0    1    0;
                  0         0    0    1]);
              
pi_08_07 =inv([0 -1 0 -L7; 1 0 0 -L8; 0 0 1 0; 0 0 0 1]);

pi_07_06 = inv([ cos(th(14))  sin(th(14)) 0    0;
            -sin(th(14))  cos(th(14)) 0    0;
                  0         0    1    0;
                  0         0    0    1]);
pi_06_05a = inv([1 0 0 0; 0 1 0 L8; 0 0 1 0; 0 0 0 1]);

pi_05a_05 = inv([1 0 0 -L7; 0 1 0 0; 0 0 1 0; 0 0 0 1]);

pi_05_04 = inv([cos(th(12)) -sin(th(12)) 0    0;
            sin(th(12))  cos(th(12)) 0    0;
                  0         0    1    0;
                  0         0    0    1]); 
              
pi_04_03=inv([0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1]);

pi_03_02 = inv([ cos(th(10))  sin(th(10)) 0    0;
            -sin(th(10))  cos(th(10)) 0    0;
                  0         0  1    0;
                  0         0  0    1]);

pi_02_01=  inv([-0.707 0 -0.707 0; 0.707 0 -0.707 0; 0 -1 0 L6; 0 0 0 1]);

pi_01_00 = inv([cos(th(8)) -sin(th(8)) 0    0;
            sin(th(8))  cos(th(8)) 0    0;
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


pi_12_c=w_T_LF*pi_12a_12*pi_12_11*pi_11_10*pi_10_09*pi_09_08*pi_08_07*pi_07_06*pi_06_05a*pi_05a_05*pi_05_04*pi_04_03*pi_03_02*pi_02_01*pi_01_00*pi_00_00a*pi_00a_o*inv(mlab_T_vrml);

Robot.w_R_o=pi_12_c(1:3,1:3);
Robot.w_p_o=pi_12_c(1:3,4);

vrot=vrrotmat2vec(Robot.w_R_o);
vrot=[vrot(2) vrot(3) vrot(1) vrot(4)];
setfield(Robot.vrRobot,'translationHips',(mlab_R_vrml.'*Robot.w_p_o*10).');
setfield(Robot.vrRobot,'rotationHips',vrot);
