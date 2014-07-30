function A01_Create_Robot
global Robot
global vrFigure
global Walk
global Cnnct

switch Robot.Name
    case 'Bioloid'
        Cnnct.CnnctnType=0;
        %Virtual Robot
        HumRob_wrlFile='Bioloid_Premium_A.wrl';
        Str_Robot='Virtual Robot: Bioloid Premium "A"';
        
        Robot.Connectable=1;
        Robot.N_Trnk=0;
        Robot.N_LArm=3;
        Robot.N_LLeg=6;
        Robot.N=18;
        Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; 
        Robot.w_p_o=[0 0 22.05+8.95].';        
        Robot.Ths_Hm=[-1.57 1.57 -1.19 1.18 -0.25 0.25 -0.78 0.78 -0 0, -0.87 0.87 -1.39 1.39 0.69 -0.69 -0 0];
        Robot.Ths_Up=[-1.5708 1.5708 -1.5708 1.5708 0 0 -0.7854 0.7854 0 0 0 0 0 0 0 0 0 0];
        Robot.Ths_Zs=[0 0 0 0 0 0 -0.7854 0.7854 0 0 0 0 0 0 0 0 0 0];
        Robot.Axis=[-250 250 -250 250 0 350]/10;
        
        %Limites Cartesianos
        Robot.PosLim={[-12.7 15.6],[-21.5 21.1],[-15.7 21.7]};
        Robot.OriLim={[-180 180],[-180 180],[-180 180]};
        
        %Limites articulares
        Robot.AngleLimits={[-150 150],[-150 150],[-100 91],[-91 100],[-100 100],[-100 100],...
                     [-95 10],[-10 95],[-73 50],[-50 73],[-128 23],[-23 128],...
                     [-152 0],[0 152],[-23 99],[-99 23],[-54 74],[-74 54],[-100 100],[-100 100],[-100 100],[-100 100],...
                     [-100 100],[-100 100],[-100 100]};
        Robot.ColorNames={'Motors','Parts','Head and Chest','Rotors','Centers','Kinematic Chain','CoM''s'};
                 
        Walk.Values_1=[ 4, 0 15.5  11 2.9  11, 10   0   4    0,  20  70  30 50,  2000 250 500 800];
        Walk.Types_1=['i','f' 'f' 'i' 'f' 'i', 'f' 'f' 'f' 'i', 'i' 'i' 'i' 'i',  'i' 'i' 'i' 'i'];        
        Walk.Values_2=[ 0   0   0   0   0   0   0   0,   0   0   0   0   0   0   0   0   0   0,   0   0   0   0   0   0   0   0   0   0];
        Walk.Types_2=['f' 'f' 'f' 'i', 'i' 'i' 'i' 'i' 'i', 'i' 'i' 'i' 'i' 'i', 'f' 'f' 'f' 'i', 'i' 'i' 'i' 'i' 'i', 'i' 'i' 'i' 'i' 'i'];
        Walk.Frst_Indx={[2 3 4 5 6 15 16 17 18],[5 6 7 8 9 10 11 12 13 14 19 20 21 22 23 24 25 26 27 28]};
        Index=1;
        for i=1:2
            for j=1:length(Walk.Frst_Indx{i})
                if i==1
                    Walk.Values_3(Index)=Walk.Values_1(Walk.Frst_Indx{i}(j));
                    Walk.Types_3(Index)=Walk.Types_1(Walk.Frst_Indx{i}(j));
                else
                    Walk.Values_3(Index)=Walk.Values_2(Walk.Frst_Indx{i}(j));
                    Walk.Types_3(Index)=Walk.Types_2(Walk.Frst_Indx{i}(j));                    
                end
                Index=Index+1;
            end
        end
        Walk.Values_4=[ 4, 0 15.5  11 2.9  11, 4   0   4    0,  20  70  30 50,  2000 250 500 800 300];
        Walk.Types_4=['i','f' 'f' 'i' 'f' 'i', 'f' 'f' 'f' 'i', 'i' 'i' 'i' 'i',  'i' 'i' 'i' 'i' 'i'];        
        
    case 'Nao'
        HumRob_wrlFile='nao.wrl';
        Str_Robot='Virtual Robot: Nao';
        Robot.Connectable=1;
        Robot.N_Trnk=2;
        Robot.N_LArm=6;
        Robot.N_LLeg=6;
        Robot.N=26;
        Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; 
        Robot.w_p_o=[0 0 350-85].';                
        Robot.Ths_Hm=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Ths_Up=[0 0 1.5708 0.087 0 0 0 0 1.5708 -0.087 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Ths_Zs=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Axis=[-500 500 -500 500 0 700]/10;
        %Limites Cartesianos
        Robot.PosLim={[-50 50],[-50 50],[-50 50]};
        Robot.OriLim={[-180 180],[-180 180],[-180 180]};
        %Limites articulares
        Robot.AngleLimits={[-2.08 2.08]*180/pi,[-2.08 2.08]*180/pi,[-1.32 0.314]*180/pi,[-0.314 1.32]*180/pi,[-2.08 2.08]*180/pi,[-2.08 2.08]*180/pi,...
                     [-2.08 1.54]*180/pi,[-1.54 2.08]*180/pi,[-1.82 1.82]*180/pi,[-1.82 1.82]*180/pi,[-1.14 0.74]*180/pi,[-1.14 0.74]*180/pi,...
                     [-0.738 0.44]*180/pi,[-0.37 0.79]*180/pi,[-1.77 0.48]*180/pi,[-1.77 0.48]*180/pi,[-0.09 2.11]*180/pi,[-0.09 2.11]*180/pi,...
                     [-1.18 0.93]*180/pi,[-1.18 0.93]*180/pi,[-0.38 0.78]*180/pi,[-0.76 0.39]*180/pi,...
                     [-1.81 1.81]*180/pi,[-0.36 0.94]*180/pi,[-0.36 0.94]*180/pi,[-0.36 0.94]*180/pi};
        Robot.ColorNames={'Main skin','Secondary Skin','Leds','Eyes','Structure','Kinematic Chain','CoM''s'};
        
    case 'Darwin'
        HumRob_wrlFile='Darwin_OP.wrl';
        Str_Robot='Virtual Robot: Darwin';
        Robot.Connectable=0;
        Robot.N_Trnk=2;
        Robot.N_LArm=3;
        Robot.N_LLeg=6;
        Robot.N=20;
        Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; 
        Robot.w_p_o=[0 343 0].';        
        Robot.Ths_Hm=[-1.57 1.57 -1.19 1.18 -0.25 0.25 -0.78 0.78 -0 0, -0.87 0.87 -1.39 1.39 0.69 -0.69 -0 0 0 0 0 0];
        Robot.Ths_Up=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Ths_Zs=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Axis=[-300 300 -300 300 0 400]/10;
        %Limites Cartesianos
        Robot.PosLim={[-12.7 15.6],[-21.5 21.1],[-15.7 21.7]};
        Robot.OriLim={[-180 180],[-180 180],[-180 180]};
        %Limites articulares
        Robot.AngleLimits={[-150 150],[-150 150],[-100 91],[-91 100],[-100 100],[-100 100],...
                     [-95 10],[-10 95],[-73 50],[-50 73],[-128 23],[-23 128],...
                     [-152 0],[0 152],[-23 99],[-99 23],[-54 74],[-74 54],[-100 100],[-100 100],[-100 100],[-100 100]};
        Robot.ColorNames={'Plastic','Metal','Eyes and Front','Eyes Leds','Motors','Kinematic Chain','CoM''s'};         
        
    case 'KHR'
        HumRob_wrlFile='khr-3hv.wrl';
        Str_Robot='Virtual Robot: KHR-3HV';
        Robot.Connectable=0;
        Robot.N_Trnk=2;
        Robot.N_LArm=4;
        Robot.N_LLeg=6;
        Robot.N=23;
        Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; 
        Robot.w_p_o=[0 700 0].';        
        Robot.Ths_Hm=[-1.57 1.57 -1.19 1.18 -0.25 0.25 -0.78 0.78 -0 0, -0.87 0.87 -1.39 1.39 0.69 -0.69 -0 0 0 0 0 0];
        Robot.Ths_Up=[-1.5708 1.5708 -1.5708 1.5708 0 0 -0.7854 0.7854 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Ths_Zs=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        Robot.Axis=[-500 500 -500 500 0 900]/10;
        %Limites Cartesianos
        Robot.PosLim={[-12.7 15.6],[-21.5 21.1],[-15.7 21.7]};
        Robot.OriLim={[-180 180],[-180 180],[-180 180]};
        %Limites articulares
        Robot.AngleLimits={[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],...
                     [-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],...
                     [-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135],[-135 135]};
        Robot.ColorNames={'Head','Chest','Material 1','Material 2','Pelvis','Kinematic Chain','CoM''s'};
        
end

HumRob_vrmlWorld = vrworld(HumRob_wrlFile);
open(HumRob_vrmlWorld);
Robot.vrRobot=vrnode(HumRob_vrmlWorld,'Robot');
Robot.vrFloor=vrnode(HumRob_vrmlWorld,'Floor');

% vrFigure
scrsz = get(0,'ScreenSize');
vrFigure=view(HumRob_vrmlWorld);
set(vrFigure,'Position',[11 282 444 421]);
set(vrFigure,'Name',Str_Robot);
set(vrFigure,'NavMode','examine');
set(vrFigure,'NavSpeed','fast');
set(vrFigure,'NavPanel','translucent');

A02_Create_Interface;