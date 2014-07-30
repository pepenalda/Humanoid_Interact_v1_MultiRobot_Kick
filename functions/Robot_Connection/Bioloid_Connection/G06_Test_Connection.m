function G06_Test_Connection

global Cnnct
global Robot

Connect_Status=1;
switch Cnnct.CnnctnType
    case 1
        for i=1:Robot.N
            Answr(i)=ping(i);
            if Answr(i) ==1
            else
                Connect_Status=0;
            end
        end
    case 2
        dsp('not programmed');
    case 3
end

if Connect_Status==1
    switch Cnnct.CnnctnType
        case 1
            figSP.Info=figure('Name','Connect Serial Toss Mode','MenuBar','none','Toolbar','none','units','normalized',...
                'OuterPosition',[0.3 , 0.4, 0.4, 0.2]);
            s=sprintf('Congratulations!!! The serial connection is ready and 18 Dynamixels responded! ');
            InfoText=uicontrol('parent',figSP.Info,'style','text','string',s,...
                'units','normalized','position',[0.15 0.6 0.7 0.3],'fontsize',10);
            uicontrol('parent',figSP.Info,'style','pushbutton','string','OK','units','normalized',...
                'position',[0.35 0.2 0.3 0.3],'callback','closereq; ');
            set(figSP.Info,'Color',get(InfoText,'BackgroundColor'));
            G07_ActivateCnnct_Elements;
        case 2
            disp('not programmed')
        case 3
            figSP.Info=figure('Name','Connect zigbee','MenuBar','none','Toolbar','none','units','normalized',...
                'OuterPosition',[0.3 , 0.4, 0.4, 0.2]);
            s=sprintf('Congratulations!!! The zigbee transmision is ready...\nMake sure the corresponding firmware is set on the robot! ');
            InfoText=uicontrol('parent',figSP.Info,'style','text','string',s,...
                'units','normalized','position',[0.15 0.6 0.7 0.3],'fontsize',10);
            uicontrol('parent',figSP.Info,'style','pushbutton','string','OK','units','normalized',...
                'position',[0.35 0.2 0.3 0.3],'callback','closereq; ');
            set(figSP.Info,'Color',get(InfoText,'BackgroundColor'));
            G07_ActivateCnnct_Elements;
    end
else
    switch Cnnct.CnnctnType
        case 1
            figSP.Info=figure('Name','Connect Serial Toss Mode','MenuBar','none','Toolbar','none','units','normalized',...
                'OuterPosition',[0.3 , 0.4, 0.4, 0.2]);
            s=sprintf('A problem occured while connecting to robot \n Make sure controller is in Toss Mode and \n 18 Dynamixels are conected.');
            InfoText=uicontrol('parent',figSP.Info,'style','text','string',s,...
                'units','normalized','position',[0.15 0.6 0.7 0.3],'fontsize',10);
            uicontrol('parent',figSP.Info,'style','pushbutton','string','OK','units','normalized',...
                'position',[0.35 0.2 0.3 0.3],'callback','closereq; ');
            set(figSP.Info,'Color',get(InfoText,'BackgroundColor'));            
        case 2
        case 3
            figSP.Info=figure('Name','Connect zigbee','MenuBar','none','Toolbar','none','units','normalized',...
                'OuterPosition',[0.3 , 0.4, 0.4, 0.2]);
            InfoText=uicontrol('parent',figSP.Info,'style','text','string','zigbee could not be initializated :-(','units','normalized',...
                'position',[0.15 0.6 0.7 0.3],'fontsize',10);
            uicontrol('parent',figSP.Info,'style','pushbutton','string','OK','units','normalized',...
                'position',[0.35 0.2 0.3 0.3],'callback','closereq; set(MainFig.TgglBttn_CnnctRbt,''value'',0); set(MainFig.RdBttn_CnnctRbt,''value'',0);');
            set(figSP.Info,'Color',get(InfoText,'BackgroundColor'));
            if libisloaded('zigbee')
                calllib('zigbee', 'zgb_terminate');
                unloadlibrary('zigbee')
            end
    end
end