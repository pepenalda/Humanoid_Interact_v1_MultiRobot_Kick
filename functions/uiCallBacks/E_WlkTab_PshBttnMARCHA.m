function E_WlkTab_PshBttnMARCHA(ClickedBttnMARCHA)
global WlkTab
global Cnnct

key=str2num(get(ClickedBttnMARCHA,'Tag'))-1;
switch Cnnct.CnnctnType
    case 1
        switch key
            case '0'
                bld_RST
            case '1'
                bld_PC
            case '2'
                bld_WLK
        end
    case 2
    case 3
       switch key
            case 0
                fnc_LanzaUnDato('0');
           case 1
               fnc_LanzaUnDato('1');
           case 2
               if get(WlkTab.uiPnl_RdBttnIzquierda,'Value')==1
                   fnc_LanzaUnDato('2');
               else
                   fnc_LanzaUnDato('3');
               end
               if get(WlkTab.RdBttn_Sensado,'Value')
                   Value=get(WlkTab.PpUp_Sensado,'Value');
                   switch Value
                       case 1
                           fnc_LanzaUnDato('A');
                       case 2
                           fnc_LanzaUnDato('B');
                       case 3
                           fnc_LanzaUnDato('C');
                       case 4
                           fnc_LanzaUnDato('D');
                       case 5
                           fnc_LanzaUnDato('E');
                       case 6
                           fnc_LanzaUnDato('F');
                       case 7
                           fnc_LanzaUnDato('G');
                   end
                   if get(WlkTab.PshBttn_Kick,'value')==1
                       fnc_LanzaUnDato(1);
                   else
                       fnc_LanzaUnDato(0);
                   end                   
                   Lee_Datos_Robot;
               else
                   fnc_LanzaUnDato('N');
                   if get(WlkTab.PshBttn_Kick,'value')==1
                       fnc_LanzaUnDato(1);
                   else
                       fnc_LanzaUnDato(0);
                   end
               end
       end
end

function Lee_Datos_Robot
global WlkTab
global RR_TrayWalk

ValorSensado=get(WlkTab.PpUp_Sensado,'Value');

if (ValorSensado==1) || (ValorSensado==2) || (ValorSensado==3) || (ValorSensado==4)
    DataSize=19;
else
    DataSize=7;
end
Datos=RecibeDatosContinuos(DataSize);
disp('Transimsion datos de caminado finalizada');

if not(isempty(Datos))
    [R,C]=size(Datos);
    %Convierte los datos (negativos y float)
    for i=1:R
        Datos_Marcha(i,:)=Datos(i,:);
        for k=1:C
            if Datos_Marcha(i,k) > 32767
                Datos_Marcha(i,k)=-((65535-Datos_Marcha(i,k))+1);
            end
            if (ValorSensado==5) || (ValorSensado==6) || (ValorSensado==7)
                if k>1 && k<=4
                    Datos_Marcha(i,k)=Datos_Marcha(i,k)/10;
                end
            end
        end
    end
    Datos_Marcha
    %Detecta el numero de pasos y los indices de cambio de paso
    Pasos=1;
    Indices(1)=1;
    for i=2:R
        if Datos_Marcha(i,1)<Datos_Marcha(i-1,1);
            Indices(Pasos+1)=i;
            Pasos=Pasos+1;
        end
    end
    %Asigna los valores recibidos a las correspondientes variables
    for i=1:Pasos;
        if i<Pasos
            Ind_Final=Indices(i+1)-1;
        else
            Ind_Final=length(Datos_Marcha(:,1));
        end
        switch (ValorSensado)
            case 1
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1)
                RR_TrayWalk.thsDes.ths{i}=Datos_Marcha(Indices(i):Ind_Final,:);
            case 2
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1);
                RR_TrayWalk.thsDesMot.ths{i}=Datos_Marcha(Indices(i):Ind_Final,:);
            case 3
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1);
                RR_TrayWalk.thsReal.ths{i}=Datos_Marcha(Indices(i):Ind_Final,:);
            case 4
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1);
                RR_TrayWalk.Load.load{i}=Datos_Marcha(Indices(i):Ind_Final,:);
            case 5
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1).';
                RR_TrayWalk.P_x{i}=Datos_Marcha(Indices(i):Ind_Final,2).';
                RR_TrayWalk.P_y{i}=Datos_Marcha(Indices(i):Ind_Final,3).';
                RR_TrayWalk.P_z{i}=Datos_Marcha(Indices(i):Ind_Final,4).';
                RR_TrayWalk.P_phi{i}=Datos_Marcha(Indices(i):Ind_Final,5).';
                RR_TrayWalk.P_th{i}=Datos_Marcha(Indices(i):Ind_Final,6).';
                RR_TrayWalk.P_psi{i}=Datos_Marcha(Indices(i):Ind_Final,7).';
            case 6
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1).';
                RR_TrayWalk.Rf_x{i}=Datos_Marcha(Indices(i):Ind_Final,2).';
                RR_TrayWalk.Rf_y{i}=Datos_Marcha(Indices(i):Ind_Final,3).';
                RR_TrayWalk.Rf_z{i}=Datos_Marcha(Indices(i):Ind_Final,4).';
                RR_TrayWalk.Rf_phi{i}=Datos_Marcha(Indices(i):Ind_Final,5).';
                RR_TrayWalk.Rf_th{i}=Datos_Marcha(Indices(i):Ind_Final,6).';
                RR_TrayWalk.Rf_psi{i}=Datos_Marcha(Indices(i):Ind_Final,7).';
            case 7
                RR_TrayWalk.t{i}=Datos_Marcha(Indices(i):Ind_Final,1).';
                RR_TrayWalk.Lf_x{i}=Datos_Marcha(Indices(i):Ind_Final,2).';
                RR_TrayWalk.Lf_y{i}=Datos_Marcha(Indices(i):Ind_Final,3).';
                RR_TrayWalk.Lf_z{i}=Datos_Marcha(Indices(i):Ind_Final,4).';
                RR_TrayWalk.Lf_phi{i}=Datos_Marcha(Indices(i):Ind_Final,5).';
                RR_TrayWalk.Lf_th{i}=Datos_Marcha(Indices(i):Ind_Final,6).';
                RR_TrayWalk.Lf_psi{i}=Datos_Marcha(Indices(i):Ind_Final,7).';
        end        
    end
end
disp('Se genero la estructura RR_TrayWalk');
TrayWlkBLD_RR(ValorSensado);


