function F_PltTryTab_PpUp_TipoPaso

global PltTryTab 
global TrayWalk

Value=get(PltTryTab.PpUp_TipoPaso,'Value');
switch Value
    case 1
        set(PltTryTab.PpUp_Paso,'Enable','on');
        Zancadas=TrayWalk.Si;
        for i=1:Zancadas
            Str{i}=num2str(i);
        end
        set(PltTryTab.PpUp_Paso,'String',Str);
        set(PltTryTab.RdBttn_Time,'Value',0);
        set(PltTryTab.RdBttn_Time,'enable','off');
    case 2
        set(PltTryTab.PpUp_Paso,'Enable','off');
        set(PltTryTab.RdBttn_Time,'enable','on');
end