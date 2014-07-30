function color=B_EditRobot_Fnc_GetPartColor(BttnGrp_Clrs)

global Robot

selected=get(BttnGrp_Clrs,'SelectedObject');
SlctdStrng=get(selected,'String');

for i=1:length(Robot.ColorNames)
    if strcmp(SlctdStrng,Robot.ColorNames{i})
        color_Name=['Color_' num2str(i)];
    end
end

color=getfield(Robot.vrRobot,color_Name);

