function B_EditRobot_Edt_Trsprncy_CreateFcn(object)
global Robot
global VRMLTab

selected=get(VRMLTab.BttnGrp_TransparencyElementSelect,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Robot'
        Value=getfield(Robot.vrRobot,'transparency');
    case 'Head Chest'
         Value=getfield(Robot.vrRobot,'head_transparency');
    case 'Kinematic Chain'
        Value=getfield(Robot.vrRobot,'structure_transparency');
    case 'Motor Axis'
        Value=getfield(Robot.vrRobot,'axis_transparency');
    case 'Motor Frames'
        Value=getfield(Robot.vrRobot,'Frames_transparency');
    case 'Extremities Frames'
        Value=getfield(Robot.vrRobot,'EFrame_transparency');
    case 'Origin Frame'
        Value=getfield(Robot.vrRobot,'OFrame_transparency');
    case 'OCoM''s'
        Value=getfield(Robot.vrRobot,'CoM_transparency');        
end
set(object,'String',num2str(Value,'%1.3f'));
set(VRMLTab.Slder_TrsprncyValue,'Value',Value);