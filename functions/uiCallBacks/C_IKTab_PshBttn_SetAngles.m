function C_IKTab_PshBttn_SetAngles

global Robot

for i=1:18
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    Angles(i)=vecrot_i(4)*180/pi;
    setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Angles(i)*pi/180]);
end
set_all_positions_time(Angles,1);
C_IKTab_PshBttn_AllTorquesOn;