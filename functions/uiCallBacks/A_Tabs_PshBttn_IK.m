function A_Tabs_PshBttn_IK

global Strct_MainFigure
global Robot

if isfield(Strct_MainFigure,'Panel_VRMLTab')
    delete(Strct_MainFigure.Panel_VRMLTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_VRMLTab');
end
if exist('VRMLTab','var')
    clear global VRMLTab
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

A05_KinematicsTab;