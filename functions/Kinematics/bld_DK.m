function BLD=bld_DK

global Robot

th=Get_Ths_vrHumanoid;

mlab_R_vrml=[0 0 1;
             1 0 0;
             0 1 0];       

mlab_tra_vrml=[0 0 0].';
row4=[0 0 0 1];
mlab_T_vrml=[mlab_R_vrml mlab_tra_vrml; row4];

w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_T_o=w_T_o*mlab_T_vrml;


L0=47/10;
L1=14.5/10;
L2=25/10;
L3=67.5/10;
L4=74.5/10;

%Cabeza
%r_cabeza=mlab_T_o(1:3,1:3)*[mlab_T_o(1:3,4)*[x_o y_o z_o+0.5].'];

%Brazo derecho
BLD.T_obd00 = mlab_T_o*[0 0 -1 -L0; 1 0 0 0; 0 -1 0 0; 0 0 0 1];

BLD.T_00bd01 = [cos(th(1)) -sin(th(1))  0    0;
            sin(th(1))  cos(th(1))  0    0;
                  0              0  1    0;
                  0              0  0    1];
BLD.T_obd01 = BLD.T_obd00*BLD.T_00bd01;

BLD.T_01bd02=   [1 0 0 0; 0 1 0 0; 0 0 1 L2; 0 0 0 1];
BLD.T_obd02=BLD.T_obd01*BLD.T_01bd02;

BLD.T_02bd02a=   [0 0 1 0; -1 0 0 -L1; 0 -1 0 0; 0 0 0 1];
BLD.T_obd02a=BLD.T_obd02*BLD.T_02bd02a;

BLD.T_02bd03 = [ cos(th(3)) sin(th(3))  0    0;
            -sin(th(3)) cos(th(3))  0    0;
                  0              0  1    0;
                  0              0  0    1];
BLD.T_obd03=BLD.T_obd02a*BLD.T_02bd03;

BLD.T_03bd04=   [1 0 0 0; 0 1 0 -L3; 0 0 1 0; 0 0 0 1];
BLD.T_obd04=BLD.T_obd03*BLD.T_03bd04;

BLD.T_04bd05 = [ cos(th(5))  sin(th(5)) 0    0;
            -sin(th(5))  cos(th(5)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_obd05=BLD.T_obd04*BLD.T_04bd05;

BLD.T_05bd06=   [0 0 1 0; 1 0 0 -L4; 0 1 0 0; 0 0 0 1];
BLD.T_obd06=BLD.T_obd05*BLD.T_05bd06;
   
%Brazo izquierdo
BLD.T_obi00 = mlab_T_o*[0 0 1 L0; 1 0 0 0; 0 1 0 0; 0 0 0 1];

BLD.T_00bi01 = [cos(th(2)) -sin(th(2)) 0    0;
            sin(th(2))  cos(th(2)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_obi01 = BLD.T_obi00*BLD.T_00bi01;

BLD.T_01bi02=   [1 0 0 0; 0 1 0  0; 0 0 1  L2; 0 0 0 1];
BLD.T_obi02=BLD.T_obi01*BLD.T_01bi02;

BLD.T_02bi02a=   [0 0 1 0; -1 0 0 L1; 0 -1 0 0; 0 0 0 1];
BLD.T_obi02a=BLD.T_obi02*BLD.T_02bi02a;

BLD.T_02bi03 = [ cos(th(4))  sin(th(4)) 0    0;
            -sin(th(4))  cos(th(4)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_obi03=BLD.T_obi02a*BLD.T_02bi03;

BLD.T_03bi04=   [1 0 0 0; 0 1 0 -L3; 0 0 1 0; 0 0 0 1];
BLD.T_obi04=BLD.T_obi03*BLD.T_03bi04;

BLD.T_04bi05 = [ cos(th(6))  sin(th(6)) 0    0;
            -sin(th(6))  cos(th(6)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_obi05=BLD.T_obi04*BLD.T_04bi05;

BLD.T_05bi06=   [0 0 -1 0; -1 0 0 -L4; 0 1 0 0; 0 0 0 1];
BLD.T_obi06=BLD.T_obi05*BLD.T_05bi06;

L5=38.5/10;
L6=31/10;
L7=75/10;
L8=14.5/10;
k=0.707;

%%Pierna derecha
BLD.T_opd00a = mlab_T_o*[1 0 0 0; 0 1 0 -89.5/10; 0 0 1 0; 0 0 0 1];

BLD.T_00apd00=[-1 0 0 -L5; 0 0 -1 0; 0 -1 0 0; 0 0 0 1];
BLD.T_opd00=BLD.T_opd00a*BLD.T_00apd00;

BLD.T_00pd01 = [cos(th(7)) -sin(th(7)) 0    0;
            sin(th(7))  cos(th(7)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_opd01 = BLD.T_opd00*BLD.T_00pd01;

BLD.T_01pd02=   [k 0 -k 0; k 0 k 0; 0 -1 0 L6; 0 0 0 1];
BLD.T_opd02=BLD.T_opd01*BLD.T_01pd02;

BLD.T_02pd03 = [ cos(th(9))   sin(th(9)) 0    0;
            -sin(th(9))  cos(th(9))  0    0;
                  0         0    1    0;
                  0         0    0    1];
              
BLD.T_opd03=BLD.T_opd02*BLD.T_02pd03;

BLD.T_03pd04=[0 0 -1 0; 1 0 0 0; 0 -1 0 0; 0 0 0 1];
BLD.T_opd04=BLD.T_opd03*BLD.T_03pd04;

BLD.T_04pd05 = [cos(th(11)) -sin(th(11)) 0    0;
            sin(th(11))  cos(th(11)) 0    0;
                  0         0    1    0;
                  0         0    0    1];
BLD.T_opd05=BLD.T_opd04*BLD.T_04pd05;

BLD.T_05pd05a = [1 0 0 -L7; 0 1 0 0; 0 0 1 0; 0 0 0 1];
BLD.T_opd05a=BLD.T_opd05*BLD.T_05pd05a;

BLD.T_05apd06 = [-1 0 0 0; 0 -1 0 -L8; 0 0 1 0; 0 0 0 1];
BLD.T_opd06=BLD.T_opd05a*BLD.T_05apd06;

BLD.T_06pd07 = [ cos(th(13))   sin(th(13)) 0    0;
            -sin(th(13))  cos(th(13))  0    0;
                  0         0      1    0;
                  0         0      0    1];
              
BLD.T_opd07=BLD.T_opd06*BLD.T_06pd07;

BLD.T_07pd07a = [1 0 0 0; 0 1 0 -L8; 0 0 1 0; 0 0 0 1];
BLD.T_opd07a=BLD.T_opd07*BLD.T_07pd07a;

BLD.T_07pd08 = [0 1 0 L7; -1 0 0 -L8; 0 0 1 0; 0 0 0 1];
BLD.T_opd08=BLD.T_opd07*BLD.T_07pd08;

BLD.T_08pd09 = [ cos(th(15))   sin(th(15)) 0    0;
            -sin(th(15))  cos(th(15))  0    0;
                  0         0      1    0;
                  0         0      0    1];
BLD.T_opd09=BLD.T_opd08*BLD.T_08pd09;

BLD.T_09pd10=[0 0 -1 0; 1 0 0 0; 0 -1 0 0; 0 0 0 1];
BLD.T_opd10=BLD.T_opd09*BLD.T_09pd10;

BLD.T_10pd11 = [ cos(th(17))  -sin(th(17)) 0    0;
             sin(th(17))  cos(th(17))  0    0;
                  0         0      1    0;
                  0         0      0    1];
BLD.T_opd11=BLD.T_opd10*BLD.T_10pd11; 
              
BLD.T_11pd12=[0 -1 0 29.5/10; -1 0 0 0; 0 0 -1 0; 0 0 0 1];
BLD.T_opd12=BLD.T_opd11*BLD.T_11pd12;

BLD.T_12pd12a=[0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1];
BLD.T_opd12a=BLD.T_opd12*BLD.T_12pd12a;

BLD.T_12pdb=[1 0 0 0; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opdb=BLD.T_opd12*BLD.T_12pdb;

BLD.T_12pdf=[1 0 0 0; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opdf=BLD.T_opd12*BLD.T_12pdf;

BLD.T_12pdP1=[1 0 0 28/10; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opdP1=BLD.T_opd12*BLD.T_12pdP1;

BLD.T_12pdP2=[1 0 0 -28/10; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opdP2=BLD.T_opd12*BLD.T_12pdP2;

BLD.T_12pdP3=[1 0 0 28/10; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opdP3=BLD.T_opd12*BLD.T_12pdP3;

BLD.T_12pdP4=[1 0 0 -28/10; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opdP4=BLD.T_opd12*BLD.T_12pdP4;

%%Pierna izquierda
BLD.T_opi00a = mlab_T_o*[ 1 0 0 0; 0 1 0 -89.5/10; 0 0 1 0;0 0 0 1];

BLD.T_00api00=[ 1 0 0 L5; 0 0 -1 0; 0 1 0 0;0 0 0 1];
BLD.T_opi00=BLD.T_opi00a*BLD.T_00api00;

BLD.T_00pi01 = [cos(th(8)) -sin(th(8)) 0    0;
            sin(th(8))  cos(th(8)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_opi01 = BLD.T_opi00*BLD.T_00pi01;

BLD.T_01pi02=   [-0.707 0 -0.707 0; 0.707 0 -0.707 0; 0 -1 0 L6; 0 0 0 1];
BLD.T_opi02=BLD.T_opi01*BLD.T_01pi02;

BLD.T_02pi03 = [ cos(th(10))  sin(th(10)) 0    0;
            -sin(th(10))  cos(th(10)) 0    0;
                  0         0  1    0;
                  0         0  0    1];
BLD.T_opi03=BLD.T_opi02*BLD.T_02pi03;

BLD.T_03pi04=[0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1];
BLD.T_opi04=BLD.T_opi03*BLD.T_03pi04;

BLD.T_04pi05 = [cos(th(12)) -sin(th(12)) 0    0;
            sin(th(12))  cos(th(12)) 0    0;
                  0         0    1    0;
                  0         0    0    1];
BLD.T_opi05=BLD.T_opi04*BLD.T_04pi05;

BLD.T_05pi05a = [1 0 0 -L7; 0 1 0 0; 0 0 1 0; 0 0 0 1];
BLD.T_opi05a=BLD.T_opi05*BLD.T_05pi05a;

BLD.T_05pi06 = [1 0 0 0; 0 1 0 L8; 0 0 1 0; 0 0 0 1];
BLD.T_opi06=BLD.T_opi05a*BLD.T_05pi06;

BLD.T_06pi07 = [ cos(th(14))  sin(th(14)) 0    0;
            -sin(th(14))  cos(th(14)) 0    0;
                  0         0    1    0;
                  0         0    0    1];
BLD.T_opi07=BLD.T_opi06*BLD.T_06pi07;

BLD.T_07pi07a = [1 0 0 0; 0 1 0 -L8; 0 0 1 0; 0 0 0 1];
BLD.T_opi07a=BLD.T_opi07*BLD.T_07pi07a;

BLD.T_07pi08 = [0 -1 0 -L7; 1 0 0 -L8; 0 0 1 0; 0 0 0 1];
BLD.T_opi08=BLD.T_opi07*BLD.T_07pi08;
         
BLD.T_08pi09 = [ cos(th(16))   sin(th(16)) 0    0;
            -sin(th(16))  cos(th(16)) 0    0;
                  0         0    1    0;
                  0         0    0    1];
BLD.T_opi09=BLD.T_opi08*BLD.T_08pi09;

BLD.T_09pi10=[0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 0 1];
BLD.T_opi10=BLD.T_opi09*BLD.T_09pi10;
         
BLD.T_10pi11 = [ cos(th(18))  -sin(th(18)) 0    0;
             sin(th(18))  cos(th(18)) 0    0;
                  0         0    1    0;
                  0         0    0    1];
BLD.T_opi11=BLD.T_opi10*BLD.T_10pi11; 

BLD.T_11pi12=[0 -1 0 29.5/10; -1 0 0 0; 0 0 -1 0; 0 0 0 1];
BLD.T_opi12=BLD.T_opi11*BLD.T_11pi12;

BLD.T_12pi12a=[0 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1];
BLD.T_opi12a=BLD.T_opi12*BLD.T_12pi12a;

BLD.T_12pib=[1 0 0 0; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opib=BLD.T_opi12*BLD.T_12pib;

BLD.T_12pif=[1 0 0 0; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opif=BLD.T_opi12*BLD.T_12pif;

BLD.T_12piP1=[1 0 0 28/10; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opiP1=BLD.T_opi12*BLD.T_12piP1;

BLD.T_12piP2=[1 0 0 -28/10; 0 1 0 0; 0 0 1 45/10; 0 0 0 1];
BLD.T_opiP2=BLD.T_opi12*BLD.T_12piP2;

BLD.T_12piP3=[1 0 0 28/10; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opiP3=BLD.T_opi12*BLD.T_12piP3;

BLD.T_12piP4=[1 0 0 -28/10; 0 1 0 0; 0 0 1 -48/10; 0 0 0 1];
BLD.T_opiP4=BLD.T_opi12*BLD.T_12piP4;
