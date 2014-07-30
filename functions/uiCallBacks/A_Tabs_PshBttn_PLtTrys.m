function A_Tabs_PshBttn_PLtTrys
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

if isfield(Strct_MainFigure,'Panel_WalkTab')
    delete(Strct_MainFigure.Panel_WalkTab);
    Strct_MainFigure=rmfield(Strct_MainFigure,'Panel_WalkTab');
end
if exist('WlkTab','var')
    clear global WlkTab
end

A07_PlotsTab

% set(PltTryTab.PpUp_Paso,'enable','off');
% set(PltTryTab.RdBttn_PC,'Value',1);
% set(PltTryTab.RdBttn_Rbt,'Value',0);
% %Panel del Plot
% set(WlkTab.Panel_PLotIK,'Parent',Strct_MainFigure.Panel_PlotsTab);
% set(WlkTab.Panel_PLotIK,'Position',[0.02 0.07 0.35 0.81]);
% PlotBLD_Wlk(WlkTab.Panel_PLotIK);