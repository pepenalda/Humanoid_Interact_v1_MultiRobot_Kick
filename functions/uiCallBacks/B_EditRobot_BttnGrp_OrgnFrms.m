function B_EditRobot_BttnGrp_OrgnFrms

global VRMLTab
global Robot

selected=get(VRMLTab.BttnGrp_OrgnFrms,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Torso'
        Value=getfield(Robot.vrRobot,'Torso_transparency');
    case 'Pelvis'
        Value=getfield(Robot.vrRobot,'Pelvis_transparency');
    case 'Left Shoulder'
        Value=getfield(Robot.vrRobot,'LS_transparency');
    case 'Right Shoulder'
        Value=getfield(Robot.vrRobot,'RS_transparency');
    case 'Left Hip'
        Value=getfield(Robot.vrRobot,'LHip_transparency');
    case 'Right Hip'        
        Value=getfield(Robot.vrRobot,'RHip_transparency');
end
set(VRMLTab.Slder_TrsprncyValue,'Value',Value);
set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.3f'));
