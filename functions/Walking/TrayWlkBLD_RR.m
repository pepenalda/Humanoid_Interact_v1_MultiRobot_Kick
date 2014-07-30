function TrayWlkBLD_RR(ValorSensado)
%clc

global RR_TrayWalk
global RR_Walking
global Walk

%Genera las trayectorias globales de marcha
Values_1=Walk.Values_1;

%%Parametros del caminado
N=Values_1(1);
CP_x=Values_1(2);
D_x=Values_1(7);
D_y=Values_1(8);
DF_psi=Values_1(10);

IndiceFinal=length(RR_TrayWalk.t{1});
RR_TrayWalk.T_Final=RR_TrayWalk.t{1}(IndiceFinal);

L_1=4.8;
L_2=3.85;

c_th=cosd(DF_psi);
s_th=sind(DF_psi);

R_01=[ c_th -s_th;
    s_th  c_th];
R_10=R_01';

r_AB_0=[0; L_2];
r_AC_0=[0; -L_2];
r_ApCp_1=[0; -L_2];
r_0Bp_1=[L_1; L_2];
r_0B_0=[L_1; L_2];

r_BBp_0=R_01*r_0Bp_1-r_0B_0;

D_x_Turn_fFin=r_BBp_0(1);
D_y_Turn_fFin=r_BBp_0(2);

r_0A_0=[L_1; 0];
r_0Ap_1=[L_1; 0];

r_AAp_0=R_01*r_0Ap_1-r_0A_0;

D_x_TurnP=r_AAp_0(1);
D_y_TurnP=r_AAp_0(2);

r_ApA_0=-r_AAp_0;
r_ApC_0=r_ApA_0+r_AC_0;
r_ApC_1=R_10*r_ApC_0;

r_CpC_1=r_ApC_1-r_ApCp_1;

r_CpC_0=R_01*r_CpC_1;

D_x_Turn_fIni=r_CpC_1(1);
D_y_Turn_fIni=r_CpC_1(2);

A=D_x_TurnP-D_x_Turn_fIni;
B=D_y_TurnP+D_y_Turn_fIni;

Index=0;

for i=1:N
    if i==1
        if ValorSensado==5
            RR_Walking.P_x=[RR_TrayWalk.P_x{i}];
            RR_Walking.P_y=[RR_TrayWalk.P_y{i}];
            RR_Walking.P_z=[RR_TrayWalk.P_z{i}];
            RR_Walking.P_phi=[RR_TrayWalk.P_phi{i}];
            RR_Walking.P_th=[RR_TrayWalk.P_th{i}];
            RR_Walking.P_psi=[RR_TrayWalk.P_psi{i}];
        end
        if ValorSensado==6
            RR_Walking.Rf_x=[RR_TrayWalk.Rf_x{i}];
            RR_Walking.Rf_y=[RR_TrayWalk.Rf_y{i}];
            RR_Walking.Rf_z=[RR_TrayWalk.Rf_z{i}];
            RR_Walking.Rf_phi=[RR_TrayWalk.Rf_phi{i}];
            RR_Walking.Rf_th=[RR_TrayWalk.Rf_th{i}];
            RR_Walking.Rf_psi=[RR_TrayWalk.Rf_psi{i}];
        end
        if ValorSensado==7
            RR_Walking.Lf_x=[RR_TrayWalk.Lf_x{i}];
            RR_Walking.Lf_y=[RR_TrayWalk.Lf_y{i}];
            RR_Walking.Lf_z=[RR_TrayWalk.Lf_z{i}];
            RR_Walking.Lf_phi=[RR_TrayWalk.Lf_phi{i}];
            RR_Walking.Lf_th=[RR_TrayWalk.Lf_th{i}];
            RR_Walking.Lf_psi=[RR_TrayWalk.Lf_psi{i}];
        end
        %RR_Walking.th=RR_TrayWalk.th{i};
        RR_Walking.t=RR_TrayWalk.t{i};
    else
        if ValorSensado==5
        if not(mod(i,2))
            L_Lf_x=-D_x/4;
            L_Rf_x=D_x/4;
            Index=Index+1;
            D_Psi1=(Index-1)*DF_psi;
        else
            L_Lf_x=D_x/4;
            L_Rf_x=-D_x/4;
            D_Psi1=0;
        end
        if IsRight
            L_Lf_x=-L_Lf_x;
            L_Rf_x=-L_Rf_x;
            %D_Psi=RR_Walking.Rf_psi(length(RR_Walking.Lf_psi));
            D_Psi=RR_Walking.P_psi(length(RR_Walking.P_psi));
        else
            %D_Psi=RR_Walking.Lf_psi(length(RR_Walking.Lf_psi));
            D_Psi=RR_Walking.P_psi(length(RR_Walking.P_psi));
        end
        L_Lf_y=((i-1)*D_y/2);
        L_Rf_y=(i-1)*D_y/2;
            RR_Walking.P_x=[RR_Walking.P_x RR_Walking.P_x(length(RR_Walking.P_x))+RR_TrayWalk.P_x{i}*cosd(D_Psi)-RR_TrayWalk.P_y{i}*sind(D_Psi)-CP_x];
            RR_Walking.P_y=[RR_Walking.P_y RR_Walking.P_y(length(RR_Walking.P_y))+RR_TrayWalk.P_y{i}*cosd(D_Psi)+RR_TrayWalk.P_x{i}*sind(D_Psi)];
            RR_Walking.P_z=[RR_Walking.P_z RR_TrayWalk.P_z{i}];
            RR_Walking.P_phi=[RR_Walking.P_phi RR_TrayWalk.P_phi{i}];
            RR_Walking.P_th=[RR_Walking.P_th RR_TrayWalk.P_th{i}];
            RR_Walking.P_psi=[RR_Walking.P_psi RR_Walking.P_psi(length(RR_Walking.P_psi))+RR_TrayWalk.P_psi{i}];
        end
        if ValorSensado==6
            if not(mod(i,2))
                L_Lf_x=-D_x/4;
                L_Rf_x=D_x/4;
                Index=Index+1;
                D_Psi1=(Index-1)*DF_psi;
            else
                L_Lf_x=D_x/4;
                L_Rf_x=-D_x/4;
                D_Psi1=0;
            end
            Index;
            if mod(i,2)
                D_Rfx=A;
            else
                D_Rfx=A+(Index-1)*(A*cosd(D_Psi1*Index)+B*sind(D_Psi1*Index)-RR_Walking.Rf_x(length(RR_Walking.Rf_x)));
            end
            L_Rf_y=(i-1)*D_y/2;            
            RR_Walking.Rf_x=[RR_Walking.Rf_x L_Rf_x+RR_Walking.Rf_x(length(RR_Walking.Rf_x))+RR_TrayWalk.Rf_x{i}];
            RR_Walking.Rf_y=[RR_Walking.Rf_y L_Rf_y+RR_TrayWalk.Rf_y{i}];
            RR_Walking.Rf_z=[RR_Walking.Rf_z RR_TrayWalk.Rf_z{i}];
            RR_Walking.Rf_phi=[RR_Walking.Rf_phi RR_TrayWalk.Rf_phi{i}];
            RR_Walking.Rf_th=[RR_Walking.Rf_th RR_TrayWalk.Rf_th{i}];
            RR_Walking.Rf_psi=[RR_Walking.Rf_psi RR_Walking.Rf_psi(length(RR_Walking.Rf_psi))+RR_TrayWalk.Rf_psi{i}];
        end
        if ValorSensado==7
            if not(mod(i,2))
                L_Lf_x=-D_x/4;
                L_Rf_x=D_x/4;
                Index=Index+1;
                D_Psi1=(Index-1)*DF_psi;
            else
                L_Lf_x=D_x/4;
                L_Rf_x=-D_x/4;
                D_Psi1=0;
            end
            if D_x==0 && ne(DF_psi,0)
                RR_Walking.Lf_x=[RR_Walking.Lf_x L_Lf_x+(-r_CpC_1(1)+RR_TrayWalk.Lf_x{i})*cosd(D_Psi1)-(-r_CpC_1(2)+RR_TrayWalk.Lf_y{i})*sind(D_Psi1)-D_Lfx];
            else
                RR_Walking.Lf_x=[RR_Walking.Lf_x L_Lf_x+RR_Walking.Lf_x(length(RR_Walking.Lf_x))+(-r_CpC_1(1)+RR_TrayWalk.Lf_x{i})*cosd(D_Psi1)-(-r_CpC_1(2)+RR_TrayWalk.Lf_y{i})*sind(D_Psi1)];
            end
            L_Lf_y=((i-1)*D_y/2);
            RR_Walking.Lf_y=[RR_Walking.Lf_y L_Lf_y+(-r_CpC_1(2)+RR_TrayWalk.Lf_y{i})*cosd(D_Psi1)+(-r_CpC_1(1)+RR_TrayWalk.Lf_x{i})*sind(D_Psi1)-B];
            RR_Walking.Lf_z=[RR_Walking.Lf_z RR_TrayWalk.Lf_z{i}];
            RR_Walking.Lf_phi=[RR_Walking.Lf_phi RR_TrayWalk.Lf_phi{i}];
            RR_Walking.Lf_th=[RR_Walking.Lf_th RR_TrayWalk.Lf_th{i}];
            RR_Walking.Lf_psi=[RR_Walking.Lf_psi RR_Walking.Lf_psi(length(RR_Walking.Lf_psi))+RR_TrayWalk.Lf_psi{i}];
        end
        %RR_Walking.th=[RR_Walking.th RR_TrayWalk.th{i}];
        RR_Walking.t=[RR_Walking.t (i-1)*RR_TrayWalk.T_Final+RR_TrayWalk.t{i}];
    end
end
disp('Se genero la estructura RR_Walking');

function Right=IsRight
global WlkTab
if get(WlkTab.uiPnl_RdBttnDerecha,'Value') == 1
    Right=1;
else
    Right=0;
end