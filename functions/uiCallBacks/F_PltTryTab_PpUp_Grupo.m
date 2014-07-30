function F_PltTryTab_PpUp_Grupo

global PltTryTab

set(PltTryTab.PpUp_Elemento,'Value',1);
Value=get(PltTryTab.PpUp_Grupo,'Value');

if get(PltTryTab.RdBttn_PC,'Value')
    switch Value
        case 1
            set(PltTryTab.PpUp_Elemento,'String','Tiempo');
        case 2
            for i=1:18
                ElemntStr{i}=['Th' num2str(i)];
            end
            set(PltTryTab.PpUp_Elemento,'String',ElemntStr);
        case {3,4,5}
        %case 'Pelvis'
            set(PltTryTab.PpUp_Elemento,'Value',1);
            Otro={'x','y','z','Alabeo','Cabeceo','Guiñada'};
            set(PltTryTab.PpUp_Elemento,'String',Otro);
    end
else
    StringGrp=get(PltTryTab.PpUp_Grupo,'String');
    SlctdStrng=StringGrp{Value};
    if strcmp(SlctdStrng,'Angulos Deseados') || strcmp(SlctdStrng,'Angulos Deseados Motor') || strcmp(SlctdStrng,'Angulos Reales')
        StringE{1}='Time';
        for i=1:18
            StringE{i+1}=['Th' num2str(i)];
        end
        set(PltTryTab.PpUp_Elemento,'String',StringE);
    elseif strcmp(SlctdStrng,'Cargas Reales')
        StringE{1}='Time';
        for i=1:18
            StringE{i+1}=['Motor' num2str(i)];
        end
        set(PltTryTab.PpUp_Elemento,'String',StringE);
    else
        StringE={'Time','x','y','z','Alabeo','Cabeceo','Guiñada'};
        set(PltTryTab.PpUp_Elemento,'String',StringE);
    end
    set(PltTryTab.PpUp_Elemento,'Value',2);
end