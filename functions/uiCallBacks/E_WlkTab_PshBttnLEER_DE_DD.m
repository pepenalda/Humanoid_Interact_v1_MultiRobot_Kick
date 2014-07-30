function E_WlkTab_PshBttnLEER_DE_DD
global Walk
global WlkTab

uiopen('WalkingParameters/FileName.mat')

for i=1:length(Walk.Values_1)
    set(WlkTab.Edit_PRM_1{i},'string',num2str(Walk.Values_1(i)));
    set(WlkTab.Slider_PRM_1{i},'value',Walk.Values_1(i));
end
for i=1:length(Walk.Values_2)
    set(WlkTab.Edit_PRM_2{i},'string',num2str(Walk.Values_2(i)));
    set(WlkTab.Slider_PRM_2{i},'value',Walk.Values_2(i));
end
for i=1:length(Walk.Values_3)
    set(WlkTab.Edit_PRM_3{i},'string',num2str(Walk.Values_3(i)));
    set(WlkTab.Slider_PRM_3{i},'value',Walk.Values_3(i));
end
for i=1:length(Walk.Values_4)
    set(WlkTab.Edit_PRM_4{i},'string',num2str(Walk.Values_4(i)));
    set(WlkTab.Slider_PRM_4{i},'value',Walk.Values_4(i));
end
