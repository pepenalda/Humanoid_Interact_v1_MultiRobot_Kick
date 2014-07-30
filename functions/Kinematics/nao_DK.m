function NAO=nao_DK

global Robot

th=Get_Ths_vrHumanoid;
c_1=cos(th(1));
s_1=sin(th(1));
c_2=cos(th(2));
s_2=sin(th(2));
c_3=cos(th(3));
s_3=sin(th(3));
c_4=cos(th(4));
s_4=sin(th(4));
c_5=cos(th(5));
s_5=sin(th(5));
c_6=cos(th(6));
s_6=sin(th(6));
c_7=cos(th(7));
s_7=sin(th(7));
c_8=cos(th(8));
s_8=sin(th(8));
c_9=cos(th(9));
s_9=sin(th(9));
c_10=cos(th(10));
s_10=sin(th(10));
c_11=cos(th(11));
s_11=sin(th(11));
c_12=cos(th(12));
s_12=sin(th(12));
c_13=cos(th(13));
s_13=sin(th(13));
c_14=cos(th(14));
s_14=sin(th(14));
c_15=cos(th(15));
s_15=sin(th(15));
c_16=cos(th(16));
s_16=sin(th(16));
c_17=cos(th(17));
s_17=sin(th(17));
c_18=cos(th(18));
s_18=sin(th(18));
c_19=cos(th(19));
s_19=sin(th(19));
c_20=cos(th(20));
s_20=sin(th(20));
c_21=cos(th(21));
s_21=sin(th(21));
c_22=cos(th(22));
s_22=sin(th(22));
c_23=cos(th(23));
s_23=sin(th(23));
c_24=cos(th(24));
s_24=sin(th(24));
c_25=cos(th(25));
s_25=sin(th(25));
c_26=cos(th(26));
s_26=sin(th(26));

row4=[0 0 0 1];
w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_T_o=w_T_o;

%Cabeza
%[0 0 1]
Thd_o_00=[   c_1   -s_1   0   0;
             s_1   c_1    0   0;
             0      0       1   126.5+85;
             0      0       0   1];

%[0 1 0]
Thd_00_01=[  c_2   0   s_2    0;
            0       1   0       0;
            -s_2   0   c_2    0;
            0       0   0       1];
        
Thd_01_02=[ 1 0 0 0;
            0 1 0 0;
            0 0 1 60;
            0 0 0 1];

NAO.Thd_o_00=mlab_T_o*Thd_o_00;
NAO.Thd_o_01=NAO.Thd_o_00*Thd_00_01;
NAO.Thd_o_02=NAO.Thd_o_01*Thd_01_02;

%Brazo Derecho
%[0 1 0]
Tbd_o_00=[  c_9   0   s_9    0;
            0     1   0      -98;
            -s_9  0   c_9    100+85;
            0     0   0       1];

%[0 0 1]        
Tbd_00_01=[  c_10  -s_10   0   5;
             s_10   c_10   0   0;
             0      0    1   0;
             0      0    0   1];

%[1 0 0]
Tbd_01_02=[ 1   0       0   105;
            0   c_11   -s_11  -15;
            0   s_11   c_11   0;
            0   0       0       1];

%[0 0 1]
Tbd_02_03=[  c_12  -s_12   0   0;
             s_12   c_12   0   0;
             0      0    1   0;
             0      0    0   1];

%[1 0 0]
Tbd_03_04=[ 1   0       0   55.95;
            0   c_13   -s_13  0;
            0   s_13   c_13   0;
            0   0       0   1];


Tbd_04_05=[1 0 0 60;
           0 1 0   0;
           0 0 1   0;
           0 0 0   1];

NAO.Tbd_o_00=mlab_T_o*Tbd_o_00;
NAO.Tbd_o_01=NAO.Tbd_o_00*Tbd_00_01;
NAO.Tbd_o_02=NAO.Tbd_o_01*Tbd_01_02;
NAO.Tbd_o_03=NAO.Tbd_o_02*Tbd_02_03;
NAO.Tbd_o_04=NAO.Tbd_o_03*Tbd_03_04;
NAO.Tbd_o_05=NAO.Tbd_o_04*Tbd_04_05;


%Brazo Izquierdo
%[0 1 0]
Tbi_o_00=[  c_3   0   s_3    0;
            0     1   0      98;
            -s_3  0   c_3    100+85;
            0     0   0       1];

%[0 0 1]        
Tbi_00_01=[  c_4  -s_4   0   5;
             s_4   c_4   0   0;
             0      0    1   0;
             0      0    0   1];

%[1 0 0]
Tbi_01_02=[ 1   0       0       105;
            0   c_5   -s_5  15;
            0   s_5   c_5   0;
            0   0       0       1];

%[0 0 1]
Tbi_02_03=[  c_6  -s_6   0   0;
             s_6   c_6   0   0;
             0      0    1   0;
             0      0    0   1];

%[1 0 0]
Tbi_03_04=[ 1   0       0     55.95;
            0   c_7   -s_7  0;
            0   s_7   c_7   0;
            0   0       0     1];


Tbi_04_05=[1 0 0 60;
           0 1 0   0;
           0 0 1   0;
           0 0 0   1];

NAO.Tbi_o_00=mlab_T_o*Tbi_o_00;
NAO.Tbi_o_01=NAO.Tbi_o_00*Tbi_00_01;
NAO.Tbi_o_02=NAO.Tbi_o_01*Tbi_01_02;
NAO.Tbi_o_03=NAO.Tbi_o_02*Tbi_02_03;
NAO.Tbi_o_04=NAO.Tbi_o_03*Tbi_03_04;
NAO.Tbi_o_05=NAO.Tbi_o_04*Tbi_04_05;

%Pierna Derecha
%[0.707 0.707 0]
Tpd_o_00=[  c_21            -0.7071*s_21   0.7071*s_21   0;
            0.7071*s_21     0.5*(1+c_21)   0.5*(1-c_21)  -50;
           -0.7071*s_21     0.5*(1-c_21)   0.5*(1+c_21)  0;
            0               0               0            1];
%[1 0 0]
Tpd_00_01=[ 1   0       0       0;
            0   c_22   -s_22    0;
            0   s_22   c_22     0;
            0   0       0       1];
%[0 1 0]
Tpd_01_02=[  c_23   0   s_23    0;
              0     1   0      0;
            -s_23  0   c_23    0;
            0     0   0       1];
%[0 1 0]
Tpd_02_03=[  c_24   0   s_24   0;
            0     1   0      0;
            -s_24  0   c_24    -100;
            0     0   0       1];
%[0 1 0]
Tpd_03_04=[  c_25   0   s_25  0;
            0     1   0       0;
            -s_25  0   c_25   -102.9;
            0     0   0       1];
%[1 0 0]
Tpd_04_05=[ 1   0       0           0;
            0   c_26   -s_26    0;
            0   s_26   c_26     0;
            0   0       0           1];

Tpd_05_06=[ 1 0 0 0;
            0 1 0 0;
            0 0 1 -42;
            0 0 0 1];
        
NAO.Tpd_o_00=mlab_T_o*Tpd_o_00;
NAO.Tpd_o_01=NAO.Tpd_o_00*Tpd_00_01;
NAO.Tpd_o_02=NAO.Tpd_o_01*Tpd_01_02;
NAO.Tpd_o_03=NAO.Tpd_o_02*Tpd_02_03;
NAO.Tpd_o_04=NAO.Tpd_o_03*Tpd_03_04;
NAO.Tpd_o_05=NAO.Tpd_o_04*Tpd_04_05;
NAO.Tpd_o_06=NAO.Tpd_o_05*Tpd_05_06;
NAO.Tpd_o_P1=NAO.Tpd_o_06*[-30 0 0 1]';
NAO.Tpd_o_P2=NAO.Tpd_o_06*[ 70 0 0 1]';
NAO.Tpd_o_P3=NAO.Tpd_o_06*[-30 -33 0 1]';
NAO.Tpd_o_P4=NAO.Tpd_o_06*[-30  21 0 1]';
NAO.Tpd_o_P5=NAO.Tpd_o_06*[ 70 -33 0 1]';
NAO.Tpd_o_P6=NAO.Tpd_o_06*[ 70  21 0 1]';

%Pierna Izquierda
%[0.707 0.707 0]
Tpi_o_00=[  c_15            0.7071*s_15     0.7071*s_15   0;
           -0.7071*s_15     0.5*(1+c_15)   -0.5*(1-c_15)  50;
           -0.7071*s_15     -0.5*(1-c_15)   0.5*(1+c_15)  0;
            0               0               0            1];
%[1 0 0]
Tpi_00_01=[ 1   0       0           0;
            0   c_16   -s_16    0;
            0   s_16   c_16     0;
            0   0       0           1];
%[0 1 0]
Tpi_01_02=[  c_17   0   s_17    0;
            0     1   0      0;
            -s_17  0   c_17    0;
            0     0   0       1];
%[0 1 0]
Tpi_02_03=[  c_18   0   s_18   0;
            0     1   0         0;
            -s_18  0   c_18    -100;
            0     0   0       1];
%[0 1 0]
Tpi_03_04=[  c_19   0   s_19    0;
            0     1   0         0;
            -s_19  0   c_19    -102.9;
            0     0   0       1];
%[1 0 0]
Tpi_04_05=[ 1   0       0           0;
            0   c_20   -s_20    0;
            0   s_20   c_20     0;
            0   0       0           1];

Tpi_05_06=[ 1 0 0 0;
            0 1 0 0;
            0 0 1 -42;
            0 0 0 1];

NAO.Tpi_o_00=mlab_T_o*Tpi_o_00;
NAO.Tpi_o_01=NAO.Tpi_o_00*Tpi_00_01;
NAO.Tpi_o_02=NAO.Tpi_o_01*Tpi_01_02;
NAO.Tpi_o_03=NAO.Tpi_o_02*Tpi_02_03;
NAO.Tpi_o_04=NAO.Tpi_o_03*Tpi_03_04;
NAO.Tpi_o_05=NAO.Tpi_o_04*Tpi_04_05;
NAO.Tpi_o_06=NAO.Tpi_o_05*Tpi_05_06;
NAO.Tpi_o_P1=NAO.Tpi_o_06*[-30 0 0 1]';
NAO.Tpi_o_P2=NAO.Tpi_o_06*[ 70 0 0 1]';
NAO.Tpi_o_P3=NAO.Tpi_o_06*[-30 -25 0 1]';
NAO.Tpi_o_P4=NAO.Tpi_o_06*[-30  35 0 1]';
NAO.Tpi_o_P5=NAO.Tpi_o_06*[ 70 -25 0 1]';
NAO.Tpi_o_P6=NAO.Tpi_o_06*[ 70  35 0 1]';
