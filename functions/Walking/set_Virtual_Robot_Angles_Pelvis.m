function set_Virtual_Robot_Angles_Pelvis(th,i)
global Robot
global Walking

Values=th;
W_R_Pel=EulYXZ_2_Rot(deg2rad(Walking.P_phi(i)),deg2rad(Walking.P_th(i)),deg2rad(Walking.P_psi(i)));

Robot.w_R_o=W_R_Pel;
Pel_p_Pel_Tor(1)=0;
Pel_p_Pel_Tor(2)=0;
Pel_p_Pel_Tor(3)=89.5/10;
w_p_Pel_Tor=W_R_Pel*Pel_p_Pel_Tor.';
w_p_o1(1)=Walking.P_x(i)+w_p_Pel_Tor(1);
w_p_o1(2)=Walking.P_y(i)+w_p_Pel_Tor(2);
w_p_o1(3)=Walking.P_z(i)+w_p_Pel_Tor(3);

Robot.w_p_o=w_p_o1.';

mlab_R_vrml=[0 0 1;
             1 0 0;
             0 1 0];   
         
vrot=vrrotmat2vec(Robot.w_R_o);
vrot=[vrot(2) vrot(3) vrot(1) vrot(4)];
setfield(Robot.vrRobot,'rotationHips',vrot);

for i=1:Robot.N
    %Actualización de los angulos del robot virtual
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) Values(i)]);
    %vrdrawnow;
end