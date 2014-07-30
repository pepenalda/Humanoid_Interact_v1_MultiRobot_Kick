function C_IKTab_PshBttn_GetAngles

global Robot
global IKTab

Angles=get_all_positions;
for i=1:Robot.N
    set(IKTab.Slider_Art{i},'Value',Angles(i)*pi/180);
    set(IKTab.Edit_Art{i},'String',num2str(Angles(i),'%03.1f'));
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Angles(i)*pi/180]);
end

PlotBLD(IKTab.Panel_PlotIK);