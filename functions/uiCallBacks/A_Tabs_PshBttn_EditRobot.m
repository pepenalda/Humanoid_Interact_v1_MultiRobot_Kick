function A_Tabs_PshBttn_EditRobot

global Strct_MainFigure
global Robot

if isfield(Strct_MainFigure,'Panel_KinTab')
    delete(Strct_MainFigure.Panel_KinTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_KinTab');
end
if exist('IKTab','var')
    clear global IKTab
end

if Robot.Connectable
    if isfield(Strct_MainFigure,'Panel_WalkTab')
        delete(Strct_MainFigure.Panel_WalkTab);
        Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_WalkTab');
    end
    if exist('WlkTab','var')
        clear global WlkTab
    end
    if isfield(Strct_MainFigure,'Panel_PlotsTab')
        delete(Strct_MainFigure.Panel_PlotsTab);
        Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_PlotsTab');
    end        
    if exist('PltTryTab','var')
        clear global PltTryTab
    end
end

A04_EditVRMLTab; 


