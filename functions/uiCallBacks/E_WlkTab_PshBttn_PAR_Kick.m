function E_WlkTab_PshBttn_PAR_Kick(Bttn)
global WlkTab

set(WlkTab.PNL_Values4,'visible','on');
set(WlkTab.PNL_Values1,'visible','off');
set(WlkTab.PNL_Values2,'visible','off');
set(WlkTab.PNL_Values3,'visible','off');

for i=1:4
    set(WlkTab.PshBttn_Main_PRM_1{i},'fontweight','normal');
end

S_Bttn=get(Bttn,'string');
switch S_Bttn
    case 'PEL'
        MakeBold(2,6);
    case 'FEET'
        MakeBold(7,10);
    case 'ARM'
        MakeBold(11,14);
    case 'TIME'
        MakeBold(15,19);
end
i_Bttn=str2num(get(Bttn,'tag'));
for i=1:4
    if i==i_Bttn
        set(WlkTab.PshBttn_Kick_PRM_4{i},'fontweight','bold');
    else
        set(WlkTab.PshBttn_Kick_PRM_4{i},'fontweight','normal');
    end
end

function MakeBold(Ini,Fin)
global WlkTab
for i=1:19
    set(WlkTab.PshBttn_PRM_4{i},'fontweight','normal');
end
for i=Ini:Fin
    set(WlkTab.PshBttn_PRM_4{i},'fontweight','bold');
end

function MakeBold_3(Ini,Fin)
global WlkTab
for i=1:29
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','normal');
end
for i=Ini:Fin
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','bold');
end
