function C_IKTab_Slider_Art(Tag,Value)
global Robot
global IKTab
global Cnnct

i=str2num(Tag);
String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Value])

if strcmp(Robot.Name,'Nao')
    if i==15
        String_MotorField_i=['rotation_Servo' num2str(21,'%d')];
        vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
        setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Value])
        set(IKTab.Edit_Art{21},'String',num2str(Value*180/pi,'%03.1f'));
        set(IKTab.Edit_Art{21},'BackgroundColor','w');
        set(IKTab.Slider_Art{21},'Value',Value);
    end
    if i==21
        String_MotorField_i=['rotation_Servo' num2str(15,'%d')];
        vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
        setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Value])
        set(IKTab.Edit_Art{15},'String',num2str(Value*180/pi,'%03.1f'));
        set(IKTab.Edit_Art{15},'BackgroundColor','w');
        set(IKTab.Slider_Art{15},'Value',Value);
    end
end

set(IKTab.Edit_Art{i},'String',num2str(Value*180/pi,'%03.1f'));
set(IKTab.Edit_Art{i},'BackgroundColor','w');
set(IKTab.Slider_Art{i},'Value',Value);

if get(IKTab.RdBttn_Art{i},'Value') == 1
    if strcmp(Robot.Name,'Bioloid')
        set_position_speed(i,Value*180/pi,get(IKTab.Slider_Vel,'Value'));
    elseif strcmp(Robot.Name,'Nao')
        RobotIP=Cnnct.NaoIP;
        if exist('mtn','var')
        else
            mtn=ALMotionProxy(RobotIP,9559);
        end
        JointNames={'HeadYaw','HeadPitch','LShoulderPitch','LShoulderRoll','LElbowYaw','LElbowRoll','LWristYaw','LHand',...
            'RShoulderPitch','RShoulderRoll','RElbowYaw','RElbowRoll','RWristYaw','RHand',...
            'LHipYawPitch','LHipRoll','LHipPitch','LKneePitch','LAnklePitch','LAnkleRoll',...
            'RHipYawPitch','RHipRoll','RHipPitch','RKneePitch','RAnklePitch','RAnkleRoll'};
        if (ne(i,8) || ne(i,14))
            Name=JointNames{i};
            mtn.setStiffnesses(Name,1);
            Vel=get(IKTab.Slider_Vel,'Value')
            mtn.setAngles(Name,Value,Vel);
        else
            if i==8
            else
            end
        end
        %clear mtn
        pause(0.3)
    end
end

PlotRBT(IKTab.Axes)