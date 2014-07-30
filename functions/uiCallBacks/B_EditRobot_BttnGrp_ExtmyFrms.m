function B_EditRobot_BttnGrp_ExtmyFrms

global VRMLTab
global Robot

selected=get(VRMLTab.BttnGrp_ExtrmtyFrms,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Left Hand'
        Value=getfield(Robot.vrRobot,'LH_transparency');
    case 'Right Hand'
        Value=getfield(Robot.vrRobot,'RH_transparency');
    case 'Left Ankle'
        Value=getfield(Robot.vrRobot,'LAnkle_transparency');
    case 'Left Foot'
        Value=getfield(Robot.vrRobot,'LF_transparency');
    case 'Right Ankle'
        Value=getfield(Robot.vrRobot,'RAnkle_transparency');
    case 'Right Foot'        
        Value=getfield(Robot.vrRobot,'RF_transparency');
end
set(VRMLTab.Slder_TrsprncyValue,'Value',Value);
set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.3f'));
