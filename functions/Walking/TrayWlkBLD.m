function TrayWlkBLD(Eje)

%clc
global Strct_MainFigure
global WlkTab
global PltTryTab
global Walk
global TrayWalk
global Walking
global Robot

global PlotTrayPelvis PlotTrayPieIzq PlotTrayPieDer

%Algoritmo de marcha
TrayWalk.Si=0;  %Variable necesaria en la funcion Zancada
N=Walk.Values_1(1); %Numero de pasos

TrayWalk.P_x=[];
TrayWalk.P_y=[];
TrayWalk.P_z=[];
TrayWalk.P_phi=[];
TrayWalk.P_th=[];
TrayWalk.P_psi=[];

TrayWalk.Rf_x=[];
TrayWalk.Rf_y=[];
TrayWalk.Rf_z=[];
TrayWalk.Rf_phi=[];
TrayWalk.Rf_th=[];
TrayWalk.Rf_psi=[];

TrayWalk.Lf_x=[];
TrayWalk.Lf_y=[];
TrayWalk.Lf_z=[];
TrayWalk.Lf_phi=[];
TrayWalk.Lf_th=[];
TrayWalk.Lf_psi=[];

Robot.Kick;
for j=1:N
    if j==1                 %%%Primer Paso
        Values=Walk.Values_1;
        if IsRight==1
            Type=1;         %InicioDerecha
        else
            Type=2;         %InicioIzquierda
        end
    elseif j==N             %%%Ultimo Paso
        if Robot.Kick
            Values=Walk.Values_4;
        else
            Values=Walk.Values_1;
        end
        if (Type==4) ||  (Type==2)         %Izquierda
            Type=5;         %FinDerecha
        else
            Type=6;         %FinIzquierda
        end
    else                    %%%Pasos Intermedios
        Values=Walk.Values_1;
        switch Type
            case 1          %InicioDerecha
                Type=4;     %Izquierda
            case 2          %InicioIzquierda
                Type=3;     %Derecha
            case 3          %Derecha
                Type=4;     %Izquierda
            case 4          %Izquierda
                Type=3;     %Derecha
        end
    end
    Zancada(Type,Values);
end

%Genera las trayectorias globales de marcha
Values_1=Walk.Values_1;

%%Parametros del caminado 
CP_x=Values_1(2);
D_x=Values_1(7);
D_y=Values_1(8); 
DF_psi=Values_1(10); 

IndiceFinal=length(TrayWalk.t{1});
TrayWalk.T_Final=TrayWalk.t{1}(IndiceFinal);


Index=0;
for i=1:N
    if i==1
        Walking.P_x=[TrayWalk.P_x{i}];
        Walking.P_y=[TrayWalk.P_y{i}];
        Walking.P_z=[TrayWalk.P_z{i}];

        Walking.P_phi=[TrayWalk.P_phi{i}];
        Walking.P_th=[TrayWalk.P_th{i}];
        Walking.P_psi=[TrayWalk.P_psi{i}];
        
        Walking.Lf_x=[TrayWalk.Lf_x{i}];
        Walking.Lf_y=[TrayWalk.Lf_y{i}];
        Walking.Lf_z=[TrayWalk.Lf_z{i}];
        Walking.Lf_phi=[TrayWalk.Lf_phi{i}];
        Walking.Lf_th=[TrayWalk.Lf_th{i}];
        Walking.Lf_psi=[TrayWalk.Lf_psi{i}];
        
        Walking.Rf_x=[TrayWalk.Rf_x{i}];
        Walking.Rf_y=[TrayWalk.Rf_y{i}];
        Walking.Rf_z=[TrayWalk.Rf_z{i}];        
        Walking.Rf_phi=[TrayWalk.Rf_phi{i}];
        Walking.Rf_th=[TrayWalk.Rf_th{i}];
        Walking.Rf_psi=[TrayWalk.Rf_psi{i}];
        Walking.th=TrayWalk.th{i};
        Walking.t=TrayWalk.t{i};
    else
        if not(mod(i,2))
            L_Lf_x=-D_x/4;
            L_Rf_x=D_x/4;
            Index=Index+1;
        else
            L_Lf_x=D_x/4;
            L_Rf_x=-D_x/4;
        end        
        if IsRight
            L_Lf_x=-L_Lf_x;
            L_Rf_x=-L_Rf_x;            
        end
        Global_psi=Index*DF_psi
        L_Lf_y=((i-1)*D_y/2);
        L_Rf_y=(i-1)*D_y/2;
        Rot=EulYXZ_2_Rot(0,0,Global_psi*pi/180);
        Walking.P_x=[Walking.P_x Rot(1,1)*(Walking.P_x(length(Walking.P_x))+TrayWalk.P_x{i}-CP_x)+Rot(1,2)*(Walking.P_y(length(Walking.P_y))+TrayWalk.P_y{i})];
        Walking.P_y=[Walking.P_y Rot(2,1)*(Walking.P_x(length(Walking.P_x))+TrayWalk.P_x{i}-CP_x)+Rot(2,2)*(Walking.P_y(length(Walking.P_y))+TrayWalk.P_y{i})];
        Walking.P_z=[Walking.P_z TrayWalk.P_z{i}];
        
        Walking.P_phi=[Walking.P_phi TrayWalk.P_phi{i}];
        Walking.P_th=[Walking.P_th TrayWalk.P_th{i}];
        Walking.P_psi=[Walking.P_psi Walking.P_psi(length(Walking.P_psi))+TrayWalk.P_psi{i}];

        Walking.Lf_x=[Walking.Lf_x L_Lf_x+Walking.Lf_x(length(Walking.Lf_x))+TrayWalk.Lf_x{i}];
        Walking.Lf_y=[Walking.Lf_y L_Lf_y+TrayWalk.Lf_y{i}];
        Walking.Lf_z=[Walking.Lf_z TrayWalk.Lf_z{i}];
        Walking.Lf_phi=[Walking.Lf_phi TrayWalk.Lf_phi{i}];
        Walking.Lf_th=[Walking.Lf_th TrayWalk.Lf_th{i}];
        Walking.Lf_psi=[Walking.Lf_psi Walking.Lf_psi(length(Walking.Lf_psi))+TrayWalk.Lf_psi{i}];
%         
%         if D_x==0 && ne(DF_psi,0)
%             Walking.Rf_x=[Walking.Rf_x L_Rf_x+(TrayWalk.Rf_x{i})*cosd(D_Psi)-(TrayWalk.Rf_y{i})*sind(D_Psi)-D_Rfx];
%         else
%             Walking.Rf_x=[Walking.Rf_x L_Rf_x+Walking.Rf_x(length(Walking.Rf_x))+(TrayWalk.Rf_x{i})*cosd(D_Psi)-(TrayWalk.Rf_y{i})*sind(D_Psi)];
%         end
        Walking.Rf_x=[Walking.Rf_x L_Rf_x+Walking.Rf_x(length(Walking.Rf_x))+TrayWalk.Rf_x{i}];
        Walking.Rf_y=[Walking.Rf_y L_Rf_y+(TrayWalk.Rf_y{i})];
        Walking.Rf_z=[Walking.Rf_z TrayWalk.Rf_z{i}];
        Walking.Rf_phi=[Walking.Rf_phi TrayWalk.Rf_phi{i}];
        Walking.Rf_th=[Walking.Rf_th TrayWalk.Rf_th{i}];
        Walking.Rf_psi=[Walking.Rf_psi Walking.Rf_psi(length(Walking.Rf_psi))+TrayWalk.Rf_psi{i}];
        
        Walking.th=[Walking.th TrayWalk.th{i}];
        
        Walking.t=[Walking.t (i-1)*TrayWalk.T_Final+TrayWalk.t{i}];
        
    end

end

clear xPlotTrayPelvis
PlotTrayPelvis=plot3(Eje,Walking.P_x,Walking.P_y,Walking.P_z,'-k');
PlotTrayPieIzq=plot3(Eje,Walking.Lf_x,Walking.Lf_y,Walking.Lf_z,'-r');
PlotTrayPieDer=plot3(Eje,Walking.Rf_x,Walking.Rf_y,Walking.Rf_z,'-g');

%Setea los valores del slider y del Edit para la animacion

if isfield(Strct_MainFigure,'Panel_WalkTab')
    Slider_Time=WlkTab.Slider_TimePlayAnimation;
    PopupMenu=WlkTab.PpupMenu_Acelerar;
    Edit_Time=WlkTab.Edit_TimePlayAnimation;
else
    Slider_Time=PltTryTab.Slider_TimePlayAnimation;
    PopupMenu=PltTryTab.PpupMenu_Acelerar;
    Edit_Time=PltTryTab.Edit_TimePlayAnimation;    
end

getDynamics;

set(Slider_Time,'min',0);
set(Slider_Time,'max',Walking.t(length(Walking.t)));
Acelerar=get(PopupMenu,'Value');
switch Acelerar
    case 1
        Paso=1;
    case 2
        Paso=2;
    case 3
        Paso=5;
    case 4
        Paso=10;
end
step=Walking.t/(length(Walking.t)/Paso);
SldrStp=(step/Walking.t);
set(Slider_Time,'sliderstep',[SldrStp 3*SldrStp]);

set(Slider_Time,'Value',0);
set(Edit_Time,'String',num2str(0));
% 

function Right=IsRight
global Robot

if Robot.Drcha
    Right=1;
else
    Right=0;
end

