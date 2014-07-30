function D_MainFig_PshBttn_DisCnnctRbt
global IKTab
global Strct_MainFigure
global Cnnct
global WlkTab
global Robot
if ne(Cnnct.CnnctnType,0)
    switch Cnnct.CnnctnType
        case {1,2}
            if strcmp(Robot.Name,'Bioloid')
                close_serial_port;
            elseif strcmp(Robot.Name,'Nao')
                RobotIP=Cnnct.NaoIP;
                tts = ALTextToSpeechProxy(RobotIP,9559);
                tts.say('Desconectado de');
                tts.setLanguage('English');
                tts.say('Humanoid   Interact');
                tts.setLanguage('Spanish');                
            end
            set(IKTab.PshBttn_GtAngls,'Enable','off');
            set(IKTab.PshBttn_StAngls,'Enable','off');
            set(IKTab.PshBttn_AllTrqsOn,'Enable','off');
            set(IKTab.PshBttn_AllTrqsOff,'Enable','off');
            set(IKTab.RdBttn_IKMvRbt,'Enable','off');
            for i=1:18
                set(IKTab.RdBttn_Art{i},'Enable','off');
            end
            set(Strct_MainFigure.RdBttn_CnnctRbt,'String','Cnnctn Type');
        case 3
            if libisloaded('zigbee')
                calllib('zigbee', 'zgb_terminate');
                unloadlibrary('zigbee');
            end
            for i=1:3
                set(WlkTab.PshBttnMARCHA{i},'Enable','off');
            end
            %             set(WlkTab.uiPnl_RdBttnIKPC,'Value',1);
            %             set(WlkTab.uiPnl_RdBttnIKRobot,'Value',0);
            %             set(WlkTab.uiPnl_RdBttnIKRobot,'Enable','off');
            %             set(WlkTab.PshBttnGUARDAR{1},'Enable','off');
            %             set(WlkTab.PshBttnGUARDAR{2},'Enable','off');
            %             set(Strct_MainFigure.RdBttn_CnnctRbt,'String','Cnnctn Type');
            set(WlkTab.PshBttn_SND_Rbt,'Enable','off');
            set(WlkTab.PshBttn_RCV_Rbt,'Enable','off');
            set(WlkTab.PshBttn_RBT_LD,'Enable','off');
            set(WlkTab.PshBttn_RBT_SV,'Enable','off');
            
    end
    set(Strct_MainFigure.PshBttn_CnnctRbt,'enable','on');
    set(Strct_MainFigure.PshBttn_DisCnnctRbt,'enable','off');
    set(Strct_MainFigure.RdBttn_CnnctRbt,'String','Cnnctn Type');
    Cnnct.CnnctnType=0;
end