function A_Tabs_PshBttn_WlkPrm
global Strct_MainFigure

if isfield(Strct_MainFigure,'Panel_VRMLTab')
    delete(Strct_MainFigure.Panel_VRMLTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_VRMLTab');
end
if exist('VRMLTab','var')
    clear global VRMLTab
end

if isfield(Strct_MainFigure,'Panel_KinTab')
    delete(Strct_MainFigure.Panel_KinTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_KinTab');
end
if exist('IKTab','var')
    clear global IKTab
end

if isfield(Strct_MainFigure,'Panel_PlotsTab')
    delete(Strct_MainFigure.Panel_PlotsTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_PlotsTab');
end
if exist('PltTryTab','var')
    clear global PltTryTab
end

A06_WalkTab;
