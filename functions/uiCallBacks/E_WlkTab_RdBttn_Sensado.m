function E_WlkTab_RdBttn_Sensado
global WlkTab

Value=get(WlkTab.RdBttn_Sensado,'Value');

if Value
    set(WlkTab.PpUp_Sensado,'enable','on');
else
    set(WlkTab.PpUp_Sensado,'enable','off');
end