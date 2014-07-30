function KHR=khr_DK

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

row4=[0 0 0 1];
w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_2_vrml=[0 0 1 0;
             1 0 0 0;
             0 1 0 0;
             0 0 0 1];
         
mlab_T_o=mlab_2_vrml*w_T_o;

%Cabeza
%[0 0 1]
Thd_o_00=[  c_23   0   s_23    0;
            0       1   0      26;
            -s_23   0   c_23   7.8;
            0       0   0       1];
        
Thd_00_01=[ 1 0 0 0;
            0 1 0 30;
            0 0 1 0;
            0 0 0 1];

KHR.Thd_o_00=mlab_T_o*Thd_o_00;
KHR.Thd_o_01=KHR.Thd_o_00*Thd_00_01;

%Brazo Derecho
%[-1 0 0]
Tbd_o_00=[  1   0       0   -94.5;
            0   c_1   s_1  1.7;
            0   -s_1   c_1   -8.22;
            0   0       0   1];
%[0 0 1]        
Tbd_00_01=[  c_3  s_3   0   -52.8;
             -s_3   c_3   0   0;
             0      0    1   0;
             0      0    0   1];

%[0 1 0]
Tbd_01_02=[ c_5   0   -s_5    0;
            0     1   0      -147;
            s_5  0   c_5     4;
            0     0   0       1];

%[1 0 0]
Tbd_02_03=[ 1   0       0    0;
            0   c_7   s_7  -23;
            0   -s_7    c_7   4;
            0   0       0    1];


Tbd_03_04=[1 0 0   0;
           0 1 0   -200;
           0 0 1   0;
           0 0 0   1];

KHR.Tbd_o_00=mlab_T_o*Tbd_o_00;
KHR.Tbd_o_01=KHR.Tbd_o_00*Tbd_00_01;
KHR.Tbd_o_02=KHR.Tbd_o_01*Tbd_01_02;
KHR.Tbd_o_03=KHR.Tbd_o_02*Tbd_02_03;
KHR.Tbd_o_04=KHR.Tbd_o_03*Tbd_03_04;

%Brazo Izquierdo
%[-1 0 0]
Tbi_o_00=[  1   0       0   94.5;
            0   c_2   s_2  -1.7;
            0   -s_2   c_2   -8.22;
            0   0       0   1];
%[0 0 1]        
Tbi_00_01=[  c_4  -s_4   0   52.8;
             s_4   c_4   0   0;
             0      0    1   0;
             0      0    0   1];

%[0 1 0]
Tbi_01_02=[  c_6   0   s_6    0;
            0     1   0      -147;
            -s_6  0   c_6     4;
            0     0   0       1];

%[1 0 0]
Tbi_02_03=[ 1   0       0    0;
            0   c_8    s_8  -23;
            0  -s_8    c_8   4;
            0   0       0    1];

Tbi_03_04=[1 0 0   0;
           0 1 0   -200;
           0 0 1   0;
           0 0 0   1];

KHR.Tbi_o_00=mlab_T_o*Tbi_o_00;
KHR.Tbi_o_01=KHR.Tbi_o_00*Tbi_00_01;
KHR.Tbi_o_02=KHR.Tbi_o_01*Tbi_01_02;
KHR.Tbi_o_03=KHR.Tbi_o_02*Tbi_02_03;
KHR.Tbi_o_04=KHR.Tbi_o_03*Tbi_03_04;

%Pierna Derecha
%[0 1 0]
Tpd_o_00=[  c_9   0   s_9   0;
            0     1   0     -94.2;
            -s_9  0   c_9   -48.5;
            0     0   0       1];
        
Tpd_00_01=[  c_11   0   -s_11   -43;
            0     1   0      -79.8;
            s_11  0   c_11   17.5;
            0     0   0       1];
%[0 0 1]
Tpd_01_02=[  c_13  s_13   0   9;
            -s_13   c_13   0  -44.7;
             0      0      1   0;
             0      0      0   1];
%[1 0 0]
Tpd_02_03=[ 1   0       0     -22.5;
            0   c_15   -s_15  -77.3;
            0   s_15    c_15   -1.6;
            0   0       0    1];
%[1 0 0]
Tpd_03_04=[ 1   0       0     0;
            0   c_17   -s_17  -127.5;
            0   s_17    c_17   0;
            0   0       0    1];
%[1 0 0]
Tpd_04_05=[ 1   0       0     0;
            0   c_19   -s_19  -128.6;
            0   s_19    c_19   0;
            0   0       0     1];
%[0 0 1]
Tpd_05_06=[  c_21  s_21   0  22.5;
             -s_21   c_21   0  -73.9;
             0      0      1    0;
             0      0      0   1];

Tpd_06_07=[ 1 0 0 0;
            0 1 0 -25;
            0 0 1 0;
            0 0 0 1];
        
KHR.Tpd_o_00=mlab_T_o*Tpd_o_00;
KHR.Tpd_o_01=KHR.Tpd_o_00*Tpd_00_01;
KHR.Tpd_o_02=KHR.Tpd_o_01*Tpd_01_02;
KHR.Tpd_o_03=KHR.Tpd_o_02*Tpd_02_03;
KHR.Tpd_o_04=KHR.Tpd_o_03*Tpd_03_04;
KHR.Tpd_o_05=KHR.Tpd_o_04*Tpd_04_05;
KHR.Tpd_o_06=KHR.Tpd_o_05*Tpd_05_06;
KHR.Tpd_o_07=KHR.Tpd_o_06*Tpd_06_07;
KHR.Tpd_o_P1=KHR.Tpd_o_07*[ 0 0 -70 1]';
KHR.Tpd_o_P2=KHR.Tpd_o_07*[ 0 0  70 1]';
KHR.Tpd_o_P3=KHR.Tpd_o_07*[ 15 0 70 1]';
KHR.Tpd_o_P4=KHR.Tpd_o_07*[ -85 0 70 1]';
KHR.Tpd_o_P5=KHR.Tpd_o_07*[ 15 0 -70 1]';
KHR.Tpd_o_P6=KHR.Tpd_o_07*[ -85 0 -70 1]';

%Pierna Izquierda
Tpi_o_00=[  c_9   0   s_9   0;
            0     1   0     -94.2;
            -s_9  0   c_9   -48.5;
            0     0   0       1];
        
%[0 1 0]
Tpi_00_01=[  c_12   0   s_12   43;
            0     1   0      -79.8;
            -s_12  0   c_12   17.5;
            0     0   0       1];
%[0 0 1]
Tpi_01_02=[  c_14  -s_14   0  -9;   
             s_14   c_14   0  -44.7;
             0      0      1   0;
             0      0      0   1];
%[1 0 0]
Tpi_02_03=[ 1   0       0     22.5;
            0   c_16   -s_16  -77.3;
            0   s_16    c_16   -1.6;
            0   0       0    1];
%[1 0 0]
Tpi_03_04=[ 1   0       0     0;
            0   c_18   -s_18  -127.5;
            0   s_18    c_18   0;
            0   0       0    1];
%[1 0 0]
Tpi_04_05=[ 1   0       0     0;
            0   c_20   -s_20  -128.6;
            0   s_20    c_20   0;
            0   0       0     1];
%[0 0 1]
Tpi_05_06=[  c_22  -s_22   0  -22.5;
             s_22   c_22   0  -73.9;
             0      0      1    0;
             0      0      0   1];

Tpi_06_07=[ 1 0 0 0;
            0 1 0 -25;
            0 0 1 0;
            0 0 0 1];
        
KHR.Tpi_o_00=mlab_T_o*Tpi_o_00;
KHR.Tpi_o_01=KHR.Tpi_o_00*Tpi_00_01;
KHR.Tpi_o_02=KHR.Tpi_o_01*Tpi_01_02;
KHR.Tpi_o_03=KHR.Tpi_o_02*Tpi_02_03;
KHR.Tpi_o_04=KHR.Tpi_o_03*Tpi_03_04;
KHR.Tpi_o_05=KHR.Tpi_o_04*Tpi_04_05;
KHR.Tpi_o_06=KHR.Tpi_o_05*Tpi_05_06;
KHR.Tpi_o_07=KHR.Tpi_o_06*Tpi_06_07;
KHR.Tpi_o_P1=KHR.Tpi_o_07*[ 0 0 -70 1]';
KHR.Tpi_o_P2=KHR.Tpi_o_07*[ 0 0  70 1]';
KHR.Tpi_o_P3=KHR.Tpi_o_07*[ -15 0 70 1]';
KHR.Tpi_o_P4=KHR.Tpi_o_07*[ 85 0 70 1]';
KHR.Tpi_o_P5=KHR.Tpi_o_07*[ -15 0 -70 1]';
KHR.Tpi_o_P6=KHR.Tpi_o_07*[ 85 0 -70 1]';
