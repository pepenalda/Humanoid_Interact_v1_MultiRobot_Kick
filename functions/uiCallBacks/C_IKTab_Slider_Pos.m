function C_IKTab_Slider_Pos(Tag,Value)
global Robot
global IKTab

%Obtiene el panel ID, xyzID
xyzID=str2num(Tag);

for i=1:Robot.N
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    ths(i)=vecrot_i(4);
    th_min(i)=get(IKTab.Slider_Art{i},'Min');
    th_max(i)=get(IKTab.Slider_Art{i},'Max');
end

%Actualiza el valor del Edit
set(IKTab.Edit_Pos{xyzID},'String',num2str(Value,'%2.1f'));

%Posición
x=get(IKTab.Slider_Pos{1},'Value');
y=get(IKTab.Slider_Pos{2},'Value');
z=get(IKTab.Slider_Pos{3},'Value');

%Orientacion del efector final
phi=get(IKTab.Slider_Ori{1},'Value')*pi/180;
th=get(IKTab.Slider_Ori{2},'Value')*pi/180;
psi=get(IKTab.Slider_Ori{3},'Value')*pi/180;

L0=47/10;
L1=25/10;
La=L0+L1;
L5=38.5/10;

switch Robot.IK_Key
    case 1 %Brazo derecho
        xRARM=[x y z];
        thRARM=bld_RArmIK(xRARM);
        %Asignacion de variables
        ths(1)=thRARM(1);
        ths(3)=thRARM(2);
        ths(5)=thRARM(3);
        
        %Simetria
        if get(IKTab.RdBttn_SymArms1,'Value')==get(IKTab.RdBttn_SymArms1,'Max') || get(IKTab.RdBttn_SymArms2,'Value')==get(IKTab.RdBttn_SymArms2,'Max') || get(IKTab.RdBttn_SymArms3,'Value')==get(IKTab.RdBttn_SymArms3,'Max')
            if get(IKTab.RdBttn_SymArms1,'Value')==get(IKTab.RdBttn_SymArms1,'Max')
                y=-y;
            elseif get(IKTab.RdBttn_SymArms2,'Value')==get(IKTab.RdBttn_SymArms2,'Max')
                y=-(-y-La)+La;
            else
                x=-x;
                y=-y;                
            end
            xLARM=[x y z];
            thLARM=bld_LArmIK(xLARM);
            %Asignacion de variables
            ths(2)=thLARM(1);
            ths(4)=thLARM(2);
            ths(6)=thLARM(3); 
            %Send positions of both arms
            if get(IKTab.RdBttn_IKMvRbt,'Value') == get(IKTab.RdBttn_IKMvRbt,'Max')
                speed=str2num(get(IKTab.Edit_Vel,'String'));
                set_positions_speed(ths(1:6)*180/pi,[1 2 3 4 5 6],speed);
            end
        else
            %Send to left arm
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed([ths(1) ths(3) ths(5)]*180/pi,[1 3 5],speed);
            end
        end
    case 2 %Brazo izquierdo  
        xLARM=[x y z];
        thLARM=LArmIK(xLARM);
        %Asignacion de variables
        ths(2)=thLARM(1);
        ths(4)=thLARM(2);
        ths(6)=thLARM(3);
        
        %Simetria
        if get(IKTab.RdBttn_SymArms1,'Value')== 1 || get(IKTab.RdBttn_SymArms2,'Value')== 1 || get(IKTab.RdBttn_SymArms3,'Value')== 1
            if get(IKTab.RdBttn_SymArms1,'Value')== 1
                y=-y;
            elseif get(IKTab.RdBttn_SymArms2,'Value')== 1
                y=-(-y-La)+La;
            else
                x=-x;
                y=-y;                
            end
            xRARM=[x y z];
            thRARM=RArmIK(xRARM);
            %Asignacion de variables
            ths(1)=thRARM(1);
            ths(3)=thRARM(2);
            ths(5)=thRARM(3); 
            %Send positions of both arms
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed(ths(1:6)*180/pi,[1 2 3 4 5 6],speed);
            end
        else
            %Send to left arm
            if  get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed([ths(2) ths(4) ths(6)]*180/pi,[2 4 6],400);
            end
        end
    case 3  %pierna derecha
        r_RA=[x y z].';
        W_R_RA=EulYXZ_2_Rot(phi,th,psi);
        
        W_R_Pel=Robot.w_R_o;
        r_Pel=Robot.w_p_o-Robot.w_R_o*[0 0 89.5/10].';
        r_RA_Pel=r_Pel-r_RA;
        RA_R_Pel=W_R_RA.'*W_R_Pel;
        RA_T_Pel=[RA_R_Pel W_R_RA.'*r_RA_Pel; 0 0 0 1];
        thRLeg=bld_RHipIK(RA_T_Pel);
        ths(7)=thRLeg(1);
        ths(9)=thRLeg(2);
        ths(11)=thRLeg(3);
        ths(13)=thRLeg(4);
        ths(15)=thRLeg(5);
        ths(17)=thRLeg(6);

        %Simetria
        if get(IKTab.RdBttn_SymLegs1,'Value')== 1 ||...
           get(IKTab.RdBttn_SymLegs2,'Value')== 1 ||...
           get(IKTab.RdBttn_SymLegs3 ,'Value')== 1 ||...
           get(IKTab.RdBttn_DSup,'Value')== 1
            if get(IKTab.RdBttn_SymLegs1,'Value')== 1
                y=-(-y-L5)+L5;
            elseif get(IKTab.RdBttn_SymLegs2,'Value')== 1
                y=-y;
            else
                x=-x;
                y=-y;                
            end     
            xLFoot=[x y z phi th psi];
            thLLeg=LFootIK(xLFoot);
            ths(8)=thLLeg(1);
            ths(10)=thLLeg(2);
            ths(12)=thLLeg(3);
            ths(14)=thLLeg(4);
            ths(16)=thLLeg(5);
            ths(18)=thLLeg(6);     
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed(ths(7:18)*180/pi,[7 8 9 10 11 12 13 14 15 16 17 18],speed);
            end
        else
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');%
                set_positions_speed([ths(7) ths(9) ths(11) ths(13) ths(15) ths(17)]*180/pi,[7 9 11 13 15 17],speed);
            end            
        end
    case 4  %pierna izquierda
        r_LA=[x y z].';
        W_R_LA=EulYXZ_2_Rot(phi,th,psi);
        
        W_R_Pel=Robot.w_R_o;
        r_Pel=Robot.w_p_o-Robot.w_R_o*[0 0 89.5/10].';
        r_LA_Pel=r_Pel-r_LA;
        LA_R_Pel=W_R_LA.'*W_R_Pel;
        LA_T_Pel=[LA_R_Pel W_R_LA.'*r_LA_Pel; 0 0 0 1];
        thLLeg=bld_LHipIK(LA_T_Pel);
        
        ths(8)=thLLeg(1);
        ths(10)=thLLeg(2);
        ths(12)=thLLeg(3);
        ths(14)=thLLeg(4);
        ths(16)=thLLeg(5);
        ths(18)=thLLeg(6);
        %Simetria
        if get(IKTab.RdBttn_SymLegs1,'Value')== 1 ||...
           get(IKTab.RdBttn_SymLegs2,'Value')== 1 ||...
           get(IKTab.RdBttn_SymLegs3 ,'Value')== 1
           
       %get(H.uiRdBttn_DSup,'Value')==get(H.uiRdBttn_DSup,'Max')
            if get(IKTab.RdBttn_SymLegs1,'Value')== 1
                y=y-L5-L5;
            elseif get(IKTab.RdBttn_SymLegs2,'Value')== 1
                y=-y;
            else
                x=-x;
                y=-y;                
            end     
            xRFoot=[x y z phi th psi];
            thRLeg=RFootIK(xRFoot);
            ths(7)=thRLeg(1);
            ths(9)=thRLeg(2);
            ths(11)=thRLeg(3);
            ths(13)=thRLeg(4);
            ths(15)=thRLeg(5);
            ths(17)=thRLeg(6);     
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed(ths(7:18)*180/pi,[7 8 9 10 11 12 13 14 15 16 17 18],speed);
            end
        else
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed([ths(8) ths(10) ths(12) ths(14) ths(16) ths(18)]*180/pi,[8 10 12 14 16 18],speed);
            end            
        end
    case 5  %Pelvis
        L5=77/10;        
        W_R_Pel=EulYXZ_2_Rot(phi,th,psi);
        r_Pel=[x y z].';
        
        if get(IKTab.RdBttn_DSup,'Value') == 1        
            %Right Leg
            r_RA=[0 -L5/2 0].';
            r_RA_Pel=r_Pel-r_RA;
            RA_T_Pel=[W_R_Pel r_RA_Pel; [0 0 0 1]];
            thRLeg=bld_RHipIK(RA_T_Pel);
            
            %Left Leg
            r_LA=[0 L5/2 0].';            
            r_LA_Pel=r_Pel-r_LA;
            LA_T_Pel=[W_R_Pel r_LA_Pel; [0 0 0 1]];
            thLLeg=bld_LHipIK(LA_T_Pel);
            
            ths(7)=thRLeg(1);
            ths(9)=thRLeg(2);
            ths(11)=thRLeg(3);
            ths(13)=thRLeg(4);
            ths(15)=thRLeg(5);
            ths(17)=thRLeg(6);
            
            ths(8)=thLLeg(1);
            ths(10)=thLLeg(2);
            ths(12)=thLLeg(3);
            ths(14)=thLLeg(4);
            ths(16)=thLLeg(5);
            ths(18)=thLLeg(6);  
            
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed(ths(7:18)*180/pi,[7 8 9 10 11 12 13 14 15 16 17 18],speed);
            end            
        elseif get(IKTab.RdBttn_SupRight,'Value') == 1
            %Right Leg
            r_Center_RA=[0 -L5/2  0].';
            r_RA_Pel=r_Pel-r_Center_RA;
            RA_T_Pel=[W_R_Pel r_RA_Pel; [0 0 0 1]];
            thRLeg=bld_RHipIK(RA_T_Pel);

            ths(7)=thRLeg(1);
            ths(9)=thRLeg(2);
            ths(11)=thRLeg(3);
            ths(13)=thRLeg(4);
            ths(15)=thRLeg(5);
            ths(17)=thRLeg(6);     
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');%
                set_positions_speed([ths(7) ths(9) ths(11) ths(13) ths(15) ths(17)]*180/pi,[7 9 11 13 15 17],speed);
            end            
        elseif get(IKTab.RdBttn_SupLeft,'Value') == 1
            %Left Leg
            r_Center_LA=[0 L5/2 0].';            
            r_LA_Pel=r_Pel-r_Center_LA;
            LA_T_Pel=[W_R_Pel r_LA_Pel; [0 0 0 1]];
            thLLeg=bld_LHipIK(LA_T_Pel);
            
            ths(8)=thLLeg(1);
            ths(10)=thLLeg(2);
            ths(12)=thLLeg(3);
            ths(14)=thLLeg(4);
            ths(16)=thLLeg(5);
            ths(18)=thLLeg(6);              
            if get(IKTab.RdBttn_IKMvRbt,'Value') == 1
                speed=get(IKTab.Slider_Vel,'Value');
                set_positions_speed([ths(8) ths(10) ths(12) ths(14) ths(16) ths(18)]*180/pi,[8 10 12 14 16 18],speed);
            end                        
        end
end

for i=1:Robot.N
    set(IKTab.Edit_Art{i},'BackgroundColor','w');
    %Chequeo de los limites articulares
    if (ths(i) < th_min(i) || ths(i) > th_max(i))
        set(IKTab.Edit_Art{i},'BackgroundColor',[1 0.6 0.6]);
        if ths(i) < th_min(i)
            ths(i)=th_min(i);
        else
            ths(i)=th_max(i);
        end
    end
    %Actualización de los angulos del robot virtual
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    setfield(Robot.vrRobot,String_MotorField_i,[vecrot_i(1:3) ths(i)]);
    
    %Actualización de los sliders y edits
    set(IKTab.Slider_Art{i},'Value',ths(i));
    set(IKTab.Edit_Art{i},'String',num2str(ths(i)*180/pi,'%02.1f'));
end
PlotRBT(IKTab.Axes)

function [r_Pel R_Pel]=Pel_DK
global Robot

w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_T_o=w_T_o;
T_opi00a = mlab_T_o*[ 1 0 0 0; 0 1 0 -89.5/10; 0 0 1 0;0 0 0 1];

r_Pel=T_opi00a(1:3,4)
R_Pel=mlab_R_vrml.'*T_opi00a(1:3,1:3)