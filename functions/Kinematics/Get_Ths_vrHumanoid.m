function th=Get_Ths_vrHumanoid;
global Robot

for i=1:Robot.N
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    th(i)=vecrot_i(4);
end