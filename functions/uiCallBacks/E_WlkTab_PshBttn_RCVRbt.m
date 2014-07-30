function E_WlkTab_PshBttn_RCVRbt()
global WlkTab
global Walk

if strcmp(get(WlkTab.PNL_Values3,'visible'),'on')
    PrmsKey=3;
elseif strcmp(get(WlkTab.PNL_Values4,'visible'),'on')
    PrmsKey=4;
elseif strcmp(get(WlkTab.PNL_Values2,'visible'),'on')
    PrmsKey=2;
else
    PrmsKey=1;
end
Actualiza=0;
fnc_LanzaUnDato('g');
switch PrmsKey
    case 1
        fnc_LanzaUnDato('a');
        C=length(Walk.Values_1);
        pause(0.5);
        DatosRecibidos=RecibeDatos(C);
        if not(isscalar(DatosRecibidos))
           Actualiza=1;
        end
    case 2
        fnc_LanzaUnDato('b');
        C=length(Walk.Values_2);
        pause(0.5);
        DatosRecibidos=RecibeDatos(C);
        if not(isscalar(DatosRecibidos))
           Actualiza=1;
        end
    case 3
        fnc_LanzaUnDato('c');
        C=length(Walk.Values_3);
        pause(0.005);
        DatosRecibidos=RecibeDatos(C);
        if not(isscalar(DatosRecibidos))
           Actualiza=1;
        end
    case 4
        fnc_LanzaUnDato('d');
        C=length(Walk.Values_4);
        DatosRecibidos=RecibeDatos(C);
        if not(isscalar(DatosRecibidos))
           Actualiza=1;
        end        
end

if Actualiza
    Actuaiza_Panel_1(PrmsKey,DatosRecibidos);
else
    disp('Problema de recepci�n de datos; no se actualiza el panel')
end

function Actuaiza_Panel_1(PrmsKey,Datos)
global WlkTab
global Walk
for i=1:length(Datos)
    Dato=Datos(i);
    if Dato > 32767
        Dato=-((65535-Dato)+1);
    end 
    switch PrmsKey
        case 1
            if strcmp(Walk.Types_1(i),'f')
                Dato=Dato/10;
            end
            set(WlkTab.Edit_PRM_1{i},'string',num2str(Dato));
            set(WlkTab.Slider_PRM_1{i},'value',Dato);
        case 2
            if strcmp(Walk.Types_2(i),'f')
                Dato=Dato/10;
            end
            set(WlkTab.Edit_PRM_2{i},'string',num2str(Dato));
            set(WlkTab.Slider_PRM_2{i},'value',Dato);
        case 3
            if strcmp(Walk.Types_3(i),'f')
                Dato=Dato/10;
            end
            set(WlkTab.Edit_PRM_3{i},'string',num2str(Dato));
            set(WlkTab.Slider_PRM_3{i},'value',Dato);            
        case 4
            if strcmp(Walk.Types_4(i),'f')
                Dato=Dato/10;
            end
            set(WlkTab.Edit_PRM_4{i},'string',num2str(Dato));
            set(WlkTab.Slider_PRM_4{i},'value',Dato);                        
    end
end
