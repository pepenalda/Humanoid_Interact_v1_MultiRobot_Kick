function A05_KinematicsTab

global MainFigure
global Strct_MainFigure
global IKTab
global Robot

String_Pos={'x','y','z'};
String_Ori1={'phi(y)','th(x)','psi(z)'};

Strct_MainFigure.Panel_KinTab=uipanel('Parent',MainFigure,'Units','Normalized','position',[0.01 0.01 0.98 0.91],...
    'visible','on');

%%Botones Generales
%Push button para obtener los valores de los angulos del robot
IKTab.PshBttn_GtAngls = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','pushbutton','units','normalized', 'Position',[0.03 0.93 0.09 0.068],...
    'Callback', 'C_IKTab_PshBttn_GetAngles','String','GET ANG','Enable','off','FontSize',10);
%Push button para poner los angulos del robot
IKTab.PshBttn_StAngls = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','pushbutton','units','normalized', 'Position',[0.15 0.93 0.09 0.068],...
    'Callback', 'C_IKTab_PshBttn_SetAngles','String','SET ANG.','Enable','off','FontSize',10);
%Push button para encender los motores del robot
IKTab.PshBttn_AllTrqsOn = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','pushbutton','units','normalized', 'Position',[0.25 0.93 0.09 0.065],...
    'Callback', 'C_IKTab_PshBttn_AllTorquesOn','String','MTRS ON','Enable','off','FontSize',10);
%Push button para encender los motores del robot
IKTab.PshBttn_AllTrqsOff = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','pushbutton','units','normalized', 'Position',[0.35 0.93 0.09 0.065],...
    'Callback', 'C_IKTab_PshBttn_AllTorquesOff','String','MTRS OFF','Enable','off','FontSize',10);
%Push button para ir a ceros
MainFig.PshBttn_GoZs = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','togglebutton','units','normalized', 'Position',[0.73 0.93 0.08 0.065],...
    'Callback', 'C_IKTab_PshBttn_GoZs','String','G0 ''0''','Enable','on','FontSize',10);
%Push button para ir a posicion vertical
MainFig.PshBttn_GoUp = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','togglebutton','units','normalized', 'Position',[0.82 0.93 0.08 0.065],...
    'Callback', 'C_IKTab_PshBttn_GoUp','String','GO UP','Enable','on','FontSize',10);
%Push button para ir a posicion home (listo para caminar)
MainFig.PshBttn_GoHome = uicontrol('Parent',Strct_MainFigure.Panel_KinTab, 'Style','togglebutton','units','normalized', 'Position',[0.91 0.93 0.08 0.065],...
    'Callback', 'C_IKTab_PshBttn_GoHm','String','GO HM','Enable','on','FontSize',10);

%--------------------------------
% Posiciones Angulares
IKTab.uiPanel_IK=uipanel('Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.47 0.01 0.24 0.97],'Title','Motor''s Angles',...
    'TitlePosition',' centertop');
Panel=IKTab.uiPanel_IK;
Ini_Y=0.99;

switch Robot.Name
    case 'Bioloid'
        D_Y=0.0515;
    case 'Nao'
        D_Y=.91/Robot.N;
end
for i=1:Robot.N
    %Recupera el vector de rotacion de las articulaciones del robot virtual
    String_i=num2str(i,'%02d');
    String_MotorField_i=['rotation_Servo' num2str(i,'%d')];
    Robot.vecrot_i=getfield(Robot.vrRobot,String_MotorField_i);
    
    %Limites articulares
    minAngleRot_i=Robot.AngleLimits{i}(1)*pi/180;
    maxAngleRot_i=Robot.AngleLimits{i}(2)*pi/180;
    
    %RdBttn IJ
    IKTab.RdBttn_Art{i} = uicontrol('Parent',Panel, 'Style','radiobutton','units','normalized',...
        'Position',[0.01 (-i)*D_Y+Ini_Y 0.08 D_Y-0.01], ...
        'Tag',num2str(i),'Enable','off','TooltipString','activate motor in robot');        
    %Texto en la uicontrol (Motor ID)
    IKTab.TxtMtrNmbr{i}=uicontrol(  'Parent',Panel,'Style','text','units','normalized','Position',...
        [0.1 (-i)*D_Y+Ini_Y 0.1 D_Y-0.01],'HorizontalAlignment','left','String',String_i);    
    %Sliders en la uicontrol
    IKTab.Slider_Art{i} = uicontrol('Parent',Panel, 'Style','slider','units','normalized',...
        'Position',[0.18 (-i)*D_Y+Ini_Y 0.58 D_Y-0.01],'Min', minAngleRot_i, 'Max', maxAngleRot_i,...
        'Tag',num2str(i),'Callback', 'C_IKTab_Slider_Art(get(gco,(''Tag'')),get(gco,(''Value'')))',...
        'CreateFcn','global Robot; set(gcbo,''Value'',Robot.vecrot_i(4));');
    %Edit en la uicontrol (Valor del angulo Deg)
    IKTab.Edit_Art{i}=uicontrol( 'Parent',Panel,'Style','edit','units','normalized',...
        'Position',[0.80 (-i)*D_Y+Ini_Y 0.18 D_Y-0.01],...
        'HorizontalAlignment','right', 'String','','BackgroundColor','w','Tag',num2str(i),...
        'Callback', 'C_IKTab_Edit_Art(get(gco,(''Tag'')),get(gco,(''String'')))',...
        'CreateFcn','global Robot; set(gcbo,''String'',num2str(Robot.vecrot_i(4)*180/pi,''%3.1f''));');
end

if Robot.Connectable
    uicontrol(  'Parent',IKTab.uiPanel_IK,'Style','text','units','normalized','Position',[0.02 0.002 0.32  0.05],...
        'HorizontalAlignment','left','String','Velocity','FontWeight','bold');
    if strcmp(Robot.Name,'Bioloid')
        MaxVel=1024;
        CurrentVel=50;
    elseif strcmp(Robot.Name,'Nao')
        MaxVel=1;
        CurrentVel=0.5;
    end
    IKTab.Slider_Vel = uicontrol('Parent',IKTab.uiPanel_IK, 'Style','slider','units','normalized',...
        'Position',[0.27 0.005 0.49 0.04],'Min', 0, 'Max', MaxVel,...
        'Callback', 'C_IKTab_Slider_Vel(get(gco,''Value''))','Value',CurrentVel);
    IKTab.Edit_Vel = uicontrol( 'Parent',IKTab.uiPanel_IK,'Style','edit','units','normalized','Position',[0.80 0.005 0.18 0.04],...
        'HorizontalAlignment','left','String','','BackgroundColor','w',...
        'Callback', 'C_IKTab_Edit_Vel(get(gco,(''String'')))','CreateFcn','global IKTab; set(gcbo,''String'',num2str(get(IKTab.Slider_Vel,''Value'')));');
end

%Botones de apoyo
IKTab.Panel_Support=uipanel(   'Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.73 0.78 0.25 0.14],...
    'Title','Support','TitlePosition',' centertop');
IKTab.RdBttn_SupLeft = uicontrol('Parent',IKTab.Panel_Support,'Style','Radio','String','Left Support','units','normalized',...
    'Position',[0.01 0.59 0.4 0.35],'TooltipString','Symetric 2','Value',0,'FontSize',7,'Callback','C_IKTab_RdBttn_SupLeft');
IKTab.RdBttn_SupRight = uicontrol('Parent',IKTab.Panel_Support,'Style','Radio','String','Right Support','units','normalized',...
    'Position',[0.5 0.59 0.49 0.35],'TooltipString','Symetric 2','Value',0,'FontSize',7,'Callback','C_IKTab_RdBttn_SupRight');
IKTab.RdBttn_DSup = uicontrol('Parent',IKTab.Panel_Support,'Style','Radio','String','Double Support','units','normalized',...
    'Position',[0.25 0.15 0.5 0.35],'TooltipString','Symetric 1','Value',0,'FontSize',7,'Callback','C_IKTab_RdBttn_DSup');

%Botones de simetría
IKTab.Panel_Symetry=uipanel(   'Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.73 0.53 0.25 0.23],'Title','Symmetry',...
    'TitlePosition',' centertop');
uicontrol(  'Parent',IKTab.Panel_Symetry,'Style','text','units','normalized','position',[0.05 0.83 0.2 0.15],'HorizontalAlignment','left',...
    'String','Hands');
IKTab.RdBttn_SymArms1 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','y = - y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymArms1','Position',[0.01 0.53 0.4 0.24],'TooltipString','Symetric 1','Value',0,'FontSize',7);
IKTab.RdBttn_SymArms2 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','y = y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymArms2','Position',[0.01 0.28 0.4 0.24],'TooltipString','Symetric 2','Value',0,'FontSize',7);
IKTab.RdBttn_SymArms3 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','x = - x; y = - y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymArms3','Position',[0.01 0.03 0.4 0.24],'TooltipString','Symetric 3','Value',0,'FontSize',7); 

uicontrol(  'Parent',IKTab.Panel_Symetry,'Style','text','units','normalized','position',[0.54 0.83 0.2 0.15],'HorizontalAlignment','left',...
    'String','Feet');
IKTab.RdBttn_SymLegs1 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','y = y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymLegs1','Position',[0.52 0.53 0.4 0.24],'TooltipString','Symetric 1','Value',0,'FontSize',7);
IKTab.RdBttn_SymLegs2 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','y = - y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymLegs2','Position',[0.52 0.28 0.4 0.24],'TooltipString','Symetric 2','Value',0,'FontSize',7);
IKTab.RdBttn_SymLegs3 = uicontrol('Parent',IKTab.Panel_Symetry,'Style','Radio','String','x = - x; y = - y','units','normalized',...
    'Callback','C_IKTab_RdBttn_SymLegs3','Position',[0.52 0.03 0.4 0.24],'TooltipString','Symetric 2','Value',0,'FontSize',7);

%Panel de Cinematica inversa
IKTab.Panel_IK=uipanel(   'Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.73 0.02 0.25 0.50],'Title','Inverse Kinematics',...
    'TitlePosition',' lefttop','visible','off');

%Boton para Mover el robot
uicontrol('Parent',IKTab.Panel_IK,'style','text','units','normalized','Position',[0.78 0.9 0.17 0.13],'String','Move Robot');
IKTab.RdBttn_IKMvRbt = uicontrol('Parent',IKTab.Panel_IK,'Style','Radio','units','normalized',...
    'Position',[0.85 0.81 0.07 0.07],'Value',0,'Enable','off');

%Selecciona la extremidad
uicontrol('Parent',IKTab.Panel_IK,'Style','text','Units','Normalized','position',[0.01 0.84 0.28 0.1],'String','Extremity:',...
    'FontWeight','bold');

Robot.IK_Key=1;
IKTab.Ppup_IKExtremity= uicontrol('Parent',IKTab.Panel_IK, 'Style','popupmenu','Units','Normalized','Position',[0.31 0.88 0.4 0.08],...
    'String',{'Right Hand','Left Hand','Right Ankle','Left Ankle','Pelvis'},'Enable','on','FontWeight','bold','Callback', 'C_IKTab_Ppup_IKExtrmty');
for j=1:3
    uicontrol(  'Parent',IKTab.Panel_IK,'Style','text','units','normalized','Position',[0.03 ((4-j)*0.13+0.26) 0.05 0.10],'HorizontalAlignment','left','String',String_Pos{j});
    IKTab.Slider_Pos{j} = uicontrol('Parent',IKTab.Panel_IK, 'Style','slider','units','normalized',...
        'Position',[0.1 ((4-j)*0.13+0.28) 0.65 0.10],'Min', Robot.PosLim{j}(1), 'Max', Robot.PosLim{j}(2),...
        'Tag',num2str(j),'Callback', 'C_IKTab_Slider_Pos(get(gco,(''Tag'')),get(gco,(''Value'')))');
    IKTab.Edit_Pos{j}=uicontrol( 'Parent',IKTab.Panel_IK,'Style','edit','units','normalized',...
        'Position',[0.8 ((4-j)*0.13+0.28) 0.17 0.10],...
        'HorizontalAlignment','right','String','','BackgroundColor','w','Tag',num2str(j),...
        'Callback', 'C_IKTab_Edit_Pos(get(gco,(''Tag'')),get(gco,(''String'')),1)');
    IKTab.Txt_Ori1{j}=uicontrol(  'Parent',IKTab.Panel_IK,'Style','text','units','normalized','Position',[0.01 ((4-j)*0.13-0.1) 0.15 0.10],...
        'HorizontalAlignment','right','String',String_Ori1{j});
    set(IKTab.Txt_Ori1{j},'visible','off');
    IKTab.Slider_Ori{j} = uicontrol('Parent',IKTab.Panel_IK, 'Style','slider','units','normalized',...
        'Position',[0.18 ((4-j)*0.13-0.10) 0.57 0.10], 'Min', Robot.OriLim{j}(1), 'Max', Robot.OriLim{j}(2),'Tag',num2str(j),...
        'visible','off','Callback', 'C_IKTab_Slider_Pos(get(gco,(''Tag'')),get(gco,(''Value'')))');
    IKTab.Edit_Ori{j}=uicontrol( 'Parent',IKTab.Panel_IK,'Style','edit','units','normalized','Position',[0.8 ((4-j)*0.13-0.1) 0.17 0.10],...
        'HorizontalAlignment','right','String','','BackgroundColor','w','Tag',num2str(j),...
        'Callback', 'C_IKTab_Edit_Pos(get(gco,(''Tag'')),get(gco,(''String'')),2)','Enable','off');    
end
if Robot.Connectable
    set(IKTab.Panel_IK,'visible','on');
end
    
%Panel del Plot
IKTab.Panel_PlotIK=uipanel(   'Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.02 0.07 0.43 0.86],'Title',...
    'Direct Kinematics','TitlePosition',' centertop');
IKTab.Axes=axes('parent',IKTab.Panel_PlotIK);

grid on
axis equal
axis(Robot.Axis);
view(59,27);
%set(IKTab.Axes,'CameraViewAngle',5);
xlabel('x');
ylabel('y');
zlabel('z');
hold on

PlotRBT(IKTab.Axes);

IKTab.uiRdBttn_Mv_Rbt=uicontrol('parent',IKTab.Panel_PlotIK,'style','radio','units','normalized','position',[0.38, 0.9, 0.25, 0.05],...
    'String','Move REAL Robot','Visible','off');
%Botones para la vista
IKTab.uiBttnGrp_Views=uibuttongroup('Parent',Strct_MainFigure.Panel_KinTab,'units','normalized','position',[0.02 0.02 0.45 0.045],...
    'SelectionChangeFcn','C_IKTab_BttnGrp_ViewsIK','BorderType','none');
IKTab.uiRdBttn_Lat = uicontrol('Parent',IKTab.uiBttnGrp_Views,'Style','Radio','String','Lateral',... 
                                    'units','normalized','Position',[0.05 0.01 0.25 0.9],'TooltipString','Lateral View','Value',0);
IKTab.uiRdBttn_Prsv = uicontrol('Parent',IKTab.uiBttnGrp_Views,'Style','Radio','String','Perspectiva',... 
                                    'units','normalized','Position',[0.25 0.01 0.25 0.9],'TooltipString','Perspective View','Value',1);
IKTab.uiRdBttn_Frnt = uicontrol('Parent',IKTab.uiBttnGrp_Views,'Style','Radio','String','Front',... 
                                    'units','normalized','Position',[0.53 0.01 0.25 0.9],'TooltipString','Front View','Value',0);
IKTab.uiRdBttn_Up = uicontrol('Parent',IKTab.uiBttnGrp_Views,'Style','Radio','String','Upper',... 
                                    'units','normalized','Position',[0.74 0.01 0.25 0.9],'TooltipString','Upper view','Value',0);

                                