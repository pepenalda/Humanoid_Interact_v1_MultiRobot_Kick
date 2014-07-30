function E_WlkTab_BttnGrp_ViewsWlk

global Strct_MainFigure
global PltTryTab
global Robot
global vrFigure
global WlkTab


if isfield(Strct_MainFigure,'Panel_WalkTab')
    uiBttnGrp_ViewsWlk=WlkTab.uiBttnGrp_ViewsWlk;
    Eje=WlkTab.Axes;
else
    uiBttnGrp_ViewsWlk=PltTryTab.uiBttnGrp_ViewsWlk;
    Eje=PltTryTab.Axes;
end

selected=get(uiBttnGrp_ViewsWlk,'SelectedObject');
SlctdStrng=get(selected,'String');
axes(Eje);
switch SlctdStrng
    case 'Lateral'
        view(0,0);
        set(vrFigure,'Viewpoint','VPLat') % change viewpoint
    case 'Perspectiva'
        view(59,27);
        set(vrFigure,'Viewpoint','VPPersp') % change viewpoint
    case 'Front'
        view(90,0);
        set(vrFigure,'Viewpoint','VPFront') % change viewpoint
    case 'Upper'
        view(0,90);
        set(vrFigure,'Viewpoint','VPSup') % change viewpoint
end