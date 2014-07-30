function PlotBLD_Wlk(Eje)

global WlkTab
global Robot
global Walk

%clc
global PlayPoint
PlayPoint=1;

%Coordenadas de trabajo del marco de la pelvis
CP_x=Walk.Values_1(2);
CP_y=0;
CP_z=Walk.Values_1(3);
CP_phi=Walk.Values_1(4);
CP_th=0;
CP_psi=0;

%Coordenadas angulares del brazo
Th_A=Walk.Values_1(11); %Pitch Hombro
Phi_A=Walk.Values_1(12); %Roll Hombro
Th_A1=Walk.Values_1(13); %Pitch Codo

L_2=3.85;

%Pelvis
W_R_Pel=EulYXZ_2_Rot(deg2rad(CP_phi),deg2rad(CP_th),deg2rad(CP_psi));
Robot.w_R_o=W_R_Pel;
r_Center_Pel=[CP_x CP_y CP_z].';

%Right Leg
r_Center_RA=[0 -L_2 0].';
r_RA_Pel=r_Center_Pel-r_Center_RA;
RA_T_Pel=[W_R_Pel r_RA_Pel; [0 0 0 1]];
thRLeg=bld_RHipIK(RA_T_Pel);

%Left Leg
r_Center_LA=[0 L_2 0].';
r_LA_Pel=r_Center_Pel-r_Center_LA;
LA_T_Pel=[W_R_Pel r_LA_Pel; [0 0 0 1]];
thLLeg=bld_LHipIK(LA_T_Pel);

%Asignacion de valores
ValuesTh(1)=deg2rad(-90+Th_A);
ValuesTh(3)=deg2rad(-Phi_A);
ValuesTh(5)=deg2rad(-Th_A1);

ValuesTh(2)=deg2rad(90-Th_A);
ValuesTh(4)=deg2rad(Phi_A);
ValuesTh(6)=deg2rad(Th_A1);

ValuesTh(7)=thRLeg(1);
ValuesTh(9)=thRLeg(2);
ValuesTh(11)=thRLeg(3);
ValuesTh(13)=thRLeg(4);
ValuesTh(15)=thRLeg(5);
ValuesTh(17)=thRLeg(6);

ValuesTh(8)=thLLeg(1);
ValuesTh(10)=thLLeg(2);
ValuesTh(12)=thLLeg(3);
ValuesTh(14)=thLLeg(4);
ValuesTh(16)=thLLeg(5);
ValuesTh(18)=thLLeg(6);

%Set virtual robot values
for i=1:Robot.N
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) ValuesTh(i)]);
end

%Apoyo en pie derecho (doble apoyo)
set_hip_RightSupport;

row4=[0 0 0 1];
%Transformacion homogenea del robot
w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_T_o=w_T_o;

%Posicion de la pelvis
x_o=mlab_T_o(1,4);
y_o=mlab_T_o(2,4);
z_o=mlab_T_o(3,4);

BLD=bld_DK;
 
cla(Eje);

MrkrSz=2;
LineWdt=1.5;
WlkTab.Plt_RightArm1=plot3(Eje,[x_o BLD.T_obd01(1,4) ],[y_o BLD.T_obd01(2,4) ],[z_o BLD.T_obd01(3,4) ],'-ko','MarkerSize',MrkrSz,'LineWidth',LineWdt);
hold on
%%Right Arm
WlkTab.Plt_RightArm2=plot3(Eje,  [BLD.T_obd01(1,4) BLD.T_obd02(1,4) BLD.T_obd03(1,4) BLD.T_obd05(1,4) BLD.T_obd06(1,4)],...
       [BLD.T_obd01(2,4) BLD.T_obd02(2,4) BLD.T_obd03(2,4) BLD.T_obd05(2,4) BLD.T_obd06(2,4)],...
       [BLD.T_obd01(3,4) BLD.T_obd02(3,4) BLD.T_obd03(3,4) BLD.T_obd05(3,4) BLD.T_obd06(3,4)],'-go','MarkerSize',MrkrSz,'LineWidth',LineWdt);
hold on
%%Left Arm
WlkTab.Plt_LeftArm1=plot3(Eje,  [x_o BLD.T_obi01(1,4) ],[y_o BLD.T_obi01(2,4) ],[z_o BLD.T_obi01(3,4) ],'-ko','MarkerSize',MrkrSz,'LineWidth',LineWdt);
hold on
WlkTab.Plt_LeftArm2=plot3(Eje,  [BLD.T_obi01(1,4) BLD.T_obi02(1,4) BLD.T_obi03(1,4) BLD.T_obi05(1,4) BLD.T_obi06(1,4)],...
        [BLD.T_obi01(2,4) BLD.T_obi02(2,4) BLD.T_obi03(2,4) BLD.T_obi05(2,4) BLD.T_obi06(2,4)],...
        [BLD.T_obi01(3,4) BLD.T_obi02(3,4) BLD.T_obi03(3,4) BLD.T_obi05(3,4) BLD.T_obi06(3,4)],'-ro','MarkerSize',MrkrSz,'LineWidth',LineWdt);
hold on
%%Head
w_p_cabeza=Robot.w_p_o+Robot.w_R_o*[0 0 50/10].';
w_T_cabeza=[Robot.w_R_o w_p_cabeza; row4];
mlab_T_cabeza=w_T_cabeza;

WlkTab.Plt_Head=plot3(Eje,  [x_o mlab_T_cabeza(1,4)],...
        [y_o mlab_T_cabeza(2,4)],...
        [z_o mlab_T_cabeza(3,4)],'-ko','MarkerSize',MrkrSz,'LineWidth',LineWdt);

%%Right leg
WlkTab.Plt_RightLeg1=plot3(Eje,  [x_o BLD.T_opd00a(1,4) BLD.T_opd01(1,4) ],...
        [y_o BLD.T_opd00a(2,4) BLD.T_opd01(2,4) ],...
        [z_o BLD.T_opd00a(3,4) BLD.T_opd01(3,4) ],'-ko','MarkerSize',MrkrSz,'LineWidth',LineWdt);
WlkTab.Plt_RightLeg2=plot3(Eje,  [BLD.T_opd01(1,4) BLD.T_opd03(1,4) BLD.T_opd05(1,4) BLD.T_opd05a(1,4) BLD.T_opd07(1,4) BLD.T_opd07a(1,4) BLD.T_opd09(1,4) BLD.T_opd12(1,4)],...
        [BLD.T_opd01(2,4) BLD.T_opd03(2,4) BLD.T_opd05(2,4) BLD.T_opd05a(2,4) BLD.T_opd07(2,4) BLD.T_opd07a(2,4) BLD.T_opd09(2,4) BLD.T_opd12(2,4)],...
        [BLD.T_opd01(3,4) BLD.T_opd03(3,4) BLD.T_opd05(3,4) BLD.T_opd05a(3,4) BLD.T_opd07(3,4) BLD.T_opd07a(3,4) BLD.T_opd09(3,4) BLD.T_opd12(3,4)],'-go','MarkerSize',MrkrSz,'LineWidth',LineWdt);

%%Left leg
WlkTab.Plt_LeftLeg1=plot3(Eje,  [x_o BLD.T_opi00a(1,4) BLD.T_opi01(1,4) ],...
        [y_o BLD.T_opi00a(2,4) BLD.T_opi01(2,4) ],...
        [z_o BLD.T_opi00a(3,4) BLD.T_opi01(3,4) ],'-ko','MarkerSize',MrkrSz,'LineWidth',LineWdt);
WlkTab.Plt_LeftLeg2=plot3(Eje,  [BLD.T_opi01(1,4) BLD.T_opi03(1,4) BLD.T_opi05(1,4) BLD.T_opi05a(1,4) BLD.T_opi07(1,4) BLD.T_opi07a(1,4) BLD.T_opi09(1,4) BLD.T_opi12(1,4)],...
        [BLD.T_opi01(2,4) BLD.T_opi03(2,4) BLD.T_opi05(2,4) BLD.T_opi05a(2,4) BLD.T_opi07(2,4) BLD.T_opi07a(2,4) BLD.T_opi09(2,4) BLD.T_opi12(2,4)],...
        [BLD.T_opi01(3,4) BLD.T_opi03(3,4) BLD.T_opi05(3,4) BLD.T_opi05a(3,4) BLD.T_opi07(3,4) BLD.T_opi07a(3,4) BLD.T_opi09(3,4) BLD.T_opi12(3,4)],'-ro','MarkerSize',MrkrSz,'LineWidth',LineWdt);
%%Right foot
WlkTab.Plt_lnft1=line( [BLD.T_opdb(1,4) BLD.T_opdf(1,4)],...
      [BLD.T_opdb(2,4) BLD.T_opdf(2,4)],...
      [BLD.T_opdb(3,4) BLD.T_opdf(3,4)],'Color','g','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);

WlkTab.Plt_lnft2=line( [BLD.T_opdP1(1,4) BLD.T_opdP2(1,4)],...
      [BLD.T_opdP1(2,4) BLD.T_opdP2(2,4)],...
      [BLD.T_opdP1(3,4) BLD.T_opdP2(3,4)],'Color','g','Marker','o','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);

WlkTab.Plt_lnft3=line( [BLD.T_opdP3(1,4) BLD.T_opdP4(1,4)],...
      [BLD.T_opdP3(2,4) BLD.T_opdP4(2,4)],...
      [BLD.T_opdP3(3,4) BLD.T_opdP4(3,4)],'Color','g','Marker','o','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);
hold on
%%Left foot
WlkTab.Plt_lnft4=line( [BLD.T_opib(1,4) BLD.T_opif(1,4)],...
      [BLD.T_opib(2,4) BLD.T_opif(2,4)],...
      [BLD.T_opib(3,4) BLD.T_opif(3,4)],'Color','r','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);

WlkTab.Plt_lnft5=line( [BLD.T_opiP1(1,4) BLD.T_opiP2(1,4)],...
      [BLD.T_opiP1(2,4) BLD.T_opiP2(2,4)],...
      [BLD.T_opiP1(3,4) BLD.T_opiP2(3,4)],'Color','r','Marker','o','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);

WlkTab.Plt_lnft6=line( [BLD.T_opiP3(1,4) BLD.T_opiP4(1,4)],...
      [BLD.T_opiP3(2,4) BLD.T_opiP4(2,4)],...
      [BLD.T_opiP3(3,4) BLD.T_opiP4(3,4)],'Color','r','Marker','o','MarkerSize',MrkrSz,'LineWidth',LineWdt,'parent',Eje);

xlabel('x');
ylabel('y');
zlabel('z');

if Robot.Plt_Try
    TrayWlkBLD(Eje);
end