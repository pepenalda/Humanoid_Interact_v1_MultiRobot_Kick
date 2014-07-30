function A04_EditVRMLTab
global MainFigure
global Strct_MainFigure
global VRMLTab
global Robot

%Panel Edit Robot
Strct_MainFigure.Panel_VRMLTab=uipanel('Parent',MainFigure,'Units','Normalized','position',[0.01 0.01 0.98 0.91],...
    'visible','on');

VRMLTab.Panel_Transparency=uipanel('Parent',Strct_MainFigure.Panel_VRMLTab,'Units','Normalized','position',[0.01 0.02 0.58 0.95],...
    'Title','Transparency','TitlePosition',' centertop');
VRMLTab.BttnGrp_TransparencyElementSelect=uibuttongroup('Parent',VRMLTab.Panel_Transparency,'units','normalized',...
    'position',[0.01 0.01 0.4 0.95],'BorderType','none','SelectionChangeFcn','B_EditRobot_BttnGrp_TrnsprncyElmntSlct');
VRMLTab.RdBttn_RbtTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton',...
    'String','Robot','units','normalized','Position',[0.05 0.94 0.4 0.1],'TooltipString','set robot''s transparency','Value',1);
VRMLTab.RdBttn_HdChstTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Head Chest',...
    'units','normalized','Position',[0.05 0.85 0.6 0.1],'TooltipString','set head and chest ''s transparency','Value',0);
VRMLTab.RdBttn_KChTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Kinematic Chain',...
    'units','normalized','Position',[0.05 0.76 0.6 0.1],'TooltipString','set Kinematic chain''s transparency');
VRMLTab.RdBttn_AxsTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Motors Axis',...
    'units','normalized','Position',[0.05 0.67 0.6 0.1],'TooltipString','set Axes ''s transparency');
VRMLTab.RdBttn_FrmsTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Motors Frames',...
    'units','normalized','Position',[0.05 0.58 0.6 0.1],'TooltipString','set Frames ''s transparency');
VRMLTab.RdBttn_OFrmsTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Reference Frames',...
    'units','normalized','Position',[0.05 0.49 0.6 0.1],'TooltipString','set Origin Frame ''s transparency');                                
VRMLTab.RdBttn_EFrmsTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Extremities Frames',...
    'units','normalized','Position',[0.05 0.40 0.7 0.1],'TooltipString','set Extremities Frames ''s transparency');
VRMLTab.RdBttn_CoMTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','CoM',...
    'units','normalized','Position',[0.05 0.31 0.6 0.1],'TooltipString','set CoM transparency');
VRMLTab.RdBttn_CoMsTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','CoMs',...
    'units','normalized','Position',[0.05 0.22 0.6 0.1],'TooltipString','set CoM''s transparency');
VRMLTab.RdBttn_CarpetTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Carpet',...
    'units','normalized','Position',[0.05 0.13 0.6 0.1],'TooltipString','set Carpet''s transparency');
VRMLTab.RdBttn_FloorTr = uicontrol('Parent',VRMLTab.BttnGrp_TransparencyElementSelect, 'Style','radiobutton','String','Floor',...
    'units','normalized','Position',[0.05 0.04 0.6 0.1],'TooltipString','set Floor''s transparency');

VRMLTab.Pnl_OrgnFrms =uipanel('Parent',VRMLTab.Panel_Transparency,'units','normalized','Position',[0.33, 0.55, 0.25, 0.45],...
    'Title','Reference Frame');
VRMLTab.BttnGrp_OrgnFrms=uibuttongroup('parent',VRMLTab.Pnl_OrgnFrms,'units','normalized','position',[0 0 1 1],...
    'bordertype','none','SelectionChangeFcn','B_EditRobot_BttnGrp_OrgnFrms');
VRMLTab.OrgnFrmBttn01=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.84 0.7 0.15],'string','Torso',...
    'fontsize',7,'Enable','off');
VRMLTab.OrgnFrmBttn02=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.68 0.7 0.15],'string','Pelvis',...
    'fontsize',7,'Enable','off');
VRMLTab.OrgnFrmBttn03=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.51 0.7 0.15],'string','Left Shoulder',...
    'fontsize',7,'Enable','off');
VRMLTab.OrgnFrmBttn04=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.34 0.7 0.15],'string','Right Shoulder',...
    'fontsize',7,'Enable','off');
VRMLTab.OrgnFrmBttn05=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.17 0.7 0.15],'string','Left Hip',...
    'fontsize',7,'Enable','off');
VRMLTab.OrgnFrmBttn06=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OrgnFrms,'units','normalized','position',[0.1 0.01 0.7 0.15],'string','Right Hip',...
    'fontsize',7,'Enable','off');
set(VRMLTab.BttnGrp_OrgnFrms,'SelectedObject',VRMLTab.OrgnFrmBttn01);

VRMLTab.Pnl_ExtrmtyFrms =uipanel('Parent',VRMLTab.Panel_Transparency,'units','normalized','Position',[0.33, 0.055, 0.25, 0.45],...
    'Title','Extremity Frame');
VRMLTab.BttnGrp_ExtrmtyFrms=uibuttongroup('parent',VRMLTab.Pnl_ExtrmtyFrms,'units','normalized','position',[0 0 1 1],...
    'bordertype','none','SelectionChangeFcn','B_EditRobot_BttnGrp_ExtmyFrms');
VRMLTab.ExtmyFrmBttn01=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.85 0.8 0.15],...
    'string','Left Hand','Enable','off');
VRMLTab.ExtmyFrmBttn02=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.7 0.8 0.15],...
    'string','Right Hand','Enable','off');
VRMLTab.ExtmyFrmBttn03=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.55 0.8 0.15],...
    'string','Left Ankle','Enable','off');
VRMLTab.ExtmyFrmBttn04=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.4 0.8 0.15],...
    'string','Left Foot','Enable','off');
VRMLTab.ExtmyFrmBttn05=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.25 0.8 0.15],...
    'string','Right Ankle','Enable','off');
VRMLTab.ExtmyFrmBttn06=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_ExtrmtyFrms,'units','normalized','position',[0.1 0.1 0.8 0.15],...
    'string','Right Foot','Enable','off');
set(VRMLTab.BttnGrp_ExtrmtyFrms,'SelectedObject',VRMLTab.ExtmyFrmBttn01);

VRMLTab.Pnl_MtrFrms =uipanel('Parent',VRMLTab.Panel_Transparency,'units','normalized','Position',[0.6, 0.05, 0.25, 0.95],'Title',...
    'Element select','visible','on');
VRMLTab.BttnGrp_AxsFrm=uibuttongroup('parent',VRMLTab.Pnl_MtrFrms,'units','normalized','position',[0.02 0.87 0.95 0.07],...
    'bordertype','none','SelectionChangeFcn','B_EditRobot_BttnGrp_AxsFrm');
VRMLTab.Bttn_CoMs=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_AxsFrm,'units','normalized','position',[0.35 0.8 0.52 0.95],...
    'string','CoMs','fontsize',7,'Enable','off');
VRMLTab.Bttn_Axs=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_AxsFrm,'units','normalized','position',[0.01 0.01 0.52 0.95],...
    'string','Axis','fontsize',7,'Enable','off');
VRMLTab.Bttn_Frms=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_AxsFrm,'units','normalized','position',[0.55 0.01 0.47 0.95],...
    'string','Frame','fontsize',7,'Enable','off');
VRMLTab.BttnGrp_OneAll=uibuttongroup('parent',VRMLTab.Pnl_MtrFrms,'units','normalized','position',[0.02 0.77 0.95 0.07],...
    'bordertype','none','SelectionChangeFcn','B_EditRobot_BttnGrp_OneAll');
VRMLTab.Bttn_One=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OneAll,'units','normalized','position',[0.01 0.01 0.52 0.95],...
    'string','All','fontsize',7,'Enable','off');
VRMLTab.Bttn_All=uicontrol('style','radiobutton','parent',VRMLTab.BttnGrp_OneAll,'units','normalized','position',[0.55 0.01 0.47 0.95],...
    'string','One','fontsize',7,'Enable','off');
BttnsStrngs={'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18'};
for i=1:9
    VRMLTab.RdBtn_MtrFrm{i} =uicontrol('style','radiobutton','parent',VRMLTab.Pnl_MtrFrms ,'units','normalized',...
        'min',0,'max',1,'position',[0.1 0.65-0.075*(i-1) 0.35 0.044],'String',BttnsStrngs{i},'value',1,'Enable','off',...
        'CallBack','B_EditRobot_RdBttn_MtrAxsFrm(gcbo)');
end
for i=10:18
    VRMLTab.RdBtn_MtrFrm{i} =uicontrol('style','radiobutton','parent',VRMLTab.Pnl_MtrFrms ,'units','normalized',...
        'min',0,'max',1,'position',[0.6 0.65-0.075*(i-10) 0.35 0.044],'String',BttnsStrngs{i},'value',1,'Enable','off',...
        'CallBack','B_EditRobot_RdBttn_MtrAxsFrm(gcbo)');
end

VRMLTab.Slder_TrsprncyValue = uicontrol('Parent',VRMLTab.Panel_Transparency, 'Style','slider','units','normalized',...
    'Position',[0.9 0.05 0.06 0.8],'Min', 0, 'Max', 1,'Callback', 'B_EditRobot_Slder_Trnsprncy(get(gco,(''Value'')))');
VRMLTab.Edt_TrsprncyValue=uicontrol( 'Parent',VRMLTab.Panel_Transparency,'Style','edit','units','normalized',...
    'Position',[0.88 0.9 0.1 0.08],'HorizontalAlignment','left', 'BackgroundColor','w','CreateFcn',...
    'B_EditRobot_Edt_Trsprncy_CreateFcn(gcbo)','Enable','off');

%Panel de colores
VRMLTab.Panel_Clrs=uipanel('Parent',Strct_MainFigure.Panel_VRMLTab,'units','normalized','position',[0.61 0.2 0.35 0.55],...
    'Title','Colors','TitlePosition',' centertop');                                
VRMLTab.BttnGrp_ClrsElmentSlct=uibuttongroup('Parent',VRMLTab.Panel_Clrs,'units','normalized','position',[0.01 0.05 0.4 0.95],...
    'BorderType','none','SelectionChangeFcn','B_EditRobot_BttnGrp_ClrElmntSlct');
for i=1:length(Robot.ColorNames)
VRMLTab.RdBttn_MtrsClr = uicontrol('Parent',VRMLTab.BttnGrp_ClrsElmentSlct,'Style','Radio','String',Robot.ColorNames{i},... 
                                    'units','normalized','Position',[0.05 0.84-(i-1)*0.14 1 0.14]);
end

color=B_EditRobot_Fnc_GetPartColor(VRMLTab.BttnGrp_ClrsElmentSlct);

VRMLTab.uiPnl_ClrSmpl = uicontrol('Parent',VRMLTab.Panel_Clrs,'Style','text','units','normalized','BackgroundColor',color,...
    'Position',[0.6 0.4 0.3 0.3]);

VRMLTab.uiPshBttn_ChngClr=uicontrol('Parent',VRMLTab.Panel_Clrs,'Style','PushButton','String','set color',... 
    'units','normalized','Position',[0.4 0.5 0.15 0.1],'Callback','B_EditRobot_PshBttn_ChngClr');