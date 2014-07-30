function G07_ActivateCnnct_Elements

global Strct_MainFigure
global IKTab 
global WlkTab
global Cnnct
global Robot

switch Cnnct.CnnctnType
    case 1
        set(IKTab.PshBttn_GtAngls,'Enable','on');
        set(IKTab.PshBttn_StAngls,'Enable','on');
        set(IKTab.PshBttn_AllTrqsOn,'Enable','on');
        set(IKTab.PshBttn_AllTrqsOff,'Enable','on');
        set(IKTab.RdBttn_IKMvRbt,'Enable','on');
        for i=1:18
            set(IKTab.RdBttn_Art{i},'Enable','on');
        end
        if strcmp(Robot.Name,'Bioloid')
            StringCnnctType='Toss Mode';
            for i=1:3
                set(WlkTab.PshBttnMARCHA{i},'Enable','on');
            end
        elseif strcmp(Robot.Name,'Nao')
            StringCnnctType='Toss Mode';
        end
    case 2
        disp('not programmed');
        StringCnnctType='Walk Serial';
    case 3
        StringCnnctType='Walk Zigbee';
        for i=1:3
            set(WlkTab.PshBttnMARCHA{i},'Enable','on');
        end
%         set(WlkTab.uiPnl_RdBttnIKPC,'Value',0);
%         set(WlkTab.uiPnl_RdBttnIKRobot,'Value',1);
%         set(WlkTab.uiPnl_RdBttnIKRobot,'Enable','on');
        set(WlkTab.PshBttn_SND_Rbt,'Enable','on');
        set(WlkTab.PshBttn_RCV_Rbt,'Enable','on');
        set(WlkTab.PshBttn_RBT_LD,'Enable','on');
        set(WlkTab.PshBttn_RBT_SV,'Enable','on');
end
set(Strct_MainFigure.PshBttn_CnnctRbt,'enable','off');
set(Strct_MainFigure.PshBttn_DisCnnctRbt,'enable','on');
set(Strct_MainFigure.RdBttn_CnnctRbt,'String',StringCnnctType);
