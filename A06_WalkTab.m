function A06_WalkTab

global MainFigure
global Strct_MainFigure
global Robot
global RRobot
global WlkTab
global Walk
global Cnnct

RRobot.Keys_PRTCL={'A','B','C','G','L'};
Strct_MainFigure.Panel_WalkTab=uipanel('Parent',MainFigure,'Units','Normalized','position',[0.01 0.01 0.98 0.91],...
    'visible','on');

%%Parametros Principales
%%------------------------------------------------------------------------
uiPnl_WLK_Main=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.01 0.9 0.2 0.1],...
    'Title','Main','TitlePosition','centertop');
Texts_WLK_Main={'PEL','FEET','ARM','TIME'};
XSize=0.24;
for i=1:4
    WlkTab.PshBttn_Main_PRM_1{i}=uicontrol('Parent',uiPnl_WLK_Main, 'Style','PushButton','units','normalized','Position',[(i)*XSize-XSize 0.01 0.23 0.95],...
        'Callback', 'E_WlkTab_PshBttn_PAR_Main(gcbo)','String',Texts_WLK_Main{i},'FontSize',08,'tag',num2str(i));
    if i==1
        set(WlkTab.PshBttn_Main_PRM_1{i},'fontweight','bold')
    end
end
    
WalkTab.Names_1={'N:', 'CP x:', 'CP z:','CP phi:', 'DP y:','DP th:',...
            'DF x:', 'DF y:','DF z:','DF psi:','CS th:','CS phi:','CE phi','DS th:',...
            'T:','T ymax:','t ini:','T ss'};
WlkTab.mins_1=[   0, -5.0    0 -20   0  0,-20 -10    0  -40, -100 -100 -100 -100,    0    0    0    0];
WlkTab.maxs_1=[  10,  5.0   17  20   5 20, 20  10    5   40,  100  100  100  100, 8000 5000 5000 5000];
WlkTab.steps_1=[  1,  0.1 0.25   1 0.1  1,  1   1  0.5    1,    5    5    5    5    50   50   50   50];
WlkTab.PNL_Values1=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.4 0.08 0.38 0.9],...
    'Title','Main Param','TitlePosition','centertop','visible','on');
for i=1:18
    WlkTab.PshBttn_PRM_1{i}=uicontrol(  'Parent',WlkTab.PNL_Values1,'Style','text','units','normalized',...
        'Position',[0.005 (19-i)*(0.054)-0.03 0.14 0.043],...
        'HorizontalAlignment','right','String',WalkTab.Names_1{i},'FontSize',8);    
    WlkTab.Slider_PRM_1{i} = uicontrol('Parent',WlkTab.PNL_Values1, 'Style','slider','units','normalized',...
        'Position',[0.2 (19-i)*(0.054)-0.03 0.6 0.043],'value',Walk.Values_1(i),...
        'Tag',num2str(i),'Callback', 'E_WlkTab_Sldr_Prmtr(gcbo)','min', WlkTab.mins_1(i), 'max', WlkTab.maxs_1(i));
    WlkTab.Edit_PRM_1{i} = uicontrol('Parent',WlkTab.PNL_Values1, 'Style','edit','units','normalized',...
        'Position',[0.82 (19-i)*(0.054)-0.03 0.15 0.043],'Tag',num2str(i),'Callback', 'E_WlkTab_Edt_Prmtr(gcbo)',...
        'BackgroundColor','w','string',num2str(Walk.Values_1(i)));
        SldrStp=WlkTab.steps_1(i)/(WlkTab.maxs_1(i)-WlkTab.mins_1(i));
        set(WlkTab.Slider_PRM_1{i},'sliderstep',[SldrStp 5*SldrStp]);     
end
for i=2:6
   set(WlkTab.PshBttn_PRM_1{i},'fontweight','bold');
end

%%Parametros Patada
%%------------------------------------------------------------------------
uiPnl_WLK_Main=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.06 0.8 0.2 0.1],...
    'Title','Kick','TitlePosition','centertop');
WlkTab.PshBttn_Kick=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab,'style','radiobutton',...
    'Units','Normalized','position',[0.28 0.8 0.06 0.03],'string','Kick','value',0,'callback','E_WlkTab_PshBttn_Kick(gcbo)');
Robot.Kick=0;
Texts_WLK_Main={'PEL','FEET','ARM','TIME'};
XSize=0.24;
for i=1:4
    WlkTab.PshBttn_Kick_PRM_4{i}=uicontrol('Parent',uiPnl_WLK_Main, 'Style','PushButton','units','normalized','Position',[(i)*XSize-XSize 0.01 0.23 0.95],...
        'Callback', 'E_WlkTab_PshBttn_PAR_Kick(gcbo)','String',Texts_WLK_Main{i},'FontSize',08,'tag',num2str(i));
end
    
WalkTab.Names_4={'N:', 'CP x:', 'CP z:','CP phi:', 'DP y:','DP th:',...
            'DF x:', 'DF y:','DF z:','DF psi:','CS th:','CS phi:','CE phi','DS th:',...
            'T:','T ymax:','t ini:','T ss','T_fmax'};
WlkTab.mins_4=[   0, -5.0    0 -20   0  0,-20 -10    0  -40, -100 -100 -100 -100,    0    0    0    0  0];
WlkTab.maxs_4=[  10,  5.0   17  20   5 20, 20  10    5   40,  100  100  100  100, 8000 5000 5000 5000 1000];
WlkTab.steps_4=[  1,  0.1 0.25   1 0.1  1,  1   1  0.5    1,    5    5    5    5    50   50   50   50 10];
WlkTab.PNL_Values4=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.4 0.08 0.38 0.9],...
    'Title','Main Param','TitlePosition','centertop','visible','off');
for i=1:19
    WlkTab.PshBttn_PRM_4{i}=uicontrol(  'Parent',WlkTab.PNL_Values4,'Style','text','units','normalized',...
        'Position',[0.005 (19-i)*(0.05)+0.03 0.14 0.043],...
        'HorizontalAlignment','right','String',WalkTab.Names_4{i},'FontSize',8);    
    WlkTab.Slider_PRM_4{i} = uicontrol('Parent',WlkTab.PNL_Values4, 'Style','slider','units','normalized',...
        'Position',[0.2 (19-i)*(0.05)+0.03 0.6 0.043],'value',Walk.Values_4(i),...
        'Tag',num2str(i),'Callback', 'E_WlkTab_Sldr_Prmtr(gcbo)','min', WlkTab.mins_4(i), 'max', WlkTab.maxs_4(i));
    WlkTab.Edit_PRM_4{i} = uicontrol('Parent',WlkTab.PNL_Values4, 'Style','edit','units','normalized',...
        'Position',[0.82 (19-i)*(0.05)+0.03 0.15 0.043],'Tag',num2str(i),'Callback', 'E_WlkTab_Edt_Prmtr(gcbo)',...
        'BackgroundColor','w','string',num2str(Walk.Values_4(i)));
        SldrStp=WlkTab.steps_4(i)/(WlkTab.maxs_4(i)-WlkTab.mins_4(i));
        set(WlkTab.Slider_PRM_4{i},'sliderstep',[SldrStp 5*SldrStp]);     
end
% for i=2:6
%    set(WlkTab.PshBttn_PRM_4{i},'fontweight','bold');
% end

%%Parametros RRobot
%%------------------------------------------------------------------------
uiPnl_WLK_RRobot=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.22 0.9 0.16 0.1],...
    'Title','RRobot','TitlePosition','centertop');
Texts_WLK_RRobot={'FEETA','RIGDL','RIGDR'};
XSize=0.33;
for i=1:3
    WlkTab.PshBttn_Main_PRM_2{i}=uicontrol('Parent',uiPnl_WLK_RRobot, 'Style','PushButton','units','normalized','Position',[(i)*XSize-XSize 0.01 0.31 0.95],...
        'Callback', 'E_WlkTab_PshBttn_PAR_RRobot(gcbo)','String',Texts_WLK_RRobot{i},'FontSize',08);
end
WalkTab.Texts_2={'DLF x:','DLF y:','DLF z:','DLF psi:',...
            'LAS Fr:','LKS Fr:','LHS Fr:','LAS La:','LHS La:',...
            'LANS Fr:','LKNS Fr:','LHNS Fr:','LANS La:','LHNS La:',...
            'DRF x:','DRF y:','DRF z:','DRF psi:',...
            'RAS Fr:','RKS Fr:','RHS Fr:','RAS La:','RHS La:',...
            'RANS Fr:','RKNS Fr:','RHNS Fr:','RANS La:','RHNS La:'};
WlkTab.PNL_Values2=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.4 0.08 0.38 0.9],...
    'Title','RRobot Param','TitlePosition','centertop','visible','off');  
WlkTab.mins_2=[  -2.0 -2.0 -2.0 -25 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15, -2.0 -2.0 -2.0 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15];
WlkTab.maxs_2=[   2.0  2.0  2.0  15  15 15 15 15 15 15 15 15 15 15,  2.0  2.0  2.0  15 15 15 15 15 15 15 15 15 15 15];
WlkTab.steps_2=[  0.1  0.1  0.1   1  1  1  1  1  1  1  1  1  1  1,  0.1  0.1  0.1   1  1  1  1  1  1  1  1  1  1  1];
for i=1:14
    if i < 5
        y_offset=0.05;
    else
        y_offset=0.03;
    end
    WlkTab.PshBttn_PRM_2{i}=uicontrol(  'Parent',WlkTab.PNL_Values2,'Style','text','units','normalized',...
        'Position',[0.001 (14-i)*(0.068)+y_offset 0.16 0.043],...
        'HorizontalAlignment','right','String',WalkTab.Texts_2{i},'FontSize',8);    
    WlkTab.Slider_PRM_2{i} = uicontrol('Parent',WlkTab.PNL_Values2, 'Style','slider','units','normalized',...
        'Position',[0.18 (14-i)*(0.068)+y_offset 0.22 0.043],'value',Walk.Values_2(i),...
        'Tag',num2str(i),'Callback', 'E_WlkTab_Sldr_Prmtr(gcbo)','min', WlkTab.mins_2(i), 'max', WlkTab.maxs_2(i));
    WlkTab.Edit_PRM_2{i} = uicontrol('Parent',WlkTab.PNL_Values2, 'Style','edit','units','normalized',...
        'Position',[0.41 (14-i)*(0.068)+y_offset 0.07 0.043],'Tag',num2str(i),'Callback', 'E_WlkTab_Edt_Prmtr(gcbo)',...
        'BackgroundColor','w','string',num2str(Walk.Values_2(i)));
    SldrStp=WlkTab.steps_2(i)/(WlkTab.maxs_2(i)-WlkTab.mins_2(i));
    set(WlkTab.Slider_PRM_2{i},'sliderstep',[SldrStp 5*SldrStp]);
end

for i=15:28
    if i < 19
        y_offset=0.05;
    else
        y_offset=0.03;
    end
    WlkTab.PshBttn_PRM_2{i}=uicontrol(  'Parent',WlkTab.PNL_Values2,'Style','text','units','normalized',...
        'Position',[0.505 (28-i)*(0.068)+y_offset 0.16 0.043],...
        'HorizontalAlignment','right','String',WalkTab.Texts_2{i},'FontSize',8);    
    WlkTab.Slider_PRM_2{i} = uicontrol('Parent',WlkTab.PNL_Values2, 'Style','slider','units','normalized',...
        'Position',[0.67 (28-i)*(0.068)+y_offset 0.22 0.043],'value',Walk.Values_2(i),...
        'Tag',num2str(i),'Callback', 'E_WlkTab_Sldr_Prmtr(gcbo)','min', WlkTab.mins_2(i), 'max', WlkTab.maxs_2(i));
    WlkTab.Edit_PRM_2{i} = uicontrol('Parent',WlkTab.PNL_Values2, 'Style','edit','units','normalized',...
        'Position',[0.91 (28-i)*(0.068)+y_offset 0.07 0.043],'Tag',num2str(i),'Callback', 'E_WlkTab_Edt_Prmtr(gcbo)',...
        'BackgroundColor','w','string',num2str(Walk.Values_2(i)));
    SldrStp=WlkTab.steps_2(i)/(WlkTab.maxs_2(i)-WlkTab.mins_2(i));
    set(WlkTab.Slider_PRM_2{i},'sliderstep',[SldrStp 5*SldrStp]);    
end

%%Parametros FstStep
%%------------------------------------------------------------------------
Index=1;
for i=1:2
    for j=1:length(Walk.Frst_Indx{i})
        if i==1
            WalkTab.Texts_3(Index)=WalkTab.Names_1(Walk.Frst_Indx{i}(j));
            WlkTab.mins_3(Index)=WlkTab.mins_1(Walk.Frst_Indx{i}(j));
            WlkTab.maxs_3(Index)=WlkTab.maxs_1(Walk.Frst_Indx{i}(j));
            WlkTab.steps_3(Index)=WlkTab.steps_1(Walk.Frst_Indx{i}(j));            
        else
            WalkTab.Texts_3(Index)=WalkTab.Texts_2(Walk.Frst_Indx{i}(j));
            WlkTab.mins_3(Index)=WlkTab.mins_2(Walk.Frst_Indx{i}(j));
            WlkTab.maxs_3(Index)=WlkTab.maxs_2(Walk.Frst_Indx{i}(j));
            WlkTab.steps_3(Index)=WlkTab.steps_2(Walk.Frst_Indx{i}(j));
        end
        Index=Index+1;
    end
end
%WalkTab.Texts_3
WlkTab.PNL_Values3=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.4 0.08 0.38 0.9],...
    'Title','First Step Param','TitlePosition','centertop','visible','off');  
for i=1:29
    if i < 6
        x_offset=0.01;
        y_offset=0.15;
        x_L=0.1;
    elseif i < 10 
        x_offset=0.51;
        y_offset=0.43;
        x_L=0.1;
    elseif i < 20
        x_offset=0.1;
        y_offset=0.33;
        x_L=0.07;
    else
        x_offset=0.51;
        y_offset=0.94;        
        x_L=0.07;
    end
    WlkTab.PshBttn_PRM_3{i}=uicontrol(  'Parent',WlkTab.PNL_Values3,'Style','text','units','normalized',...
        'Position',[x_offset (14-i)*(0.06)+y_offset 0.05 0.041],...
        'HorizontalAlignment','right','String',WalkTab.Texts_3{i},'FontSize',8);    
    WlkTab.Slider_PRM_3{i} = uicontrol('Parent',WlkTab.PNL_Values3, 'Style','slider','units','normalized',...
        'Position',[x_offset+0.06 (14-i)*(0.06)+y_offset 0.24 0.041],'value',Walk.Values_3(i),...
        'Tag',num2str(i),'Callback', 'E_WlkTab_Sldr_Prmtr(gcbo)','min', WlkTab.mins_3(i), 'max', WlkTab.maxs_3(i));
    WlkTab.Edit_PRM_3{i} = uicontrol('Parent',WlkTab.PNL_Values3, 'Style','edit','units','normalized',...
        'Position',[x_offset+0.31 (14-i)*(0.06)+y_offset x_L 0.041],'Tag',num2str(i),'Callback', 'E_WlkTab_Edt_Prmtr(gcbo)',...
        'BackgroundColor','w','string',num2str(Walk.Values_3(i)));
    SldrStp=WlkTab.steps_3(i)/(WlkTab.maxs_3(i)-WlkTab.mins_3(i));
    set(WlkTab.Slider_PRM_3{i},'sliderstep',[SldrStp 5*SldrStp]);
end

if(Cnnct.CnnctnType==0)
    Estado='off';
else
    Estado='on';
end
%%Parametros Dibujar
%%------------------------------------------------------------------------
WlkTab.PshBttn_SND_Rbt=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab, 'Style','PushButton','units','normalized','Position',[0.5 0.02 0.1 0.05],...
        'Callback', 'E_WlkTab_PshBttn_SNDRbt()','String','SND Rbt','FontSize',10,'enable',Estado);
WlkTab.PshBttn_RCV_Rbt=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab, 'Style','PushButton','units','normalized','Position',[0.62 0.02 0.1 0.05],...
        'Callback', 'E_WlkTab_PshBttn_RCVRbt()','String','RCV Rbt','FontSize',10,'enable',Estado);

%%Parametros Dibujar
%%------------------------------------------------------------------------
%Panel para Dibujar trayectorias y traza
WlkTab.uiPnl_DRW=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.8 0.9 0.19 0.09],...
    'Title','Draw','TitlePosition','centertop','FontSize',9);
WlkTab.uiPnl_PshBttn_Tray=uicontrol('Parent',WlkTab.uiPnl_DRW,'style','radiobutton','units','normalized',...
    'position',[0.01 0.15 0.55 0.8],'string','Path','Value',1,'Callback','E_WlkTab_PshBttn_ShowTray(gcbo)');
WlkTab.uiPnl_Trace=uicontrol('Parent',WlkTab.uiPnl_DRW,'style','radiobutton','units','normalized',...
    'position',[0.59 0.15 0.4 0.8],'string','Erase','Value',1);
Robot.Plt_Try=1;

%Panel para paso: izquierda o derecha
%%------------------------------------------------------------------------
WlkTab.uiPnl_PASO=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.8 0.75 0.18 0.13],...
    'Title','First Step','TitlePosition','centertop','FontSize',9);
WlkTab.uiPnl_PasoBttnGrp=uibuttongroup('Parent',WlkTab.uiPnl_PASO,'units','normalized',...
    'position',[0.01 0.01 0.99 0.95],'BorderType','none','SelectionChangeFcn','E_WlkTab_BttnGrp_PazoIzqDer');
WlkTab.uiPnl_RdBttnIzquierda=uicontrol('Parent',WlkTab.uiPnl_PasoBttnGrp,'style','radiobutton','units','normalized',...
    'position',[0.01 0.65 0.4 0.4],'string','Left','Value',1);
WlkTab.uiPnl_RdBttnDerecha=uicontrol('Parent',WlkTab.uiPnl_PasoBttnGrp,'style','radiobutton','units','normalized',...
    'position',[0.01 0.1 0.4 0.4],'string','Right','Value',0);
WlkTab.uiPnl_RdBttnADJST=uicontrol('Parent',WlkTab.uiPnl_PASO,'style','radiobutton','units','normalized',...
    'position',[0.46 0.3 0.5 0.5],'string','Par ADJST','Value',0,'callback','E_WlkTab_RdBttn_PAR_Frst(gcbo)');
Robot.Drcha=0;

%%RRobot CMMND
%%------------------------------------------------------------------------
uiPnl_MARCHA=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.81 0.3 0.15 0.4],...
    'Title',{'RRobot', 'CMMND'},'TitlePosition','centertop','FontSize',9);
TextsMARCHA={'REST','PELVc','WLK'};%,...
    %'Marcha c/ patada izquierda','Marcha c/ patada derecha','Levantarse hacia ADELANTE','Levantarse hacia ATRAS'};
RRobot.Keys_CMMND={'0','1','2'};
for i=1:3
    WlkTab.PshBttnMARCHA{i}=uicontrol('Parent',uiPnl_MARCHA, 'Style','PushButton','units','normalized','Position',[0.1 (4-i)*0.21+0.21 0.8 0.15],...
        'Callback', 'E_WlkTab_PshBttnMARCHA(gcbo)','String',TextsMARCHA{i},'FontSize',10,'enable',Estado,'tag',num2str(i));
end
WlkTab.RdBttn_Sensado=uicontrol('Parent',uiPnl_MARCHA,'Style','RadioButton','units','normalized','Position',[0.1 0.26 0.8 0.1],...
    'String','Get Vars:','callback','E_WlkTab_RdBttn_Sensado');
WlkTab.PpUp_Sensado=uicontrol('Parent',uiPnl_MARCHA,'Style','PopupMenu','units','normalized','Position',[0.12 0.1 0.8 0.1],...
    'String',{'Des. Ang.', 'Des. Ang. Mot.', 'Real Ang.', 'Real Load', 'P', 'RF', 'LF'},...
    'enable','off');

%%Panel para guardar valores
%%------------------------------------------------------------------------
uiPnl_GUARDAR=uipanel('Parent',Strct_MainFigure.Panel_WalkTab,'Units','Normalized','position',[0.8 0.08 0.18 0.19],...
    'Title','Save parameters','TitlePosition','centertop');
WlkTab.PshBttn_RBT_LD=uicontrol('Parent',uiPnl_GUARDAR, 'Style','PushButton','units','normalized','Position',[0.05 0.5 0.45 0.45],...
    'Callback', 'E_WlkTab_PshBttnLEER_EEPROM','String','RBT Laod','Tag','L','FontSize',8,'Enable','off');
WlkTab.PshBttn_RBT_SV=uicontrol('Parent',uiPnl_GUARDAR, 'Style','PushButton','units','normalized','Position',[0.05 0.01 0.45 0.45],...
    'Callback', 'E_WlkTab_PshBttnESCR_EEPROM','String','RBT Save','Tag','G','FontSize',8,'Enable','off');
WlkTab.PshBttn_Lee_DD=uicontrol('Parent',uiPnl_GUARDAR, 'Style','PushButton','units','normalized','Position',[0.52 0.5 0.45 0.45],...
    'Callback', 'E_WlkTab_PshBttnLEER_DE_DD','String','PC Load','Tag','L','FontSize',8,'Enable','on');
WlkTab.PshBttn_Escr_DD=uicontrol('Parent',uiPnl_GUARDAR, 'Style','PushButton','units','normalized','Position',[0.52 0.01 0.45 0.45],...
    'Callback', 'E_WlkTab_PshBttnGUARDAR_DD(1)','String','PC Save','Tag','G','FontSize',8,'Enable','on');

Value=Walk.Values_1(3);
if Value > 0
    set(WlkTab.uiPnl_RdBttnIzquierda,'Value',1);
    set(WlkTab.uiPnl_RdBttnDerecha,'Value',0);
    Robot.Drcha=0;
elseif Value < 0
    set(WlkTab.uiPnl_RdBttnIzquierda,'Value',0);
    set(WlkTab.uiPnl_RdBttnDerecha,'Value',1);
    Robot.Drcha=1;
end

%Play Motion
%%------------------------------------------------------------------------
WlkTab.TggleBttn_PlayAnimation=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.02 0.715 0.07 00.05],'Style','ToggleButton',...
    'String','Play','callback','E_WlkTab_TggleBttn_PlayAnim(gcbo)');
WlkTab.Slider_TimePlayAnimation=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.02 0.67 0.31 0.025],'Style','slider',...
    'min',0,'max',1,'Callback','global StepForChange; E_WlkTab_Sldr_PlayAnim(gcbo)');
WlkTab.Edit_TimePlayAnimation=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.34 0.67 0.04 0.05],'Style','Edit');
WlkTab.Text_TimePlayAnimation=uicontrol('Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.09 0.72 0.07 0.03],'Style',...
    'text','String','Accelerate:');
WlkTab.PpupMenu_Acelerar= uicontrol('Parent',Strct_MainFigure.Panel_WalkTab, 'Style','popupmenu','Units','Normalized','Position',[0.16 0.74 0.06 0.02],...
    'String',{'01','02','05','10'},'Enable','on','FontWeight','bold','Callback', 'E_WlkTab_Ppup_Acel');
%%------------------------------------------------------------------------

%Botones para la vista
WlkTab.uiBttnGrp_ViewsWlk=uibuttongroup('Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.02 0.02 0.35 0.045],...
    'SelectionChangeFcn','E_WlkTab_BttnGrp_ViewsWlk','BorderType','none');
WlkTab.uiRdBttn_Lat = uicontrol('Parent',WlkTab.uiBttnGrp_ViewsWlk,'Style','Radio','String','Lateral',... 
                                    'units','normalized','Position',[0.01 0.01 0.2 0.9],'TooltipString','Lateral View','Value',0);
WlkTab.uiRdBttn_Prsv = uicontrol('Parent',WlkTab.uiBttnGrp_ViewsWlk,'Style','Radio','String','Perspectiva',... 
                                    'units','normalized','Position',[0.23 0.01 0.29 0.9],'TooltipString','Perspective View','Value',1);
WlkTab.uiRdBttn_Frnt = uicontrol('Parent',WlkTab.uiBttnGrp_ViewsWlk,'Style','Radio','String','Front',... 
                                    'units','normalized','Position',[0.55 0.01 0.2 0.9],'TooltipString','Front View','Value',0);
WlkTab.uiRdBttn_Up = uicontrol('Parent',WlkTab.uiBttnGrp_ViewsWlk,'Style','Radio','String','Upper',... 
                                    'units','normalized','Position',[0.74 0.01 0.2 0.9],'TooltipString','Upper view','Value',0);
%Panel del Plot
%%------------------------------------------------------------------------
WlkTab.Panel_PlotIK=uipanel(   'Parent',Strct_MainFigure.Panel_WalkTab,'units','normalized','position',[0.02 0.07 0.37 0.6],'Title',...
    'Direct Kinematics','TitlePosition',' centertop'); 
WlkTab.Axes=axes('parent',WlkTab.Panel_PlotIK);

grid on
axis equal
axis(Robot.Axis);
view(59,27);
set(WlkTab.Axes,'CameraViewAngle',7);
xlabel('x');
ylabel('y');
zlabel('z');
hold on

PlotBLD_Wlk(WlkTab.Axes)
