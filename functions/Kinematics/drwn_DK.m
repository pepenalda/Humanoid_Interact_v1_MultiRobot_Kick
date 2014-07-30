function DRWN=drwn_DK

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

row4=[0 0 0 1];
w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_2_vrml=[0 0 1 0;
             1 0 0 0;
             0 1 0 0;
             0 0 0 1];
mlab_T_o=mlab_2_vrml*w_T_o;

%Cabeza
%[0 1 0]
Thd_o_00=[  c_19   0   s_19    0;
            0       1   0      51;
            -s_19   0  c_19    0;
            0       0   0       1];

%[-1 0 0]
Thd_00_01=[ 1   0       0    0;
            0   c_20   s_20 0;
            0   -s_20   c_20  0;
            0   0       0       1];
        
Thd_01_02=[ 1 0 0 0;
            0 1 0 30;
            0 0 1 0;
            0 0 0 1];

DRWN.Thd_o_00=mlab_T_o*Thd_o_00;
DRWN.Thd_o_01=DRWN.Thd_o_00*Thd_00_01;
DRWN.Thd_o_02=DRWN.Thd_o_01*Thd_01_02;

%Brazo Derecho
%[-1 0 0]
Tbd_o_00=[ 1   0       0    -82;
            0   c_1   s_1    0;
            0   -s_1  c_1    0;
            0   0       0    1];

%[0 0 1]        
Tbd_00_01=[  c_3   s_3   0   0;
            -s_3   c_3   0   -16;
             0      0    1   0;
             0      0    0   1];

%[-1 0 0]
Tbd_01_02=[ 1   0       0    0;
            0   1       0     -60;
            0   0       1    0;
            0   0       0    1];

Tbd_02_03=[ 1   0       0    0;
            0   c_5   s_5    0;
            0   -s_5  c_5    16;
            0   0       0    1];

Tbd_03_04=[1 0 0   0;
           0 1 0   0;
           0 0 1   -16;
           0 0 0   1];

Tbd_04_05=[1 0 0   0;
           0 1 0  -73;
           0 0 1   0;
           0 0 0   1];

       
DRWN.Tbd_o_00=mlab_T_o*Tbd_o_00;
DRWN.Tbd_o_01=DRWN.Tbd_o_00*Tbd_00_01;
DRWN.Tbd_o_02=DRWN.Tbd_o_01*Tbd_01_02;
DRWN.Tbd_o_03=DRWN.Tbd_o_02*Tbd_02_03;
DRWN.Tbd_o_04=DRWN.Tbd_o_03*Tbd_03_04;
DRWN.Tbd_o_05=DRWN.Tbd_o_04*Tbd_04_05;


%Brazo Izquierdo
%[1 0 0]
Tbi_o_00=[ 1   0       0    82;
            0   c_2   -s_2    0;
            0   s_2  c_2    0;
            0   0       0    1];

%[0 0 -1]        
Tbi_00_01=[  c_4   s_4   0   0;
             -s_4   c_4   0   -16;
             0      0    1   0;
             0      0    0   1];

%[-1 0 0]
Tbi_01_02=[ 1   0     0    0;
            0   1     0    -60;
            0   0     1    0;
            0   0       0    1];

Tbi_02_03=[ 1   0       0    0;
            0   c_6   -s_6    0;
            0   s_6  c_6    16;
            0   0       0    1];


Tbi_03_04=[1 0 0   0;
           0 1 0   0;
           0 0 1   -16;
           0 0 0   1];

Tbi_04_05=[1 0 0   0;
           0 1 0  -73;
           0 0 1   0;
           0 0 0   1];


DRWN.Tbi_o_00=mlab_T_o*Tbi_o_00;
DRWN.Tbi_o_01=DRWN.Tbi_o_00*Tbi_00_01;
DRWN.Tbi_o_02=DRWN.Tbi_o_01*Tbi_01_02;
DRWN.Tbi_o_03=DRWN.Tbi_o_02*Tbi_02_03;
DRWN.Tbi_o_04=DRWN.Tbi_o_03*Tbi_03_04;
DRWN.Tbi_o_05=DRWN.Tbi_o_04*Tbi_04_05;

%Pierna Derecha
%[0 -1 0]
Tpd_o_00=[  1   0  0  0;
            0   1  0  -122.2;
            0   0  1  0;
            0     0   0        1];

Tpd_00_01=[  c_7   0  -s_7  -37;
            0     1   0      0;
            s_7   0   c_7     5;
            0     0   0        1];
%[0 0 -1]
Tpd_01_02=[  c_9   s_9   0   0;
            -s_9   c_9   0   0;
             0      0    1   0;
             0      0    0   1];
%[0 1 0]
Tpd_02_03=[ 1   0       0    0;
            0   c_11   -s_11  0;
            0   s_11  c_11  0;
            0   0       0    1];
%[0 1 0]
Tpd_03_04=[ 1   0       0      0;
            0   c_13   -s_13  -93;
            0   s_13  c_13    0;
            0   0       0    1];
%[0 1 0]
Tpd_04_05=[ 1   0       0     0;
            0   c_15   s_15  -93;
            0   -s_15  c_15   0;
            0   0       0     1];
%[1 0 0]
Tpd_05_06=[  c_17   -s_17  0  0;
             s_17   c_17   0  0;
             0      0    1   0;
             0      0    0   1];

Tpd_06_07=[ 1 0 0 0;
            0 1 0 -33.5;
            0 0 1 0;
            0 0 0 1];
        
DRWN.Tpd_o_00=mlab_T_o*Tpd_o_00;
DRWN.Tpd_o_01=DRWN.Tpd_o_00*Tpd_00_01;
DRWN.Tpd_o_02=DRWN.Tpd_o_01*Tpd_01_02;
DRWN.Tpd_o_03=DRWN.Tpd_o_02*Tpd_02_03;
DRWN.Tpd_o_04=DRWN.Tpd_o_03*Tpd_03_04;
DRWN.Tpd_o_05=DRWN.Tpd_o_04*Tpd_04_05;
DRWN.Tpd_o_06=DRWN.Tpd_o_05*Tpd_05_06;
DRWN.Tpd_o_07=DRWN.Tpd_o_06*Tpd_06_07;
DRWN.Tpd_o_P1=DRWN.Tpd_o_07*[ 0 0 -52.5 1]';
DRWN.Tpd_o_P2=DRWN.Tpd_o_07*[ 0 0  52.5 1]';
DRWN.Tpd_o_P3=DRWN.Tpd_o_07*[ 23 0 52.5 1]';
DRWN.Tpd_o_P4=DRWN.Tpd_o_07*[ -43 0 52.5 1]';
DRWN.Tpd_o_P5=DRWN.Tpd_o_07*[ 23 0 -52.5 1]';
DRWN.Tpd_o_P6=DRWN.Tpd_o_07*[ -43 0 -52.5 1]';

%Pierna Izquierda
%Pierna Derecha
%[0 -1 0]
Tpi_o_00=[  1   0  0   0;
            0   1   0  -122.2;
            0   0   1   0;
            0     0   0        1];

Tpi_00_01=[  c_8   0  -s_8   37;
            0     1   0     0;
            s_8   0   c_8   5;
            0     0   0     1];
%[0 0 -1]
Tpi_01_02=[  c_10   s_10   0   0;
            -s_10   c_10   0   0;
             0      0    1   0;
             0      0    0   1];
%[-1 0 0]
Tpi_02_03=[ 1   0       0    0;
            0   c_12   s_12  0;
            0   -s_12  c_12  0;
            0   0       0    1];
%[0 1 0]
Tpi_03_04=[ 1   0       0      0;
            0   c_14   s_14  -93;
            0   -s_14  c_14    0;
            0   0       0    1];
%[0 1 0]
Tpi_04_05=[ 1   0       0     0;
            0   c_16   -s_16  -93;
            0   s_16  c_16   0;
            0   0       0     1];
%[1 0 0]
Tpi_05_06=[  c_18   -s_18  0  0;
             s_18   c_18   0  0;
             0      0    1   0;
             0      0    0   1];

Tpi_06_07=[ 1 0 0 0;
            0 1 0 -33.5;
            0 0 1 0;
            0 0 0 1];

DRWN.Tpi_o_00=mlab_T_o*Tpi_o_00;
DRWN.Tpi_o_01=DRWN.Tpi_o_00*Tpi_00_01;
DRWN.Tpi_o_02=DRWN.Tpi_o_01*Tpi_01_02;
DRWN.Tpi_o_03=DRWN.Tpi_o_02*Tpi_02_03;
DRWN.Tpi_o_04=DRWN.Tpi_o_03*Tpi_03_04;
DRWN.Tpi_o_05=DRWN.Tpi_o_04*Tpi_04_05;
DRWN.Tpi_o_06=DRWN.Tpi_o_05*Tpi_05_06;
DRWN.Tpi_o_07=DRWN.Tpi_o_06*Tpi_06_07;
DRWN.Tpi_o_P1=DRWN.Tpi_o_07*[ 0 0 -52.5 1]';
DRWN.Tpi_o_P2=DRWN.Tpi_o_07*[ 0 0  52.5 1]';
DRWN.Tpi_o_P3=DRWN.Tpi_o_07*[ -23 0 52.5 1]';
DRWN.Tpi_o_P4=DRWN.Tpi_o_07*[ 43 0 52.5 1]';
DRWN.Tpi_o_P5=DRWN.Tpi_o_07*[ -23 0 -52.5 1]';
DRWN.Tpi_o_P6=DRWN.Tpi_o_07*[ 43 0 -52.5 1]';
