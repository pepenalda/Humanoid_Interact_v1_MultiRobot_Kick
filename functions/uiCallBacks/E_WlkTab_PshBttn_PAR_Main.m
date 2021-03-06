function E_WlkTab_PshBttn_PAR_Main(Bttn)
global WlkTab

Value=get(WlkTab.uiPnl_RdBttnADJST,'value');
if not(Value)
    set(WlkTab.PNL_Values1,'visible','on');
    set(WlkTab.PNL_Values2,'visible','off');
    set(WlkTab.PNL_Values3,'visible','off');
    set(WlkTab.PNL_Values4,'visible','off');
end
for i=1:4
    set(WlkTab.PshBttn_Kick_PRM_4{i},'fontweight','normal');
end
S_Bttn=get(Bttn,'string');
switch S_Bttn
    case 'PEL'
        MakeBold(2,6);
        if Value
            MakeBold_3(1,5);
        end
    case 'FEET'
        MakeBold(7,10);
    case 'ARM'
        MakeBold(11,14);
    case 'TIME'
        MakeBold(15,18);
        if Value
            MakeBold_3(6,9);
        end        
end
i_Bttn=str2num(get(Bttn,'tag'));
for i=1:4
    if i==i_Bttn
        set(WlkTab.PshBttn_Main_PRM_1{i},'fontweight','bold');
    else
        set(WlkTab.PshBttn_Main_PRM_1{i},'fontweight','normal');
    end
end

function MakeBold(Ini,Fin)
global WlkTab
for i=1:18
    set(WlkTab.PshBttn_PRM_1{i},'fontweight','normal');
end
for i=Ini:Fin
    set(WlkTab.PshBttn_PRM_1{i},'fontweight','bold');
end

function MakeBold_3(Ini,Fin)
global WlkTab
for i=1:29
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','normal');
end
for i=Ini:Fin
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','bold');
end
