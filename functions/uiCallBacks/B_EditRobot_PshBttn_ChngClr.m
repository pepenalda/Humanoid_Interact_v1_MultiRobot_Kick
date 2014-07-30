function B_EditRobot_PshBttn_ChngClr

global VRMLTab
global Robot

color=uisetcolor;
set(VRMLTab.uiPnl_ClrSmpl,'BackgroundColor',color);

selected=get(VRMLTab.BttnGrp_ClrsElmentSlct,'SelectedObject');
SlctdStrng=get(selected,'String');

for i=1:length(Robot.ColorNames)
    if strcmp(SlctdStrng,Robot.ColorNames{i})
        color_Name=['Color_' num2str(i)];
    end
end

setfield(Robot.vrRobot,color_Name,color);