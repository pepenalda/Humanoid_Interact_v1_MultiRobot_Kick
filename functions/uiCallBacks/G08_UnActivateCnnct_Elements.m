function G08_UnActivateCnnct_Elements
global IKTab
global Strct_MainFigure
global Cnnct

if ne(Cnnct.CnnctnType,0)
    switch Cnnct.CnnctnType
        case {1,2}
            close_serial_port;
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
                unloadlibrary('zigbee')
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
    end
    set(Strct_MainFigure.PshBttn_CnnctRbt,'enable','on');
    set(Strct_MainFigure.PshBttn_DisCnnctRbt,'enable','off');
    set(Strct_MainFigure.RdBttn_CnnctRbt,'String','Cnnctn Type');
end