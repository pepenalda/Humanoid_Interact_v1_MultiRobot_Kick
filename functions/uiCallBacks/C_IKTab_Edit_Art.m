function C_IKTab_Edit_Art(Tag,String)

global Robot
global IKTab


i=str2num(Tag);
Value=str2double(String)*pi/180;
String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);

MaxValue=get(IKTab.Slider_Art{i},'Max');
MinValue=get(IKTab.Slider_Art{i},'Min');
if Value > MaxValue
    Value=MaxValue;
elseif Value < MinValue
    Value=MinValue;
end

set(IKTab.Slider_Art{i},'Value',Value);
setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Value]);

% if get(IKTab.RdBttn_Art{i},'Value') == 1
%     set_position_speed(i,Value*180/pi,get(IKTab.Slider_Vel,'Value'));
% end

C_IKTab_Slider_Art(Tag,str2num(String)*pi/180)

PlotRBT(IKTab.Axes)
