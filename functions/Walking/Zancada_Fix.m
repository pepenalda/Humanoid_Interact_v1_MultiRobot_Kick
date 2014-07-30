function Zancada(Tipo,Values)
global TrayStride
global TrayWalk
global Robot
global Walk

%%Parametros del caminado 
CP_x=Values(2);
CP_z=Values(3);
CP_phi=Values(4);
DP_y=Values(5);
DP_th=Values(6);

DF_x=Values(7);
DF_y=Values(8);
DF_z=Values(9);
DF_psi=Values(10);

CS_th=Values(11);
DS_th=Values(14);

T =Values(15);
T_ds =Values(16);
t_ini =Values(17);
T_ss=Values(18);

if (Tipo==5 || Tipo==6) && Robot.Kick
    DF_x=Walk.Values_1(7);
    xF_max=Values(7);
    T_zFmax=Values(19);
    DF_xKick=Values(7);
end

%%Valores de epslion para zancada izquierda o derecha
switch Tipo
    case {1,3,5}
        E=-1;
    case {2,4,6}
        E=1;
end

%%Valores iniciales de una sola zancada
Th_RA=-90.0+CS_th;
Th_LA= 90.0-CS_th;
T1=((T-T_ds)/2);

L_1=4.8;
L_2=3.85;
c_psi=cosd(DF_psi);
s_psi=sind(DF_psi);

D_x_TurnP=L_1*(c_psi-1);
D_y_TurnP=L_1*s_psi;

if DF_psi>=0
    D_x_Turn_fFin=L_1*(c_psi-1)-L_2*(s_psi);
    D_y_Turn_fFin=L_1*s_psi     +L_2*(c_psi-1);
    
    D_x_Turn_fIni=L_1*(-1+c_psi)-L_2*s_psi;
    D_y_Turn_fIni=-L_1*s_psi-L_2*(-1+c_psi);
else
    D_x_Turn_fFin=L_1*(-1+c_psi)+L_2*(s_psi);
    D_y_Turn_fFin=L_1*s_psi     -L_2*(-1+c_psi);
    D_x_Turn_fIni=L_1*(-1+c_psi)+L_2*s_psi;
    D_y_Turn_fIni=-L_1*s_psi+L_2*(-1+c_psi);    
end

T_Step=T/100;
Timer=0:T_Step:T;
disp('---------------Nuevo Paso---------')
for i=1:length(Timer)
    t=Timer(i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Coordenadas del Pie Fijo
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (Tipo==1 || Tipo==2)
        Ff_x=0;
    else
        Ff_x=DF_x/4;
    end
    Ff_y=-E*L_2;
    if (Tipo==1 || Tipo==2)
    elseif (DF_y >=0) && (Tipo ==3 || Tipo == 5)
        Ff_y=Ff_y+DF_y/2;
    end
    if DF_y <=0 && (Tipo ==4 || Tipo == 6)
        Ff_y=Ff_y+DF_y/2;
    end
    Ff_psi=0;
    Ff_z=0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Desplazamiento del Pie Movil
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (Tipo==1 || Tipo==2)
        Mf_Lx=DF_x/2;
    else
        Mf_Lx=DF_x;
    end    
    if t < t_ini
        if (Tipo==1 || Tipo==2)
            Mf_x=0;
        else
            Mf_x=-Mf_Lx/4;
        end
        Mf_y=E*L_2;
        if (DF_y >=0) && ((Tipo==3) || (Tipo==5))
            Mf_y=Mf_y-DF_y/2;
        end
        if (DF_y < 0) && ((Tipo==4) || (Tipo==6))
            Mf_y=Mf_y-DF_y/2;
        end
        Mf_z=0;
        if mod(TrayWalk.Si+1,2)
            Mf_psi=0;
        else
            Mf_psi=-DF_psi;
        end
    else
        if (Tipo==5 || Tipo==6) && Robot.Kick
            T_ss1=T_ss+T_zFmax;
        else
            T_ss1=T_ss;
        end        
        if t < t_ini+T_ss1
            T_local= T_ss1;
            t_local=t-t_ini;
            if (Tipo==1 || Tipo==2)
                Mf_x=Cicloidal_1(Mf_Lx,T_local,t_local);
            elseif (Tipo==3 || Tipo==4)
                Mf_x=-Mf_Lx/4+Cicloidal_1(Mf_Lx,T_local,t_local);
            else
                if Robot.Kick
                    if t < (t_ini+T_ss/2)
                        T_local=T_ss/2;
                        Mf_x=-Mf_Lx/4+Cicloidal_3(Mf_Lx/2,T_local,t_local);
                    elseif t <(t_ini+T_ss/2+T_zFmax/2)
                        T_local=T_zFmax/2;
                        t_local=t-(t_ini+T_ss/2);
                        Mf_x=Mf_Lx/4+Cicloidal_4(DF_xKick,T_local,t_local);
                    else
                        if t < (t_ini+T_ss/2+T_zFmax)
                            t_local=t-(t_ini+T_ss/2+T_zFmax/2);
                            T_local=T_zFmax/2;
                            Mf_x=Mf_Lx/4+DF_xKick-Cicloidal_1(DF_xKick,T_local,t_local);
                        else
                            Mf_x=Mf_Lx/4;
                        end
                    end
                else
                    Mf_x=-Mf_Lx/4+Cicloidal_1(Mf_Lx/2,T_local,t_local);
                end
            end
            T_local= T_ss1;
            t_local=t-t_ini;            
            if (Tipo==1 || Tipo==2)
                Mf_y=Cicloidal_1(DF_y,T_local,t_local)+E*L_2;
            elseif ((DF_y >= 0) && ((Tipo==4) ||(Tipo==6))) || ( DF_y < 0 && Tipo==3)
                Mf_y=Cicloidal_1(DF_y,T_local,t_local)+E*L_2;
            else
                Mf_y=-DF_y/2+Cicloidal_1(DF_y,T_local,t_local)+E*L_2;
            end
            if mod(TrayWalk.Si+1,2)
                Mf_x=Mf_x+Cicloidal_1(D_x_Turn_fFin,T_local,t_local);
                Mf_y=Mf_y+Cicloidal_1(D_y_Turn_fFin,T_local,t_local);
                Mf_psi=Cicloidal_1(DF_psi,T_local,t_local);
            else
                Mf_x=Mf_x-Cicloidal_1(D_x_Turn_fIni,T_local,t_local);
                Mf_y=Mf_y-Cicloidal_1(D_y_Turn_fIni,T_local,t_local);
                Mf_psi=-DF_psi+Cicloidal_1(DF_psi,T_local,t_local);
            end    
            if (Tipo==5 || Tipo==6) && Robot.Kick
                if t < (t_ini+T_ss/2)
                    T_local=T_ss/2;
                    Mf_z=Cicloidal_1(DF_z,T_local,t_local);
                elseif t <(t_ini+T_ss/2+T_zFmax)
                    Mf_z=DF_z;
                else
                    T_local=T_ss/2;
                    t_local=t-(t_ini+T_ss/2+T_zFmax);
                    Mf_z=DF_z-Cicloidal_1(DF_z,T_local,t_local);
                end
            else
                Mf_z=Cicloidal_2(DF_z,T_local,t_local);
            end
        else
            if (Tipo==1 || Tipo==2)
                Mf_x=Mf_Lx;
            elseif (Tipo==3 || Tipo==4)
                Mf_x=3*Mf_Lx/4;
            else
                Mf_x=Mf_Lx/4;
            end
            if (Tipo==1 || Tipo==2)
                Mf_y=DF_y+E*L_2;
            elseif ((DF_y >= 0) && ((Tipo==4) ||(Tipo==6)) ) || ( DF_y < 0 && Tipo==3)
                Mf_y=DF_y+E*L_2;
            else
                Mf_y=DF_y/2+E*L_2;
            end
            if mod(TrayWalk.Si+1,2)
                Mf_x=Mf_x+D_x_Turn_fFin;
                Mf_y=Mf_y+D_y_Turn_fFin;
                Mf_psi=DF_psi;
            else
                Mf_x=Mf_x-D_x_Turn_fIni;
                Mf_y=Mf_y-D_y_Turn_fIni;                
                Mf_psi=0;
            end
            Mf_z=0.0;
        end
    end
    if mod(TrayWalk.Si+1,2)
    else
        Mf_x=Mf_x+D_x_Turn_fIni;
        Mf_y=Mf_y+D_y_Turn_fIni;
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Desplazamiento de la pelvis
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    P_Lx=Mf_Lx/2;
    if (Tipo==1) || (Tipo == 2)
        P_x=Cicloidal_3(P_Lx+D_x_TurnP,T,t);
    elseif Tipo==3 || Tipo == 4
        P_x=DF_x/2*(t/T);
    else
        P_x=Cicloidal_4(DF_x/4,T,t);
    end
    if mod(TrayWalk.Si+1,2)
        P_psi=Cicloidal_3(DF_psi,T,t);
    else
        P_psi=0;
    end    
    P_Ly=DF_y/2;
    if ( DF_y <=0 && (Tipo==3 || Tipo==5) ) || ( DF_y >=0 && (Tipo==4 || Tipo==6) )
        P_Ly1=-E*DP_y;
    elseif (DF_y >=0) && (Tipo==3 || Tipo==5)
        P_Ly1=-E*(DP_y+P_Ly);
    else
        P_Ly1=-E*(DP_y-P_Ly);
    end
    if (t < T1)
        if Tipo==1 || Tipo == 2
            P_y=-E*Cicloidal_1(DP_y,T1,t);
        else
            P_y=Cicloidal_4(P_Ly1,T1,t);
        end
        P_th=E*Cicloidal_1(DP_th,T1,t);
    else
        if (t < T1+T_ds)
            if Tipo==1 || Tipo == 2
                P_y=-E*DP_y;
            else
                P_y=P_Ly1;
            end
            P_th=E*DP_th;
        else
            T_local=T1;
            t_local=t-(T1+T_ds);
            if Tipo==1 || Tipo == 2
                P_Ly2=P_Ly+E*DP_y;
                P_y=-E*DP_y+Cicloidal_3(P_Ly2,T_local,t_local);
            elseif (DF_y <= 0 && (Tipo==3 || Tipo==5)) || (DF_y > 0 && (Tipo==4 || Tipo==6))
                P_Ly2=-E*DP_y-P_Ly;
                P_y=-E*DP_y-Cicloidal_3(P_Ly2,T_local,t_local);
            elseif (DF_y >= 0 && (Tipo==3 || Tipo==5))
                P_y=P_Ly+Cicloidal_5(DP_y,T_local,t_local);
            else
                P_Ly2=-(DP_y-P_Ly);
                P_y=P_Ly2+Cicloidal_3(DP_y,T_local,t_local);
            end
            if Tipo==1 || Tipo == 2
                P_th=E*(DP_th-Cicloidal_1(DP_th,T_local,t_local));
            else
                P_th=E*DP_th-E*Cicloidal_1(DP_th,T_local,t_local);
            end
            if mod(TrayWalk.Si+1,2)
                %disp('aqui Añade y')
                P_y=P_y+Cicloidal_1(D_y_TurnP,T_local,t_local);
            else
                P_psi=0;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Desplazamiento de los brazos
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    switch Tipo
        case {1,2}
            Th_RA=-90.0+ CS_th+E*Cicloidal_1(DS_th/2,T,t);
            Th_LA= 90.0- CS_th+E*Cicloidal_1(DS_th/2,T,t);
        case {3,4}
            Th_RA=-90.0+ CS_th-E*(DS_th/2-Cicloidal_1(DS_th,T,t));
            Th_LA= 90.0- CS_th-E*(DS_th/2-Cicloidal_1(DS_th,T,t));
        case {5,6}
            Th_RA=-90.0+ CS_th-E*(DS_th/2-Cicloidal_1(DS_th/2,T,t));
            Th_LA= 90.0- CS_th-E*(DS_th/2-Cicloidal_1(DS_th/2,T,t));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Asignación de los pies de apoyo y movil a Izquierda o derecha
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    switch Tipo
        case {1,3,5}
            LF_x=Ff_x;
            Lf_y=Ff_y;
            LF_z=Ff_z;
            LF_psi=Ff_psi;
            
            Rf_x=Mf_x;
            Rf_y=Mf_y;
            Rf_z=Mf_z;
            Rf_psi=Mf_psi;
        case {2,4,6}
            LF_x=Mf_x;
            Lf_y=Mf_y;
            LF_z=Mf_z;
            LF_psi=Mf_psi;
            
            Rf_x=Ff_x;
            Rf_y=Ff_y;
            Rf_z=Ff_z;
            Rf_psi=Ff_psi;
    end
    
    % Offset en la posición de la pelvis
    P_x=P_x+CP_x;
    P_z=CP_z;
    
    %Trayectorias de una sola zancada
    
    %Pelvis
    TrayStride.P_x(i)=P_x;
    TrayStride.P_y(i)=P_y;
    TrayStride.P_z(i)=P_z;
    TrayStride.P_phi(i)=CP_phi;
    TrayStride.P_th(i)=P_th;
    TrayStride.P_psi(i)=P_psi;
    
    %Pie Derecho
    TrayStride.Rf_x(i)=Rf_x;
    TrayStride.Rf_y(i)=Rf_y;
    TrayStride.Rf_z(i)=Rf_z;
    TrayStride.Rf_phi(i)=0;
    TrayStride.Rf_th(i)=0;
    TrayStride.Rf_psi(i)=Rf_psi;
    
    %Pie Izquierdo
    TrayStride.Lf_x(i)=LF_x;
    TrayStride.Lf_y(i)=Lf_y;
    TrayStride.Lf_z(i)=LF_z;
    TrayStride.Lf_phi(i)=0;
    TrayStride.Lf_th(i)=0;
    TrayStride.Lf_psi(i)=LF_psi;

    TrayStride.th_LA(i)=Th_RA;
    TrayStride.th_RA(i)=Th_LA;
    
    TrayStride.t(i)=t;
    
    %Cinematica Inversa para trayectorias angulares
    switch Tipo
        case {1,3,5}
            th=MoverPelvisYPieDerecho(i,Values);
            thV(:,i)=th.';
        case {2, 4, 6}
            th=MoverPelvisYPieIzquierdo(i,Values);
            thV(:,i)=th.';
    end
end
%Trayectorias de todos los pasos

%Walk.TW.GuinadaPelvisGlobal_Zancada{Walk.Si+1}=floor((Walk.Si+1)/2)*DF_psi;
%Pelvis
%TrayWalk.P_x{1}=[];
TrayWalk.P_x{TrayWalk.Si+1}=TrayStride.P_x;
TrayWalk.P_y{TrayWalk.Si+1}=TrayStride.P_y;
TrayWalk.P_z{TrayWalk.Si+1}=TrayStride.P_z+2.95; %Altura del tobillo
TrayWalk.P_phi{TrayWalk.Si+1}=TrayStride.P_phi; %+Global_Int_AlabeoTroncoC;
TrayWalk.P_th{TrayWalk.Si+1}=TrayStride.P_th;
TrayWalk.P_psi{TrayWalk.Si+1}=TrayStride.P_psi;

%Pie derecho
TrayWalk.Rf_x{TrayWalk.Si+1}=TrayStride.Rf_x;
TrayWalk.Rf_y{TrayWalk.Si+1}=TrayStride.Rf_y;
TrayWalk.Rf_z{TrayWalk.Si+1}=TrayStride.Rf_z;
TrayWalk.Rf_phi{TrayWalk.Si+1}=TrayStride.Rf_phi;
TrayWalk.Rf_th{TrayWalk.Si+1}=TrayStride.Rf_th;
TrayWalk.Rf_psi{TrayWalk.Si+1}=TrayStride.Rf_psi;

%Pie izquierdo
TrayWalk.Lf_x{TrayWalk.Si+1}=TrayStride.Lf_x;
TrayWalk.Lf_y{TrayWalk.Si+1}=TrayStride.Lf_y;
TrayWalk.Lf_z{TrayWalk.Si+1}=TrayStride.Lf_z;
TrayWalk.Lf_phi{TrayWalk.Si+1}=TrayStride.Lf_phi;
TrayWalk.Lf_th{TrayWalk.Si+1}=TrayStride.Lf_th;
TrayWalk.Lf_psi{TrayWalk.Si+1}=TrayStride.Lf_psi;

TrayWalk.th{TrayWalk.Si+1}=thV;

TrayWalk.t{TrayWalk.Si+1}=TrayStride.t;  %Tiempo
%TrayWalk.Ths_Zancada{TrayWalk.Si+1}=thV; %Angulos
TrayWalk.Si=TrayWalk.Si+1;  %Indice de la Zancada

function th=MoverPelvisYPieDerecho(i,Values)
global TrayStride  
XPelvis(1)=TrayStride.P_x(i);
XPelvis(2)=TrayStride.P_y(i);
XPelvis(3)=TrayStride.P_z(i);
XPelvis(4)=deg2rad(TrayStride.P_phi(i));
XPelvis(5)=deg2rad(TrayStride.P_th(i));
XPelvis(6)=deg2rad(TrayStride.P_psi(i));
%Left Leg
PieIzq_Rot_Pel=EulYXZ_2_Rot(XPelvis(4),XPelvis(5),XPelvis(6));

rCenterPelvis(1)=XPelvis(1);
rCenterPelvis(2)=XPelvis(2);
rCenterPelvis(3)=XPelvis(3);

rCenterLA(1)=TrayStride.Lf_x(i);
rCenterLA(2)=TrayStride.Lf_y(i);
rCenterLA(3)=TrayStride.Lf_z(i);

s=sprintf('x_Lf=%2.2f y_Lf=%2.2f',TrayStride.Lf_x(i),TrayStride.Lf_y(i));
disp(s);
s=sprintf('x=%2.2f y=%2.2f  psi=%2.2f',TrayStride.P_x(i),TrayStride.P_y(i),TrayStride.P_psi(i));
disp(s);


rLA_Pelvis=(rCenterPelvis - rCenterLA).';
H_LHip=[PieIzq_Rot_Pel rLA_Pelvis;[0 0 0 1] ];
ThLLeg=bld_LHipIK(H_LHip);

%Right Leg
W_Rot_PieDer=EulYXZ_2_Rot(0,0,deg2rad(TrayStride.Rf_psi(i)));
Pel_Rot_PieDer=PieIzq_Rot_Pel.'*W_Rot_PieDer;

r_Center_RA(1)=TrayStride.Rf_x(i);
r_Center_RA(2)=TrayStride.Rf_y(i);
r_Center_RA(3)=TrayStride.Rf_z(i);

r_RA_Pel=rCenterPelvis-r_Center_RA;

H_RHip=[Pel_Rot_PieDer.'  W_Rot_PieDer.'*r_RA_Pel.';[0 0 0 1] ];
ThRLeg=bld_RHipIK(H_RHip);
IDs_RLeg=[7 9 11 13 15 17];
IDs_LLeg=[8 10 12 14 16 18];

th(1)=deg2rad(TrayStride.th_LA(i));
th(3)=deg2rad(-Values(12));
th(5)=deg2rad(-Values(13));

th(2)=deg2rad(TrayStride.th_RA(i));
th(4)=deg2rad(Values(12));
th(6)=deg2rad(Values(13));

for j=1:6
    Index_RLeg=IDs_RLeg(j);
    Index_LLeg=IDs_LLeg(j);
    th(Index_RLeg)=ThRLeg(j);
    th(Index_LLeg)=ThLLeg(j);
end

function th=MoverPelvisYPieIzquierdo(i,Values)
global TrayStride
XPelvis(1)=TrayStride.P_x(i);
XPelvis(2)=TrayStride.P_y(i);
XPelvis(3)=TrayStride.P_z(i);
XPelvis(4)=deg2rad(TrayStride.P_phi(i));
XPelvis(5)=deg2rad(TrayStride.P_th(i));
XPelvis(6)=deg2rad(TrayStride.P_psi(i));

rCenterPelvis(1)=XPelvis(1);
rCenterPelvis(2)=XPelvis(2);
rCenterPelvis(3)=XPelvis(3);

%Right Leg
EulInPel=[XPelvis(4) XPelvis(5) XPelvis(6)]
PieDer_Rot_Pel=EulYXZ_2_Rot(XPelvis(4),XPelvis(5),XPelvis(6));

rCenterRA(1)=TrayStride.Rf_x(i);
rCenterRA(2)=TrayStride.Rf_y(i);
rCenterRA(3)=TrayStride.Rf_z(i);
    
rRA_PelvisC=(rCenterPelvis-rCenterRA).';
H_RHip=[PieDer_Rot_Pel  rRA_PelvisC;[0 0 0 1] ];
ThRLeg=bld_RHipIK(H_RHip);

%Left Leg
W_Rot_PieIzq=EulYXZ_2_Rot(0,0,deg2rad(TrayStride.Lf_psi(i)));
LF_R_Pel=W_Rot_PieIzq.'*PieDer_Rot_Pel;
Eul=Rot2Eul_YXZ(LF_R_Pel)*180/pi

rCenterLA(1)=TrayStride.Lf_x(i);
rCenterLA(2)=TrayStride.Lf_y(i);
rCenterLA(3)=TrayStride.Lf_z(i);

% s=sprintf('x_Lf=%2.2f y_Lf=%2.2f',TrayStride.Lf_x(i),TrayStride.Lf_y(i));
% disp(s);
% s=sprintf('x=%2.2f y=%2.2f  psi=%2.2f',TrayStride.P_x(i),TrayStride.P_y(i),TrayStride.P_psi(i));
% disp(s);

rLA_Pelvis=rCenterPelvis-rCenterLA;
H_LHip=[LF_R_Pel W_Rot_PieIzq.'*rLA_Pelvis.';[0 0 0 1] ];
ThLLeg=bld_LHipIK(H_LHip);
IDs_RLeg=[7 9 11 13 15 17];
IDs_LLeg=[8 10 12 14 16 18];

th(1)=deg2rad(TrayStride.th_LA(i));
th(3)=deg2rad(-Values(12));
th(5)=deg2rad(-Values(13));

th(2)=deg2rad(TrayStride.th_RA(i));
th(4)=deg2rad(Values(12));
th(6)=deg2rad(Values(13));

for j=1:6
    Index_RLeg=IDs_RLeg(j);
    Index_LLeg=IDs_LLeg(j);
    th(Index_RLeg)=ThRLeg(j);
    th(Index_LLeg)=ThLLeg(j);
end

function f=Cicloidal_1(A,T,t)
f=A*(t/T-(1/(2*pi))*sin(2*pi*t/T));

function f = Cicloidal_2(A,T,t)
f=A*sin(pi/2*(2*t/T-(1/pi)*sin(2*pi*t/T)));

function f=Cicloidal_3(A,T,t)
f=A*(t/T-(1/pi)*sin(pi*t/T));

function f=Cicloidal_4(A,T,t)
f=A*(t/T+(1/pi)*sin(pi*t/T));

function f=Cicloidal_5(A,T,t)
f=A-A*(t/T-(1/pi)*sin(pi*t/T));
