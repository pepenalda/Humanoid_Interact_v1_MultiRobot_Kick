function E_WlkTab_PshBttn_PAR_RRobot(Bttn)
global WlkTab

Value=get(WlkTab.uiPnl_RdBttnADJST,'value');
if not(Value)
    set(WlkTab.PNL_Values1,'visible','off');
    set(WlkTab.PNL_Values2,'visible','on');
    set(WlkTab.PNL_Values3,'visible','off');
    set(WlkTab.PNL_Values4,'visible','off');
end

S_Bttn=get(Bttn,'string');
switch S_Bttn
    case 'FEETA'
        MakeBold(1,4,15,18);
    case 'RIGDL'
        MakeBold(5,14,0,0);
        if Value
            MakeBold_3(10,19);
        end
    case 'RIGDR'
        MakeBold(19,28,0,0);
        if Value
            MakeBold_3(20,29);
        end        
end
i_Bttn=str2double(get(Bttn,'tag'));
for i=1:3
    if i==i_Bttn
        set(WlkTab.PshBttn_Main_PRM_2{i},'fontweight','bold');
    else
        set(WlkTab.PshBttn_Main_PRM_2{i},'fontweight','normal');
    end
end

function MakeBold(Ini1,Fin1,Ini2,Fin2)
global WlkTab
for i=1:28
    set(WlkTab.PshBttn_PRM_2{i},'fontweight','normal');
end
for i=Ini1:Fin1
    set(WlkTab.PshBttn_PRM_2{i},'fontweight','bold');
end
if ne(Ini2,0)
    for i=Ini2:Fin2
        set(WlkTab.PshBttn_PRM_2{i},'fontweight','bold');
    end
end

function MakeBold_3(Ini,Fin)
global WlkTab
for i=1:29
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','normal');
end
for i=Ini:Fin
    set(WlkTab.PshBttn_PRM_3{i},'fontweight','bold');
end
