function A03_MainWindow

global MainFigure
global Strct_MainFigure
global Robot

MainFigure = dialog(  'Units','Normalized','Position',[0.344 0.0598 0.629 0.844],'Name', 'Humanoid Interact','WindowStyle', 'normal',...
                'CloseRequestFcn', 'MainWindow_ClsRqstFnc','Resize','on');
set(MainFigure,'Toolbar','figure');

%% Elements of the Main Window
uicontrol('Parent',MainFigure,'Style','text','Units','Normalized','position',[0.01 0.95 0.08 0.04],'String','Robot:',...
    'FontWeight','normal','FontSize',12);
Labels={'Bioloid (Real and Virtual)','Nao (Virtual)','Darwin (Virtual)','KHR-3HV (Virtual)'};
Strct_MainWindow.PPMenu_ChoseRobot= uicontrol('Parent',MainFigure, 'Style','popupmenu','Units','Normalized','Position',[0.09 0.95 0.2 0.04],...
    'String',Labels,'Enable','on','FontWeight','bold','Callback', 'A_Tabs_ChooseRbt');

%Toggle button para conectar o desconectarse del robot
Strct_MainFigure.PshBttn_CnnctRbt = uibutton('Parent',MainFigure, 'Style','pushbutton','units','normalized','Position',[0.33 0.93 0.08 0.06],...
    'Callback', 'D_MainFig_PshBttn_CnnctRbt','String',{'CNNCT','Rbt'},'Enable','off');
Strct_MainFigure.PshBttn_DisCnnctRbt = uibutton('Parent',MainFigure, 'Style','pushbutton','units','normalized','Position',[0.41 0.93 0.08 0.06],...
    'Callback', 'D_MainFig_PshBttn_DisCnnctRbt','String',{'DISCNNCT', 'Rbt'},'Enable','off');
Strct_MainFigure.RdBttn_CnnctRbt = uicontrol('Parent',MainFigure,'Style','radiobutton','units','normalized','Position',[0.5 0.93 0.10 0.03],...
    'Callback','','String','Cnnctn Type','Enable','off');
%Push button para resetar el puerto serial                                   
Strct_MainFigure.PshBttn_RstPorts = uicontrol('Parent',MainFigure, 'Style','togglebutton','units','normalized', 'Position',[0.5 0.96 0.11 0.03],...
    'Callback', 'D_MainFig_PshBttn_RstPrts','String','Reset Serial','Enable','on','Enable','off');

%%Botones y Paneles
Strct_MainFigure.PshBttn_VRMLTab = uicontrol('Parent',MainFigure, 'Style','pushbutton','Units','Normalized','Position',[0.68 0.93 0.07 0.06],...
    'Callback', 'A_Tabs_PshBttn_EditRobot','String','VR','Enable','on','FontSize',14);                    

Strct_MainFigure.PshBttn_KinTab = uicontrol('Parent',MainFigure, 'Style','pushbutton','Units','Normalized','Position',[0.75 0.93 0.07 0.06],...
    'Callback', 'A_Tabs_PshBttn_IK','String','KIN','Enable','on','FontWeight','normal','FontSize',14);

Strct_MainFigure.PshBttn_WalkTab = uicontrol('Parent',MainFigure, 'Style','pushbutton','Units','Normalized','Position',[0.825 0.93 0.07 0.06],...
    'Callback', 'A_Tabs_PshBttn_WlkPrm','String','WLK','Enable','on','FontWeight','bold','FontSize',14,'Enable','off');

Strct_MainFigure.PshBttn_PlotsTab = uicontrol('Parent',MainFigure, 'Style','pushbutton','Units','Normalized','Position',[0.9 0.93 0.07 0.06],...
    'Callback', 'A_Tabs_PshBttn_PLtTrys','String','PLT','Enable','on','FontWeight','normal','FontSize',14,'Enable','off');

if Robot.Connectable
    set(Strct_MainFigure.PshBttn_CnnctRbt,'Enable','on');
    set(Strct_MainFigure.PshBttn_RstPorts,'Enable','on');
    set(Strct_MainFigure.PshBttn_WalkTab,'Enable','on');
    set(Strct_MainFigure.PshBttn_PlotsTab,'Enable','on');
end

