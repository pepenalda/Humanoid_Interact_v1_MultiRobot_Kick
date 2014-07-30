function set_CoM

global Robot

th=Get_Ths_vrHumanoid;
th(7)=th(7)+pi/4;
th(8)=th(8)-pi/4;
CoM=Pelvis_CoM(th);
setfield(Robot.vrRobot,'translation_CoM',CoM);

