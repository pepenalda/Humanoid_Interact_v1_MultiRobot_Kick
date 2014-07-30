function E_WlkTab_RdBttn_PAR_Frst(RdBttn)
global WlkTab
global Walk

Value=get(RdBttn,'Value');
for i=1:29
    set(WlkTab.Slider_PRM_3{i},'value',Walk.Values_3(i));
    set(WlkTab.Edit_PRM_3{i},'string',num2str(Walk.Values_3(i)));
end
if Value
    set(WlkTab.PNL_Values1,'visible','off');
    set(WlkTab.PNL_Values2,'visible','off');
    set(WlkTab.PNL_Values3,'visible','on');
else
    set(WlkTab.PNL_Values1,'visible','on');
    set(WlkTab.PNL_Values2,'visible','off');
    set(WlkTab.PNL_Values3,'visible','off');    
end
